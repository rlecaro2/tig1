#KILL all 'ruby' processes
kill -9 `ps -ef | grep ruby | grep -v grep | awk '{print $2}'`
#restart apache server
sudo /etc/init.d/apache2 restart
#start queue_classic process
nohup bundle exec rake qc:work &
#update crontaba
whenever -c
whenever -w
