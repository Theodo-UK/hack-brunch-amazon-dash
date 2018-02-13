#!/bin/bash
button='fc:a6:67:c5:17:fd'
asleep=false
wakeup_time=0

tcpdump -l -n -i $PIFACE | while read b; do
  if echo $b | grep -q $button ; then
    echo "There is someone at the door" | espeak -v en-sc -a 200
  fi
  if echo $b | grep -q $coffee_button ; then
    curl 'https://api.twilio.com/2010-04-01/Accounts/AC94373b1fa646c4dbdb29f1b82920f4a6/Messages.json' -X POST \
    --data-urlencode 'To=+447547143466' \
    --data-urlencode 'From=+441412806579' \
    --data-urlencode 'Body=ORDER COFFEE ☕️🚨 🚪' \
    -u AC94373b1fa646c4dbdb29f1b82920f4a6:$TWILLIO
    echo "POTENTIAL COFFEE EMERGENCY AVERTED, WILLIAM NOTIFIED." | espeak -v en-sc -a 200
    echo "That was a close one." | espeak -v en-sc -a 200
  fi
done
