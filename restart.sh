sudo /etc/init.d/apache2 restart

within-bundled-project()
{
    local dir="$(pwd)"
    while [ "$(dirname $dir)" != "/" ]; do
        [ -f "$dir/Gemfile" ] && return
        dir="$(dirname $dir)"
    done
    false
}

if within-bundled-project;then
  kill -9 `ps -ef | grep ruby | grep -v grep | awk '{print $2}'`
  nohup bundle exec rake qc:work &
fi