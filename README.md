# Inception
This project was developed for 42 school. For comprehensive information regarding the requirements, please consult the PDF file in the subject folder of the repository. Furthermore, I have provided my notes and a concise summary below.
``` diff
+ keywords: docker
+ set up small infrastructure composed of different services
+ project done in a virtual machine
+ it must be used docker compose
```

## High-level Overview

Each Docker image must have the same name as its corresponding service. Each service has to run in a dedicated container.
For performance matters, the containers must be built either from the penultimate stable version of Alpine or Debian.
Write your own Dockerfiles, one per service.

You then have to set up:
• A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
• A Docker container that contains WordPress + php-fpm (it must be installed and
configured) only without nginx.
• A Docker container that contains MariaDB only without nginx.
• A volume that contains your WordPress database.
• A second volume that contains your WordPress website files.
• A docker-network that establishes the connection between your containers.
Your containers have to restart in case of a crash.

### References:
[Virtual Machine (VM) vs Docker](https://www.youtube.com/watch?v=a1M_thDTqmU)<br />
[What are Microservices?](https://www.youtube.com/watch?v=CdBtNQZH8a4)<br />
[Containerization Explained](https://www.youtube.com/watch?v=0qotVMX-J5s)<br />
[Contain Yourself: An Intro to Docker and Containers by Nicola Kabar and Mano Marks](https://www.youtube.com/watch?v=arRDKrVGw7k&t=833s)<br />

## Concepts

| Task | Prototype | Description |
|:----|:-----:|:--------:|
| **VM && docker** | `abstraction layer`| Software is used to create an abstraction layer(virtualization). |
| **Virtual machine** | `Hypervisor` | Virtual machine emulates the physical computer, managing the allocation of resources (virtual hardware, virtual CPU, guest OS, etc) from a single physical host. **Benefits:** diverse OS, isolation/separated kernel and OS, set environment for running legacy applications. **Downsides:** deploy a separated guest OS everytime you create a VM, binary library, etc, even for a small application. It takes a lot of resources. **host OS - hypervisor - guest OS** |
| **Containerization** | `Operating System virtualization` | Instead of hardware level, it is an OS virtualization abstraction level. Each application lightweight, isolated, runnable, and portable. New way to package *EVERYTHING* that an app needs to run, regardless of running it in a local or production environment (a.k.a no matter which underlying infrastructure). Example: if you developed your app locally, using the Docker platform, expect it to be successfully deployed. No matter what is the underlying infrastructure. As long as there is a docker engine running on the other side (operation infrastructure using any cloud: AWS, Google, Microsoft, open stack cloud) your application is going to be successfylly deployed there. Running with the exact same behaviour you architectured it to be. |
| **Docker** | `Containerization` `built around client server architecture` | Open source platform that uses containerization. Package of application and dependencies into lightweight containers. An individual container has only the application and its libraries and dependencies. **Benefits:** Microservices, speed development/deployment/scale up, CI/CD pipelines, resource efficiency/small footprint. **host OS - runtime engine - don't worry about guest OS - container/libs**. Shared resources: if it is not being used by the service, share resources with the other containers. |
| **Docker engine** | `orchestrating containers` | Creating, running and orchestrating containers (building - shipping - deploying - managing). Interact with host kernel to allocate resources and force isolation between containers. **Control groups, namespaces**: restrict access and visibility to others. |
| **Docker image** | `executable packages` | Runtime code/libraries/tools/lightweight standalone, static files. Executable packages, which are built using **Dockerfile**. *TEMPLATE* in which containers are built from. |
| **Docker container** | `isolated environment` | Instances of the docker images, running in the docker engine. Isolated in a self-sufficient environment. |
| **Dockerfile** | `manifest` | Instructions for building the images. A manifest describes de container, in docker world it would be the Dockerfile (but please remember that containerization concept was created in 2008 before docker existed - released in 2013). **manifest - image - container** |
| **Microservices** | `modular application architecture` | Every app function is its own service running in a container. Services communicate via API, in a modular and more flexible way: you can use different languages/frameworks, deploy it fast, if one service fails/crash the rest continue to run in an independent way. It is also possible to add capability to a specific service that is more required e.g. payment service for a webside selling ticket to the final game. |
| **Monolith** | `rigid application architecture` | You are a dependent on decisions made in the past(language/framework, libraries). Over time it is difficult to grow: what are the dependencies and relationship between the different parts of the software? For deploying it you will have to shut down the app and deploy everything again (sometimes a second instance of the whole application), it takes a long time. |
| **bare metal** | `bare machine` | Refers to a computer executing instructions directly on logic hardware without an intervening operating system. |


