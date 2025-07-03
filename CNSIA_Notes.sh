###BOOK Cloud Native Spring in Action - Catalog Service: Responsible for managing the catalog of books in the Polar Bookshop system ### 

#create project:
curl https://start.spring.io/starter.zip -d groupId=com.cnsia.polarbookshop -d artifactId=catalog-service -d name=catalog-service -d packageName=com.cnsia.polarbookshop.catalogservice -d dependencies=web -d javaVersion=21 -d bootVersion=3.4.1 -d type=gradle-project -o catalog-service.zip

## REST API
|:---------------:|:--------:|:----------:|:------:|:--------------:|:------------------------------------------|
| Endpoint	  | Method   | Req. body  | Status | Resp. body     | Description                               |
|:---------------:|:--------:|:----------:|:------:|:--------------:|:------------------------------------------|
| `/books`        | `GET`    |            | 200    | Book[]         | Get all the books in the catalog.         |
|_________________|__________|____________|________|________________|___________________________________________|
| `/books`        | `POST`   | Book       | 201    | Book           | Add a new book to the catalog.            |
|_________________|__________|____________|________|________________|___________________________________________|
|                 |          |            | 422    |                | A book with the same ISBN already exists. |
|_________________|__________|____________|________|________________|___________________________________________|
| `/books/{isbn}` | `GET`    |            | 200    | Book           | Get the book with the given ISBN.         |
|_________________|__________|____________|________|________________|___________________________________________|
|                 |          |            | 404    |                | No book with the given ISBN exists.       |
|_________________|__________|____________|________|________________|___________________________________________|
| `/books/{isbn}` | `PUT`    | Book       | 200    | Book           | Update the book with the given ISBN.      |
|_________________|__________|____________|________|________________|___________________________________________|
|                 |          |            | 200    | Book           | Create a book with the given ISBN.        |
|_________________|__________|____________|________|________________|___________________________________________|
| `/books/{isbn}` | `DELETE` |            | 204    |                | Delete the book with the given ISBN.      |
|:---------------:|:--------:|:----------:|:------:|:--------------:|:------------------------------------------|

#start a local Kubernetes cluster: 
minikube start

#import local image: 
minikube image load catalog-service:0.0.1-SNAPSHOT

#list the available images: 
minikube image ls --format table

#create a deployment resource from a container image: 
kubectl create deployment catalog-service --image=catalog-service:0.0.1-SNAPSHOT

#check the application logs
kubectl logs deployment/catalog-service

#verify the creation of the Deployment object: 
kubectl get deployment

#verify the creation of the Pod object: 
kubectl get pod

#command to expose a Deployment as a Service - make applications accessible: 
kubectl expose deployment catalog-service --name=catalog-service --port=9001

#verify that the service was create correctly
kubectl get service catalog-service

#forwarding a port from localhost to a Service inside the cluster: 
kubectl port-forward service/catalog-service 8000:9001

#Terminate: 
kubectl delete service catalog-service
kubectl delete deployment catalog-service
minikube image rm  catalog-service:0.0.1-SNAPSHOT
minikube stop

#combines the operations of the bootJar and test tasks: 
./gradlew build

#run the application: 
 ./gradlew bootRun

#compiles the code and packages the application as a JAR file: 
./gradlew bootJar

#Package the application as a container using Buildpack (build the image)
./gradlew bootBuildImage

#run the image / run the image connecting to the catalog-network, set the datasource URL, and set the param profile to load test data.
docker run --rm --name catalog-service -p 9001:9001 catalog-service:0.0.1-SNAPSHOT
docker run -d --name catalog-service --net catalog-network -p 9001:9001 -e SPRING_DATASOURCE_URL=jdbc:postgresql://polar-postgres:5432/polardb_catalog -e SPRING_PROFILES_ACTIVE=testdata catalog-service

#add a book to the catalog: 
http POST :9001/books author="Lyra Silverstar" title="Northern Lights" isbn="1234567891" price=9.90
curl -X POST http://localhost:9001/books -d '{"author": "Lyra Silverstart", "title":"Nothern Lights", "isbn":"1284567891", "price":9.90}' -H "content-type: application/json" -v

#request to fetch the book with the ISBN code: 
 http :9001/books/1234567891

#request to get all books
http :9001/books

#run tests: 
./gradlew test

#run a specific test: 
./gradlew test --tests BookValidationTests
./gradlew test --tests CatalogServiceApplicationTests
./gradlew test --tests BookControllerMvcTests
./gradlew test --tests BookJsonTests
./gradlew test --tests BookServiceTest

#running the application with the prod profile enabled
java -jar build/libs/catalog-service-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

#test the polar.greeting property calling the HomeController object
http :9001/

#trigger a RefreshScopeRefreshedEvent event
http POST :9001/actuator/refresh

#Create Docker DNS Server
docker network create catalog-network

#running PostgreSQL as a container / start a PSQL container specifiying the catalog-network 
docker run -d --name polar-postgres -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_DB=polardb_catalog -p 5432:5432 postgres:16.6
docker run -d --name polar-postgres --net catalog-network -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_DB=polardb_catalog -p 5432:5432 postgres:16.6

#stop, start, and remove the container
docker stop polar-postgres
docker start polar-postgres
docker rm -fv polar-postgres

#Start an interactive PSQL console:
docker exec -it polar-postgres psql -U user -d polardb_catalog

#List all databases
\list

#connect to polar database
\connect polardb_catalog

#list all tables
\dt

#show the table schema
\d book

#Test with Testcontainers
./gradlew test --tests BookRepositoryJdbcTests
./gradlew test --tests CatalogServiceApplicationTests


#Containerizing Spring Boot with Dockerfiles
1. Create  file called Dockerfile in the root folder
2. ./gradlew clean bootJar #build the JAR artifact
3. docker build -t catalog-service . #build the continer image

#GitHub container registry
docker login ghcr.io (PAT - Settings > Developer Settings > Personal access tokens)

#check if the newly created image contains any vulnerability
grype catalog-service

#delete Docker resources
docker rm -f catalog-service polar-postgres
docker network rm catalog-network

#build and publish the image
./gradlew bootBuildImage --imageName ghcr.io/fabiop35/catalog-service --publishImage -PregistryUrl=ghcr.io -PregistryUsername=fabiop35 -PregistryToken=<github_token>

#start the containers in detached mode
docker compose up -d

#stop and remove both containers
docker compose down

############
### CH07 ###
############

#TOOLS#
-curl -s "https://get.sdkman.io" | bash
-Docker: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
-JAVA_HOME=C:\Program Files\Java\graalvm-jdk-21.0.7+8.1\ #To install NetBeans.
-Kubernetes: Appendix A 
-Docker Desktop for Windows (Testcontainers).

#create a new Kubernetes cluster named polar on top of Docker
> minikube start --cpus 2 --memory 4g --driver docker --profile polar
> minikube start --profile polar
> minikube stop --profile polar

#list of all the nodes in the cluster
> kubectl get nodes

#list all the available contexts with which you can interact
> kubectl config get-contexts

#change the current context
> kubectl config use-context polar

#delete  the cluster
> minikube delete --profile polar

> mkdir polar-deployment

#cd polar-deployment/kubernetes/platform/development
#creates the resources defined in the manifests within the services folder.
#This script deploys a PostgreSQL database within a Kubernetes cluster and exposes it as an internal service named polar-postgres on port 5432. 
> kubectl apply -f services
$ kubectl delete -f services
> kubectl get pod

#check logs
> kubectl logs deployment/polar-postgres

#undeploy the database
> kubectl delete -f services

#list all the objects supported by the cluster
> kubectl api-resources

#to check the API version supported by your Kubernetes installation 
> kubectl explain <object_ name> 

#cd catalog-service
> mkdir k8s
> touch deployment.yml 

#minikube doesn’t have access to your local container images, so it will not find the image you have just built for Catalog Service.
#manually import the image into the local cluster
> minikube image load catalog-service --profile polar

#apply Kubernetes manifests to a cluster using the kubectl client. (folder catalog-service). Container: catalog-service
> kubectl apply -f k8s/deployment.yml
$ kubectl delete -f k8s/deployment.yml

#verify which objects have been created
$ kubectl get all -l app=catalog-service

#check the logs from its Deployment
$ kubectl logs deployment/catalog-service

#NOTE You can monitor whether Pods have been created successfully by inspecting the STATUS column when you run kubectl get pods.
$ kubectl get pods

#to get more information about the error
$ kubectl describe pod catalog-service

#When deploying containers in a cloud environment like a Kubernetes cluster, you’ll want to be sure it has enough resources to operate. (now resource default conf).
#We have created a Deployment for a Spring Boot application and run it in your local Kubernetes cluster. But it’s not possible to use it yet, since it’s isolated inside the cluster.

##7.3 Service discovery and load balancing##
#You’ve got the Catalog Service application running as a Pod in your local Kubernetes cluster.
#two important aspects of cloud native systems: service discovery and load balancing.

##7.3.1 Understanding service discovery and load balancing##
#When one service needs to communicate with another, it must be provided with information about where to find it, such as an IP address or a DNS name.
#Interprocess comunication: no service discovery or load balancing. Alpha App is upstream and Beta App is downstream. Beta App is a backing service with respect to Alpha App.
#*Using IP addresses for interprocess communication in the cloud is not an option.
#Service discovery in cloud environments requires a different solution. First, we need to keep track of all the service instances running and store that information in a service registry. Whenever a new instance is created, an entry should be added to the registry. When it’s shut down, it should be removed accordingly. 
#The registry recognizes that multiple instances of the same application can be up and running.  When an application needs to call a backing service, it performs a lookup in the registry to determine which IP address to contact. If multiple instances are available, a load-balancing strategy is applied to distribute the workload across them.

##7.3.2 Client-side service discovery and load balancing##
#Client-side service discovery requires applications to register themselves with a service registry upon startup and unregister when shutting down. Whenever they need to call a backing service, they ask the service registry for an IP address.
#The Spring Cloud project offers a few options for adding client-side service discovery to your Spring applications (Spring Cloud Netflix Eureka, Spring Cloud Consul, Spring Cloud Zookeeper Discovery, Spring Cloud Alibaba Nacos).
#A benefit of such a solution is that your applications have complete control over the load-balancing strategy.
#patterns like hedging: sending the same request to multiple instances to increase the chance one responds correctly within a specific time limit. Client service discovery can help you with that.
#A drawback is that client service discovery assigns more responsibility to developers. Also, it results in one more service to deploy and maintain (the service registry), unless you use PaaS solutions like Azure Spring Apps or VMware Tanzu Application Service, which provide it for you.

##7.3.3 Server-side service discovery and load balancing##

#Server-side service discovery solutions move a lot of responsibility to the deployment platform, so that developers can focus on the business logic and rely on the platform to provide all the necessary functionality for service discovery and load balancing.
#The Kubernetes implementation of this service discovery pattern is based on Service objects. A Service is “an abstract way to expose an application running on a set of Pods as a network service”.
#A Service object is an abstraction targeting a set of Pods (typically using labels) and defining the access policy. When an application needs to contact a Pod exposed by a Service object, it can use the Service name instead of calling the Pod directly.
#The Service name is then resolved to the IP address of the Service itself by a local DNS server running in the Kubernetes Control Plane.
#After resolving the Service name to its IP address, Kubernetes relies on a proxy (called kube-proxy), which intercepts the connection to the Service object and forwards the request to one of the Pods targeted by the Service.
#The proxy knows all the replicas available and adopts a load-balancing strategy depending on the type of Service and the proxy configuration.
#This solution is transparent to your Spring Boot applications.

##7.3.4 Exposing Spring Boot applications with Kubernetes Services##
#There are different types of Services, depending on which access policy you want to enforce for the application. Default: ClusterIP exposes a set of Pods to the cluster.
#Four pieces of information characterize a ClusterIP Service: -selector  -network protocol -port -targetPort. 
#DEFINING A SERVICE MANIFEST WITH YAML - file: catalog-service/k8s/service.yml
  apiVersion: v1
  kind: Service
  metadata:
    name: catalog-service
    labels:
      app: catalog-service
  spec:
    type: ClusterIP
    selector:
      app: catalog-service
    ports:
    - protocol: TCP
      port: 80
      targetPort: 9001
	  
#CREATING A SERVICE OBJECT FROM A MANIFEST  
#apply a Service manifest. Control Plane will create and maintain the Service object in the cluster.
$ kubectl apply -f k8s/service.yml

#verify Service object in the cluster
$ kubectl get svc -l app=catalog-service

#Since it’s of type ClusterIP, the Service makes it possible for other Pods within the cluster to communicate with the Catalog Service application, either using its IP address (called the cluster IP) or through its name.

#expose the application outside the cluster to test it. port-forwarding feature offered by Kubernetes to expose an object (in this case, a Service) to a local machine. 
$ kubectl port-forward service/catalog-service 9001:80
$ netstat -an | grep LISTEN
 #tcp6       0      0 ::1:9001                :::*                    LISTEN
$ http :9001/books

##7.4 Scalability and disposability
#Deploying multiple instances of the same application helps in achieving high availability. When the workload is high, it can be distributed across different replicas. When an instance enters a faulty state and can’t process requests anymore, it can be deleted and a new one created.
#This continuous and dynamic scaling of application instances requires stateless and disposable applications, as per the 15-Factor methodology.

#7.4.1 Ensuring disposability: Fast startup
#cloud native applications should be optimized for starting quickly, taking a few seconds rather than minutes to become ready. Spring Boot is already optimized for fast startup.
#Fast startup is relevant in a cloud environment because applications are disposable and are frequently created, destroyed, and scaled. The quicker the startup, the sooner a new application instance is ready to accept connections. Microservices, are good with a startup time in the range of a few seconds. On the other hand, serverless applications usually require a faster startup phase in the range of milliseconds rather than seconds.
 
#7.4.2 Ensuring disposability: Graceful shutdown
#Having applications start quickly is not enough to address our scalability needs. Whenever an application instance is shut down, it must happen gracefully without clients experiencing downtime or errors. Gracefully shutting down means the application stops accepting new requests, completes all those still in progress, and closes any open resources, like database connections.
#All the embedded servers available in Spring Boot support a graceful shutdown mode, but in slightly different ways.
#By default, Spring Boot stops the server immediately after receiving a termination signal (SIGTERM). You can switch to a graceful mode by configuring the server.shutdown property.
#grace period: how long the application can spend processing all the pending requests. After the grace period expires, the application is terminated even if there are still pending requests.
#file: catalog-service/src/main/resources/application.yml
  server:
	 shutdown: graceful #Enable graceful shutdown
   spring:
      lifecycle:
		imeout-per-shutdown-phase: 15s #Defines a 15 s grace period

#Since we’ve modified the application source code, we need to build a new container image and load it into minikube.
$ ./gradlew bootBuildImage
$ minikube image load catalog-service --profile polar #load the image into the Kubernetes cluster

#find out which image is running
$ kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c

#After enabling application support for graceful shutdown, you need to update the Deployment manifest accordingly. When a Pod has to be terminated Kubernetes sends a SIGTERM signal to it. Spring Boot will intercept that signal and start shutting down gracefully. By default, Kubernetes waits for a grace period of 30 seconds. If the Pod is not terminated after that period, Kubernetes sends a SIGKILL signal to force the Pod’s termination. Since the Spring Boot grace period is lower than the Kubernetes one, the application is in control of when it will terminate.
#When it sends the SIGTERM signal to a Pod, Kubernetes will also inform its own components to stop forwarding requests to the terminating Pod. ince Kubernetes is a distributed system, and the two actions happen in parallel, there is a short time window when the terminating Pod might still receive requests, even if it has already started the graceful shutdown procedure.
#When that happens, those new requests will be rejected, resulting in errors in the clients. Our goal was to make the shutdown procedure transparent to the clients, so that scenario is unacceptable.
#The recommended solution is to delay sending the SIGTERM signal to the Pod so that Kubernetes has enough time to spread the news across the cluster. 
#Technically, the delay can be configured through a preStop hook. File: catalog-service/k8s/deployment.yml
 lifecycle: 
     preStop:
       exec: 
         command: [ "sh", "-c", "sleep 5" ]

#apply the updated version of the Deployment object
$ kubectl apply -f k8s/deployment.yml		 
		 
#7.4.3 Scaling Spring Boot applications #
#Scalability is one of the main properties of a cloud native application. To be scalable, applications should be disposable and stateless, as per the 15-Factor methodology.
#Catalog Service is already a stateless application. It has no state but relies on a stateful service (the PostgreSQL database) to permanently store the data about books. We scale applications in and out, and if they weren’t stateless, we would lose the state every time an instance is shut down.
#The general idea is to keep the applications stateless and rely on data services for storing the state.
#In Kubernetes, replication is handled at the Pod level by a ReplicaSet object. Deployment objects are already configured to use ReplicaSets. All you need to do is specify how many replicas you want to be deployed. File: catalog-service/k8s/deployment.yml		 
  spec:
    replicas: 2 #How many Pod replicas should be deployed

#The replication is controlled using labels. The replication is controlled using labels.
$ kubectl apply -f k8s/deployment.yml
$ kubectl get pods -l app=catalog-service

$ kubectl -n default delete deploy catalog-service
$ kubectl get namespaces
$ kubectl delete svc catalog-service

$ kubectl delete pod catalog-service-769788bb5-4gh8x
#The Deployment manifest declares two replicas as the desired state. Since there is now only one, Kubernetes will immediately step up to ensure the actual state and the desired state are aligned. 
#Under the hood, a ReplicaSet object keeps checking the number of replicas deployed and ensures they are always in the desired state. That’s the basic functionality on top of which you can configure an autoscaler to dynamically increase or decrease the number of Pods, depending on the workload and without having to update the manifest every time.

$ kubectl delete -f k8s
$ kubectl delete -f services

#7.5 Local Kubernetes development with Tilt
#Tilt takes care of many infrastructural concerns and lets you focus more on the business logic of your applications.
#7.5.1 Inner development loop with Tilt
#open source tool that offers features for building, deploying, and managing containerized workloads in your local environment. Automate a development workflow for a specific application, but Tilt can also help you orchestrate the deployment of multiple applications and services in a centralized way. install it in section A.4 of appendix A.

$ brew install tilt-dev/tap/tilt

#Our goal will be to design a workflow that will automate the following steps:
# -Package a Spring Boot application as a container image using Cloud Native Buildpacks.
# -Upload the image to a Kubernetes cluster (in our case, the one created with minikube).
# -Apply all the Kubernetes objects declared in the YAML manifests.
# -Enable the port-forwarding functionality to access applications from your local computer.
# -Give you easy access to the logs from the applications running on the cluster.

$ kubectl apply -f services #Before configuring Tilt, make sure you have a PostgreSQL instance up and running in your local Kubernetes cluster.

$ cd catalog-service
$ touch Tiltfile 
#The file will contain three main configurations.
# -How to build a container image (Cloud Native Buildpacks)
# -How to deploy the application (Kubernetes YAML manifests)
# -How to access the application (port forwarding) 

# Build
custom_build(
    # Name of the container image
    ref = 'catalog-service',
    # Command to build the container image
    command = './gradlew bootBuildImage --imageName $EXPECTED_REF',
    # Files to watch that trigger a new build
    deps = ['build.gradle', 'src']
)
 
# Deploy
k8s_yaml(['k8s/deployment.yml', 'k8s/service.yml'])
 
# Manage
k8s_resource('catalog-service', port_forwards=['9001'])

#The Tiltfile configures Tilt to use the same approach we used throughout the chapter for building, loading, deploying, and publishing applications on the local Kubernetes cluster. It’s all automated now.
$ tilt up --host 0.0.0.0

#Tilt is a convenient GUI where you can keep track of the services managed by Tilt, check application logs, and trigger updates manually. http://localhost:10350
#Tilt will keep the application in sync with the source code. Whenever you make any change to the application, Tilt will trigger an update operation to build and deploy a new container image. All of that happens automatically and continuously.

$ http :9001/books #verify that the application is working correctly

#NOTE Rebuilding the whole container image every time you change something in your code is not very efficient. You can configure Tilt to synchronize only the changed files and upload them into the current image. To achieve that, you can rely on the features offered by Spring Boot DevTools (https://mng.bz/nY8v) and Paketo Buildpacks (https://mng.bz/vo5x).

$ tilt down  #undeploy the application

#7.5.2 Visualizing your Kubernetes workloads with Octant
#When you start deploying multiple applications to a Kubernetes cluster, it can become challenging to manage all the related Kubernetes objects or investigate failures when they happen. There are different solutions for visualizing and managing Kubernetes workloads. http://localhost:7777
$ wget https://github.com/vmware-archive/octant/releases/download/v0.25.1/octant_0.25.1_Linux-64bit.deb
$ sudo dpkg -i octant_0.25.1_Linux-64bit.deb
$ octant --listener-addr 0.0.0.0
$ export OCTANT_LISTENER_ADDR="0.0.0.0:7777"
$ octant

##7.6 Deployment pipeline: Validate Kubernetes manifests
#deployment pipeline and its importance in the continuous delivery approach for delivering software quickly, reliably, and safely. So far we’ve automated the first part of a deployment pipeline: the commit stage. 
#After a developer commits new code to the mainline, this stage goes through build, unit tests, integration tests, static code analysis, and packaging. At the end of this stage, an executable application artifact is published to an artifact repository. That is a release candidate.
#We have deployed Spring Boot applications on Kubernetes using a declarative approach based on resource manifests. They are fundamental to a successful deployment of the release candidate on Kubernetes, so we should guarantee their correctness. This section will show you how to validate Kubernetes manifests as part of the commit stage.

#7.6.1 Validating Kubernetes manifests in the commit stage
#we’ve worked with resource manifests for creating Deployments and Services in a Kubernetes cluster. A manifest is “a specification of a Kubernetes API object in JSON or YAML format.” It specifies “the desired state of an object that Kubernetes will maintain when you apply the manifest”.
#Since a manifest specifies the desired state of an object, we should ensure that our specification complies with the API exposed by Kubernetes. It’s a good idea to automate this validation in the commit stage of a deployment pipeline to get fast feedback in case of errors. (rather than waiting until the acceptance stage, where we need to use those manifests to deploy the application in a Kubernetes cluster). 
$ brew tap instrumenta/instrumenta
$ wget https://github.com/instrumenta/kubeval/releases/download/v0.16.1/kubeval-linux-amd64.tar.gz
$ tar xf kubeval-linux-amd64.tar.gz
$ sudo mv kubeval /usr/local/bin/
$ kubeval --version
#validating Kubernetes manifests against the Kubernetes API
$ kubeval --strict -d k8s/

#7.6.2 Automating Kubernetes manifests validation with GitHub Actions
#GitHub Actions is the workflow engine we used to implement the commit stage for the Catalog Service’s deployment pipeline.
#To implement the validation step, we’ll rely on an action built by Stefan Prodan. He’s the maintainer of FluxCD, a CNCF-incubating project providing a continuous deployment solution on Kubernetes based on the GitOps principles.
#The action lets you install specific versions of useful Kubernetes-related tools.
#include the Kubernetes manifest validation step file: catalog-service/.github/workflows/commit-stage.yml 
...
  - name: Validate Kubernetes manifests 
        uses: stefanprodan/kube-tools@v1  #An action capable of installing useful tools to work with Kubernetes
        with: 
          kubectl: 1.24.3
          kubeval: 0.16.1
          command: | 
            kubeval --strict -d k8s
...			
#After updating the commit-stage.yml file with the additional validation step, you can commit and push your changes to your catalog-service repository on GitHub and verify that the commit stage workflow completes successfully, meaning what you included in the manifests is compliant with the Kubernetes API.

#Summary - CH07#
#Docker works fine when running single-instance containers on a single machine. When your system needs properties like scalability and resilience, you can use Kubernetes.
#Kubernetes provides all the features for scaling containers across a cluster of machines, ensuring resilience both when a container fails and when a machine goes down.
#Pods are the smallest deployable units in Kubernetes.
#Rather than creating Pods directly, you can use a Deployment object to declare the desired state for your applications, and Kubernetes will ensure it matches the actual state. That includes having the desired number of replicas up and running at any time.
#The cloud is a dynamic environment, and the topology keeps changing. Service discovery and load balancing let you dynamically establish interactions between services, managed either on the client side or on the server side.
#Each Service name can be used as a DNS name. Kubernetes will resolve the name to the Service IP address and, ultimately, forward the request to one of the instances available.
#You can deploy Spring Boot applications to a Kubernetes cluster by defining two YAML manifests: one for the Deployment object and one for the Service object.
#The kubectl client lets you create objects from a file with the command kubectl apply -f <your-file.yml>
#Cloud native applications should be disposable (fast startup and graceful shutdown) and stateless (rely on data services for storing the state).
#Kubernetes uses ReplicaSet controllers to replicate your application Pods and keep them running.
#Tilt is a tool that automates your local development workflow with Kubernetes: you work on the application while Tilt takes care of building the image, deploying it to your local Kubernetes cluster, and keeping it up-to-date whenever you change something in the code.
#The Octant dashboard lets you visualize your Kubernetes workloads.
#Octant is a convenient tool that you can use not only for inspecting and troubleshooting a local Kubernetes cluster but also for a remote one.
#Kubeval is a convenient tool you can use to validate Kubernetes manifests. It’s particularly useful when it’s included in your deployment pipeline.















ToDo:
	-push to GitHub the folder polar-postgres
	-Helm
	-migrate existing applications that use one of the client-side service discovery options
	-Tilt(CH07): Synchronize only the changed files and upload them into the current image.
	-Polar Labs(CH07): Config Service
	               -graceful shutdown and a grace period
				   -Deployment and Service manifests for deploying Config Service
				   -Update the commit stage of the deployment pipeline for Config Service to validate the Kubernetes manifests
				   -Configure the Catalog Service Deployment with the Config Service URL via the SPRING_CLOUD_CONFIG_URI environment variable, relying on the Kubernetes native service discovery feature
				   -Configure Tilt to automate the Config Service deployment to your local Kubernetes cluster bootstrapped with minikube
	