#!/bin/bash

export HE_Username=""
export HE_Password=""

./acme.sh/acme.sh --issue -d joshuaabbey.com -d *.joshuaabbey.com --dns dns_he \
&& cd .acme.sh/joshuaabbey.com \
&& cat joshuaabbey.com.key fullchain.cer > /etc/ssl/nginx/joshuaabbey.com.pem \
&& cp joshuaabbey.com.key /etc/ssl/nginx/joshuaabbey.com.key \
&& echo "CERT GEN COMPLETE :D" \
&& systemctl reload nginx.service
