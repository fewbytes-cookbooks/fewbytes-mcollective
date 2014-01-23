#!/bin/bash 

for collective in mcollective ; do
  rabbitmqadmin declare exchange --user=guest --password=guest --vhost=/ name=${collective}_broadcast type=topic
  rabbitmqadmin declare exchange --user=guest --password=guest --vhost=/ name=${collective}_directed type=direct
done

touch '/tmp/rabbitHome'

#__END__