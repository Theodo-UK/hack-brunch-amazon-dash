#!/bin/bash
button='fc:a6:67:c5:17:fd'
asleep=false
wakeup_time=0



tcpdump -l -n -i $PIFACE | while read b; do
  if ! $asleep ; then
    if echo $b | grep -q $button ; then
      curl 'https://api.twilio.com/2010-04-01/Accounts/AC94373b1fa646c4dbdb29f1b82920f4a6/Messages.json' -X POST \
      --data-urlencode 'To=+447547143466' \
      --data-urlencode 'From=+441412806579' \
      --data-urlencode 'Body=Let Me In TheoDoor! 🚪' \
      -u AC94373b1fa646c4dbdb29f1b82920f4a6:$TWILLIO
    fi
  else
    echo asleep
  fi
done
