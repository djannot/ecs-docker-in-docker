for i in {2..63}; do if [ -e /dev/loop$i ]; then continue; fi; \
mknod /dev/loop$i b 7 $i; chown --reference=/dev/loop0 /dev/loop$i; \
chmod --reference=/dev/loop0 /dev/loop$i; done
sysctl -w kernel.pid_max=655360
docker run --privileged -t -i -p 443:443 -p 4443:4443 -p 8443:8443-p 9020:9020 -p 9021:9021 -p 9022:9022 -p 9023:9023 -p 9024:9024 -p 9025:9025 $1
