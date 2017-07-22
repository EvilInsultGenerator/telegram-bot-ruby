#!/bin/bash
while sleep 60
do
if pgrep -f bin/bot >/dev/null
then
	echo "works" >/dev/null 2>&1 
else
 ruby /home/ubuntu/marvinlozano/bin/bot>>/home/ubuntu/marvinlozano/bot.log 2>&1 &!
fi
done

