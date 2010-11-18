#!/bin/bash
if [[ $1 == "reload" ]]; then
  reload="sudo service apache2 reload"
fi
git push
ssh -t joel@joelcogen.com "cd joelcogen.com/minidoudou; git pull; rake db:migrate; $reload"

