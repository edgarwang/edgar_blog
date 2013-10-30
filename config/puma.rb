threads 4,32
workers 2
bind "unix://APP_ROOT/tmp/socks/puma.sock"

pidfile "APP_ROOT/tmp/pids/puma.pid"
state_path "APP_ROOT/tmp/pids/puma.state"
daemonize true 
preload_app!
