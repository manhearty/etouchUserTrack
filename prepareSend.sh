#!/bin/bash
#Author: MP Nadar
#Purpose: Prepare and Send user reports
#Date: 15th April 2016

dat=$( date +%F )

/usr/bin/ansible-playbook /etc/ansible/googlehostsFilePull.yml 

/bin/bash /home/administrator/merge.sh


if [ -f /tmp/merge/$(date +%F)_merge.csv ]
then

/home/administrator/smtp-cli --host  etouch.net.1.0001.arsmtp.com --from="Manoharan Nadar <mnadar@etouch.net>" \
            --to nmahangade@etouch.net \
            --subject "User report as on: $dat" \
            --body-plain "Report is attached." \
            --attach /tmp/merge/$(date +%F)_merge.csv \
            --attach /tmp/merge/$(date +%F)_sum.csv \
            --cc mnadar@etouch.net \
            --cc rdhoble@etouch.net \
	    --cc sdsouza@etouch.net \
	    --cc jkadu@etouch.net \
            --cc vkawle@etouch.net \
            --cc nbhavani@etouch.net \
            --cc rrayapati@etouch.net

fi

