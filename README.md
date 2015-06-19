# Description

This repository provides the necessary files to run an EMC ECS multinode cluster in a single Docker container.

It has been tested with ECS 2.0 GA.

This gives anyone the ability to create a clean ECS multinode cluster for test purposes.

You'll need a host with 128 GB of RAM to run this ECS multinode cluster.

*Disclaimer: Don't use this for production.*

# Build

To build the docker images, you just need to run the following command:

```
docker build .
```

This will create a Docker container using the jpetazzo/dind Docker image.

This container will contain all the other files.

# Run

Run the following command to start a container using the image you've just built:

```
./start.sh <image ID>
```

Don't use Ctrl+C because it would kill the Docker service.

You can exit detach the container and use Docker exec to start another bash if you want to avoid this issue.

Run the following command to start the 4 ECS Docker containers inside this Docker container:

```
./run.sh
```

You can then go to /var/log/ecs to see the ECS logs of each node.

If you see in the vnest.log that the different nodes aren't communicating together, it could be because Docker is not using the 10.0.0.0 network. In this case, you can modify the seeds and network.json.* files and rebuild the Docker image.

After approximately 15 minutes, you should be able to access the ECS UI at https://<host>.

You can use the license.xml file in this repository and configure your ECS cluster.

The Storage Pool creation can take some times.

# Licensing

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

# Support

Please file bugs and issues at the Github issues page. For more general discussions you can contact the EMC Code team at <a href="https://groups.google.com/forum/#!forum/emccode-users">Google Groups</a>. The code and documentation are released with no warranties or SLAs and are intended to be supported through a community driven process.
