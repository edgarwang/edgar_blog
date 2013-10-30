threads 4,16
workers 2
bind "unix://RAILS_ROOT/tmp/socks/puma.sock"

pidfile "RAILS_ROOT/tmp/pids/puma.pid"
state_path "RAILS_ROOT/tmp/pids/puma.state"
daemonize true 
preload_app!
