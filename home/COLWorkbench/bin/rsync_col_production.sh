#!/bin/sh
#Synchronizes var/www/col directory on the production servers (salx9-vm1:var/www/col/, 
#salx9-vm5:var/www/col/ and salx13-vm1:var/www/col/)
#ssh keys have been already exchanged with sal9-vm1 (134.225.65.241), salx9-vm5 (134.225.65.245),
# salx13-vm1 (134.225.65.225) therefore no 
#password will be required

rsync -avz /var/www/col/ root@134.225.65.248:/var/www/col/

exit