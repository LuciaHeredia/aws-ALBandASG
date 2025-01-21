# Explanation:
## ALB:

## ASG:

<br/>

# Tasks + Steps:
## Mission: Dynamic Auto-Scaling Web Application Deployment with Public IP Display
### Step 1: Launch Template for EC2 Instances:
* Create a launch template for EC2 instances.
* Ensure that the launch template includes specifications for the instances to have Nginx or Apache installed and properly configured.
* Include a user data script in the launch template that dynamically fetches the public IP of the instance and updates the index.html file with this information.
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
