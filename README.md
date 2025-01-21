# Introduction:
 This is a guide for implementing a Dynamic Auto-Scaling Web Application Deployment with Public IP Display.
  
<br/>

# Explanation:
## ALB (Application Load Balancer):
* **AWS ALB** is a **feature** of **Elastic Load Balancing**.
* **Traffic Distribution**: They automatically distribute traffic to healthy targets (such as: EC2 instances, containers, IP addresses, in one or more Availability Zones (AZs)), improving application availability and responsiveness.
* **Traffic Routing**: It operates at the **application level (Layer 7) of the OSI model**, allowing it to route traffic based on the content of the request, including the host and path.

## ASG (Auto Scaling Group):
* **AWS ASG** is a key component of **AWS’s scalable infrastructure**.
* **Dynamic Scaling**: **ASGs** can scale out (increase the number of instances) and scale in (decrease the number of instances) based on predefined policies and metrics, such as CPU utilization or network traffic.
* **Launch Configurations and Templates**: These define how new instances are launched, including the AMI (Amazon Machine Image), instance type, and security groups.
* **Traffic Distribution**: **ASGs** automatically register new instances with a **load balancer**, distributing traffic evenly across all instances.
* **Cost Optimization**: You only pay for the **EC2 instances** that are spun up and down, and **ASGs** themselves are free.
* **Monitoring**: You can monitor **ASGs** in the **AWS Management Console** to see instances scaling in and out based on the load.

<br/>

# Task + Steps:
## Mission: Dynamic Auto-Scaling Web Application Deployment with Public IP Display
### Step 1: Launch Template for EC2 Instances:
* Create a launch template for EC2 instances, <br/>
  Ensure the launch template includes specifications for the instances to have Nginx or Apache installed and properly configured, <br/>
  Include a **userdata script** in the launch template that dynamically fetches the public IP of the instance and updates the **index.html** file with this information.
  - EC2 Dashboard -> Instances -> Launch Templates -> Create and Set:
    - Name, description, AMI ID, Instance type.
    - SSH key pair.
    - Select one of the public subnets. (depends on the **VPC** you're going to use)
    - Create a security group: name, description, inbound rules allowing SSH(22) and HTTP(80), with protocol:TCP and source:Anywhere.
    - EBS volume.
    - In "Advanced details" -> "user data": upload [userdata.sh](https://github.com/LuciaHeredia/aws-ALBandASG/blob/main/userdata.sh) file.
    - Press: Create.
### Step 2: Application Load Balancer (ALB):
* Create an Application Load Balancer in a public subnet, <br/>
  Configure listeners on ports 80 for http traffic, <br/>
  Set up target groups for each listener to manage the instances:
  - EC2 Dashboard -> Load Balancing -> Load Balancers -> Create -> Application Load Balancer -> Create and Set:
    - Name.
    - VPC, Availability Zones, Security group as above.
    - In "Listeners and routing", add listener for HTTP(80), create **target group**: target type:instances, name, protocol HTTP(80), your VPC.
    - Press: Create.
### Step 3: Auto Scaling Group (ASG):
* Create an **ASG** that utilizes the previously defined **launch template** for launching instances,
  Configure the **ASG** to automatically attach newly launched instances to the appropriate **ALB target groups**:
  - EC2 Dashboard -> Auto Scaling -> Auto Scaling Groups -> Create and Set:
    - Name.
    - Launch template that we created.
    - VPC, Availability Zones and subnets.
    - Load balancing -> Attach to an existing load balancer -> Choose from your load balancer target groups.
* Implement **auto scaling policies** based on CPU utilization to dynamically scale the ASG, <br/>
  Set up policies to scale the ASG up and down according to the defined CPU thresholds:
  - Continue **ASG** setup:
    - In "Group size" -> Desired capacity:2.
    - In "Scaling" -> Automatic scaling -> Target tracking scaling policy -> Metric type:Avg CPU utilization, Target value:30.
    - In "Additional settings" -> Monitoring -> Enable group metrics collection within CloudWatch.
* Configure **health checks** for the ASG by implementing checks on the application health endpoint of each instance, <br/>
  Define criteria for identifying unhealthy instances, <br/>
  Configure the ASG to terminate and replace unhealthy instances automatically:
  - Continue **ASG** setup:
    - In "Health checks" -> Turn on Elastic Load Balancing
    - Press: Create.
### Step 4: Testing:
* Test the entire setup by generating load on the ALB.
* Verify that the ASG responds dynamically to the increased load by scaling out.
* Confirm that the ASG also scales in automatically when the load decreases.
* Check the index.html file on instances to ensure that it displays the public IP dynamically.

*Author*: [LuciaHeredia](https://github.com/LuciaHeredia)

