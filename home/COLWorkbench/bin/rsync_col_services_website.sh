#!/bin/sh
#Synchronizes var/www/services directory on the websites server (salx9-vm8:var/www/services)
#ssh keys have been already exchanged with sal9-vm8, therefore no password will be required

rsync -avz /var/www/services/ root@134.225.65.248:/var/www/services/

exit