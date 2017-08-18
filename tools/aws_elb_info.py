#!/usr/bin/python
#
# Author: Alan Evans <aevans3@mmm.com>
#

import csv
import sys
import boto3
import yaml
import os.path
import optparse

NoAliasDumper = yaml.dumper.SafeDumper
NoAliasDumper.ignore_aliases = lambda self, data: True

def get_certificate(acm, arn):
    if not arn:
        return {}
    else:
        return acm.describe_certificate(CertificateArn=arn).get('Certificate',{})

def main(args):

    parser = optparse.OptionParser()
    parser.add_option('--region', default='us-east-1', help='AWS Region default: %default')
    parser.add_option('--profile', default='default', help='AWS Profile default: %default')
    parser.add_option('--outfile', default='-', help='Output file, default: STDOUT')

    options, args = parser.parse_args(args)

    session = boto3.Session(profile_name=options.profile, region_name=options.region)
    elb = session.client('elb')
    acm = session.client('acm')

    headers ="""
        Type
        Name
        DNSName
        Instances
        LoadBalancerPort
        InstancePort
        SSLCertificateId
        Policies
        SSLPolicy
        SSLReferencePolicy
        CertSubject
        CertStatus
        CertDomainName
        CertNotBefore
        CertNotAfter
        CertKeyAlgorithm
        CertInUseBy
        CertSignatureAlgorithm
        CertCreatedAt
        CertIssuedAt
        CertSerial
        CertIssuer
        CertError
        """.split()

    if options.outfile in ('-', ''):
        outfile = sys.stdout
    else:
        outfile = open(options.outfile, 'w')

    csvwriter = csv.DictWriter(outfile, fieldnames=headers)
    csvwriter.writeheader()

    for lb in elb.describe_load_balancers()['LoadBalancerDescriptions']:
        for listener in lb['ListenerDescriptions']:
            row = {}
            row['Type'] = lb['Scheme']
            row['Name'] = lb['LoadBalancerName']
            row['DNSName'] = lb['DNSName']
            row['Instances'] = ','.join([i['InstanceId'] for i in lb.get('Instances',[])])
            row['LoadBalancerPort'] = listener.get('Listener', {}).get('LoadBalancerPort','')
            row['InstancePort'] = listener.get('Listener', {}).get('InstancePort','')
            row['SSLCertificateId'] = listener.get('Listener', {}).get('SSLCertificateId','')
            row['SSLPolicy'] = ''
            row['SSLReferencePolicy'] = ''
            row['Policies'] = ','.join(listener.get('PolicyNames',[])[0:])

            try:
                cert = get_certificate(acm,row['SSLCertificateId'])
                for key,value in cert.iteritems():
                    key = 'Cert' + key
                    if key in headers:
                        if type(value) == list:
                            row[key] = ','.join(value)
                        else:
                            row[key] = str(value)
            except Exception, e:
                row['CertError'] = e

            newattrs = {}

            if 'PolicyNames' in listener and len(listener['PolicyNames']) > 0:
                policies = elb.describe_load_balancer_policies(LoadBalancerName=lb['LoadBalancerName'], PolicyNames=listener.get('PolicyNames', [])).get('PolicyDescriptions')

                for policy in policies:
                    if policy['PolicyTypeName'] == 'SSLNegotiationPolicyType':
                        row['SSLPolicy'] = policy['PolicyName']

                        for attr in policy.get('PolicyAttributeDescriptions'):
                            if attr['AttributeName'] == 'Reference-Security-Policy':
                                row['SSLReferencePolicy'] = attr['AttributeValue']
                                break

            csvwriter.writerow(row)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
