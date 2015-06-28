update-ca-certificates
mkdir /disks
mkdir /files
for i in {1..4}; do
  mkdir /disks/$i
  mkdir /files/$i
  for j in {1..5}; do
    l=`echo $j | tr 12345 bcdef`
    truncate -s 100G /files/$i/$j
    mknod /dev/loop$i$j b 7 $i$j
    chown --reference=/dev/loop0 /dev/loop$i$j
    chmod --reference=/dev/loop0 /dev/loop$i$j
    losetup /dev/loop$i$j /files/$i/$j
    mkfs.xfs -f /dev/loop$i$j
    mkdir /disks/$i/uuid-sd${l}1
    mount /dev/loop$i$j /disks/$i/uuid-sd${l}1
    /additional-prep.sh /dev/loop$i$j
    rm /disks/$i/uuid-sd${l}1/0009
  done
done
chmod -R 777 /disks

docker run -d -e SS_GENCONFIG=1 --name=ecs1 --hostname=ecs1.localdomain -p 80:80 -p 443:443 -p 4443:4443 -p 8443:8443 -p 9020:9020 -p 9021:9021 -p 9022:9022 -p 9023:9023 -p 9024:9024 -p 9025:9025 -v /network.json.10.0.0.1:/host/data/network.json -v /seeds:/host/files/seeds -v /partitions.json:/data/partitions.json -v /disks/1:/disks -v /var/log/ecs/1:/opt/storageos/logs emccode/ecsobjectsw:v2.0
sleep 5
docker exec -i -t ecs1 chmod -R 777 /host
docker run -d -e SS_GENCONFIG=1 --name=ecs2 --hostname=ecs2.localdomain -v /network.json.10.0.0.2:/host/data/network.json -v /seeds:/host/files/seeds -v /partitions.json:/data/partitions.json -v /disks/2:/disks -v /var/log/ecs/2:/opt/storageos/logs emccode/ecsobjectsw:v2.0
sleep 5
docker exec -i -t ecs2 chmod -R 777 /host
docker run -d -e SS_GENCONFIG=1 --name=ecs3 --hostname=ecs3.localdomain -v /network.json.10.0.0.3:/host/data/network.json -v /seeds:/host/files/seeds -v /partitions.json:/data/partitions.json -v /disks/3:/disks -v /var/log/ecs/3:/opt/storageos/logs emccode/ecsobjectsw:v2.0
sleep 5
docker exec -i -t ecs3 chmod -R 777 /host
docker run -d -e SS_GENCONFIG=1 --name=ecs4 --hostname=ecs4.localdomain -v /network.json.10.0.0.4:/host/data/network.json -v /seeds:/host/files/seeds -v /partitions.json:/data/partitions.json -v /disks/4:/disks -v /var/log/ecs/4:/opt/storageos/logs emccode/ecsobjectsw:v2.0
sleep 5
docker exec -i -t ecs4 chmod -R 777 /host
