# Introduction:
 This is a guide for implementing a Dynamic Auto-Scaling Web Application Deployment with Public IP Display.
  
<br/>

# Explanation:
## ALB (Application Load Balancer):
* **AWS ALB** is a **feature** of **Elastic Load Balancing**.
* **Traffic Distribution**: They automatically distribute traffic to healthy targets (such as: EC2 instances, containers, IP addresses, in one or more Availability Zones (AZs)), improving application availability and responsiveness.
* **Traffic Routing**: It operates at the **application level (Layer 7) of the OSI model**, allowing it to route traffic based on the content of the request, including the host and path.
 
<br/>

## ASG (Auto Scaling Group):
* **AWS ASG** is a key component of **AWS’s scalable infrastructure**.
* **Dynamic Scaling**: **ASGs** can scale out (increase the number of instances) and scale in (decrease the number of instances) based on predefined policies and metrics, such as CPU utilization or network traffic.
* **Launch Configurations and Templates**: These define how new instances are launched, including the AMI (Amazon Machine Image), instance type, and security groups.
* **Traffic Distribution**: **ASGs** automatically register new instances with a **load balancer**, distributing traffic evenly across all instances.
* **Cost Optimization**: You only pay for the **EC2 instances** that are spun up and down, and **ASGs** themselves are free.
* **Monitoring**: You can monitor **ASGs** in the **AWS Management Console** to see instances scaling in and out based on the load.

# Task + Steps:
## Mission: Dynamic Auto-Scaling Web Application Deployment with Public IP Display
### Step 1: Launch Template for EC2 Instances:
* Create a launch template for EC2 instances, <br/>
  Ensure the launch template includes specifications for the instances to have Nginx or Apache installed and properly configured, <br/>
  Include a **userdata script** in the launch template that dynamically fetches the public IP of the instance and updates the **index.html** file with this information.
  - EC2 Dashboard -> Instances -> Launch Templates -> Create:
    - Name, description, AMI ID, Instance type.
    - SSH key pair.
    - Select one of the public subnets. (depends on the **VPC** you're going to use)
    - Create a security group: name, description, inbound rules allowing SSH(22) and HTTP(80), with protocol:TCP and source:Anywhere.
    - EBS volume.
    - in Advanced details -> user data: upload userdata.sh file.
  
### Step 2: Application Load Balancer (ALB):
* Create an Application Load Balancer in a public subnet.
* Configure listeners on ports 80 for http traffic
* Set up target groups for each listener to manage the instances.
### Step 3: Auto Scaling Group (ASG):
* Create an Auto Scaling Group that utilizes the previously defined launch template for launching instances.
* Configure the ASG to automatically attach newly launched instances to the appropriate ALB target groups.
### Step 4: Auto Scaling Policies:
* Implement auto scaling policies based on CPU utilization to dynamically scale the ASG.
* Set up policies to scale the ASG up and down according to the defined CPU thresholds.
### Step 5: Health Checks:
* Configure health checks for the ASG by implementing checks on the application health endpoint of each instance.
* Define criteria for identifying unhealthy instances.
* Configure the ASG to terminate and replace unhealthy instances automatically.
### Step 6: Testing:
* Test the entire setup by generating load on the ALB.
* Verify that the ASG responds dynamically to the increased load by scaling out.
* Confirm that the ASG also scales in automatically when the load decreases.
* Check the index.html file on instances to ensure that it displays the public IP dynamically.

*Author*: [LuciaHeredia](https://github.com/LuciaHeredia)

