#!/bin/bash
#default user-data script
#allow tty so we can sudo

sed -i 's/requiretty/\!requiretty/g' /etc/sudoers

/etc/init.d/sendmail stop
chkconfig sendmail off

exit 0;
