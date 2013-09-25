# Supervisord auto-start
#
# description: Auto-starts supervisord
# processname: supervisord
# pidfile: /var/run/supervisord.pid

PATH=/sbin:/usr/sbin:/bin:/usr/bin
NAME=supervisord
DESC="supervisod is a system for controlling process state"
SUPERVISORD=/usr/local/bin/supervisord
SUPERVISORCTL=/usr/local/bin/supervisorctl
SCRIPTNAME=/etc/init.d/$NAME


# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions


do_start()
{
    # Return
    #   0 if daemon has been started
    #   1 if daemon was already running
    #   2 if daemon could not be started

    if $SUPERVISORCTL status | grep -q "unix:///tmp/supervisor.sock no such file"; then
        $SUPERVISORD
        echo "supervisord started successfully"
        return 0
    fi

    if $SUPERVISORCTL status | grep -qv "unix:///tmp/supervisor.sock no such file"; then
        echo "supervisord is already running"
        return 1
    fi

    echo "could not start supervisord"
    return 2
}

do_stop() {
    # Return
    #   0 if daemon has been stopped
    #   1 if daemon was already stopped
    #   2 if daemon could not be stopped
    #   other if a failure occurred
    if $SUPERVISORCTL status | grep -q "unix:///tmp/supervisor.sock no such file"; then
        echo "supervisord already stopped"
        return 1
    else
        if $SUPERVISORCTL shutdown | grep -q "Shut down"; then
            while $SUPERVISORCTL shutdown | grep -q "already shutting down"
            do
                sleep 1
            done
            echo 'supervisor shutdown successfully'
            return 0
        else
            echo "could not stop supervisord"
            return 2
        fi
    fi
}

do_status() {
    if $SUPERVISORCTL status; then
        $SUPERVISORCTL status
        echo
        return 3
    fi
}

case "$1" in
  start)
    [ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
    do_start
    case "$?" in
        0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
        2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
    ;;
  stop)
    [ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
    do_stop
    case "$?" in
        0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
        2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
    ;;
  status)
    do_status
    exit $?
    ;;
  restart|force-reload)
    #
    # If the "reload" option is implemented then remove the
    # 'force-reload' alias
    #
    log_daemon_msg "Restarting $NAME"
    do_stop
    case "$?" in
      0|1)
        do_start
        case "$?" in
            0) log_end_msg 0 ;;
            1) log_end_msg 1 ;; # Old process is still running
            *) log_end_msg 1 ;; # Failed to start
        esac
        ;;
      *)
        # Failed to stop
        log_end_msg 1
        ;;
    esac
    ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
    exit 3
    ;;
esac

: