# Load balancing & Autoscaling

## Timings

45 - 90 Minutes

## Includes

* The power of immutability
* Load balancing
* High Availbility
* Autoscaling

A load balancer is a device that acts as a reverse proxy and distributes network or application traffic across a number of servers. Load balancers are used to increase capacity (concurrent users) and reliability of applications. They improve the overall performance of applications by decreasing the burden on servers associated with managing and maintaining application and network sessions, as well as by performing application-specific tasks.

Load balancers are generally grouped into two categories: Layer 4 and Layer 7. Layer 4 load balancers act upon data found in network and transport layer protocols (IP, TCP, FTP, UDP). Layer 7 load balancers distribute requests based upon data found in application layer protocols such as HTTP.

Requests are received by both types of load balancers and they are distributed to a particular server based on a configured algorithm. Some industry standard algorithms are:

Round robin
Weighted round robin
Least connections
Least response time

Layer 7 load balancers can further distribute requests based on application specific data such as HTTP headers, cookies, or data within the application message itself, such as the value of a specific parameter.

Load balancers ensure reliability and availability by monitoring the "health" of applications and only sending requests to servers and applications that can respond in a timely manner.

There are two key reasons why local load balancing is a must:

To achieve high availability that’s sustainable as you grow. You need at least two backend servers for high availability, and your load balancer will ensure that if one backend isn’t functioning, the traffic will be directed to the other backend. I’m going to focus on HTTP here, but this holds true for mail servers or anything that answers traffic coming in on TCP or that pulls items off a backend work queue.

To put a control point in front of your services. This benefit doesn’t really have anything to do with balancing or distributing the load. In fact, even if you had a service with a single backend, you’d still want a load balancer. Having a control point enables you to change backends during deploys, to add filtering rules, and to generally manage how your traffic flows. It gives you the ability to change how your service is implemented on the backend without exposing those changes to the people who consume your service on the frontend. That could be an external customer, an internal user, or even another service in the data center.


## Creating a load balancer

Notice at this point we have load balancers that can operate at different levels of the OSI model.

Application Load Balancer = layers 7
Network Load balancer = layer 4 ( technically not named correctly )
Classic load balancer = Layer 4 ( older. soon to be deprecated )

At higher levels of the OSI you get access to more info but it's slower as more has to be decoded.

So higher = more complex rules but slower

layer 7 for example can distribute traffic based on a request param.
layer 4 can only distribute traffic based on port and ip.

We'll create a simple network lb

Choose network LB
give it a name
choose internet facing
Choose your VPC
Choose you app subnet
Do not choose an elastic IP

Create new target group
protocol TCP
port 80
target type instance
health checks TCP
look at advanced health check settings but don't change

do not select any instances. Just the target group.

Anything we now launch in to this target group will be used by the load balancer.

## Autoscaling Groups

Click launch configurations
Create launch configuration
My AMIs
Choose the AMI for your application that you created with packer
Give it a name
Open advanced config and add user data

```
#!/bin/bash

cd /home/ubuntu/app
pm2 start app.js
```
> NOTE: The #!/bin/bash is required. It will not be treated as a file otherwise and will not be run.

Choose, do not assign public ip. not needed anymore.

Choose your app security group
Proceed without a key pair ( not needed )
Create an autoscaling group using this configuration ( click )
Start with 1 instance
Keep this group at initial size
No notifications
Tags -> Name = app-yourname

Click done

You instances will now be launched in to your target group.

## Summary

You just learned:

	* The benefits of an ELB and an ASG for redundancies
	* How to create and ASG
	* How to create and ELB
