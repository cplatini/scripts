###########################################
# FUNCTION: do_cleanup()
# DESCRIPTION: trap exit signals and clean-up
###########################################
# Catching a signal (128 + n)
# define SIGHUP     1    /* Hangup, generated when terminal disconnects */
# define SIGINT     2    /* Terminal interrupt, generated from terminal special char */
# define SIGQUIT    3    /* (*) Terminal quit, generated from terminal special char */
# define SIGTERM    15   /* (*) Software termination signal (sent by kill by default). */
read -d '' traplist <<__TRAPLIST__
SIGHUP
SIGINT
SIGQUIT
SIGTERM
__TRAPLIST__
# Cleanup function for after trapping
function do_cleanup()
{
    # rm /tmp/holdpid.$pid*;
    # nova delete
    echo -e "Script: $0"
    echo -e "[ CLEANING UP ] Exiting. "
    return $?
}
# Handle trapped SIGNALS
function c_traps() {
    # We've trapped soemthing
    # echo "Last Command: $BASH_COMMAND"
    echo -e "\nSIG Detected. "
    # Do clean-up operations
    do_cleanup
    exit $?
}
# On interruption
trap "c_traps" ${traplist}
trap -- "echo [ EXIT ]" EXIT