app_root = "#{ENV["RAILS_ROOT"]}/current"

threads 4,32
workers 2
bind "unix://#{app_root}/tmp/socks/puma.sock"

pidfile "#{app_root}/tmp/pids/puma.pid"
state_path "#{app_root}/tmp/pids/puma.state"
daemonize true 
preload_app!
