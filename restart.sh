kill -9 `ps -ef | grep ruby | grep -v grep | awk '{print $2}'`

sudo /etc/init.d/apache2 restart

nohup bundle exec rake qc:work &
