**Design Pattern:**

Used nested stacks in a design pattern that promotes modularity, reusability, and manageability of your infrastructure templates. Nested stacks enable you to break down a complex CloudFormation template into smaller, more manageable units, each representing a specific component or aspect of your infrastructure currently used in VPC deployment.


**The directory consists of a set of nested templates that deploy the following:**

1. A tiered VPC with public and private subnets, spanning an AWS region.
2. A self-healing arc deployed across multi Availability Zones in an Auto Scaling group.
3. Two NAT gateways to handle outbound traffic.

**Template details:**

    The templates below are included in this directory and reference architecture:

|           **Template**           |                            **Description**                                         |
| ---------------------------------| -----------------------------------------------------------------------------------|
| master.yml                       | This is the master template - deploy it to CloudFormation and                      | 
|                                  |  it includes all of the nested templates.                                          |
| infrastructure/vpc-iam.yml       | This template deploys will create policy to allow EC2 instance                     |
|                                  |  full access to S3 & CloudWatch, and VPC Logs to CloudWatch.                       |
| infrastructure/vpc-vpc.yml       | This template deploys a VPC with a pair of public and private subnets              |
|                                  | spread across two AZs. It deploys on IGW with a default route on the               |
|                                  | public subnets. It deploys 2 NAT GWs and default routes for then in private subnets|
| infrastructure/security_group.yml| Security Group configured for SSH, Web Server, Database.                           |


Nested stack approach has been used to configure VPC on AWS. In Nested stack master file named master.yml is deploy to create stack on cloudformation where as other files are stored in S3 bucket encrypted and versioning enabled. When master.yml(parent/root yml) file deployed on cloudformation the master file fetches code from s3 bucket based on s3 template URL. On the basis of s3 template URL cloudformation deploys the stack.

*   In Parent stack dependencies used to create stack in Order. First it will create IAM role after successfull completion of IAM stack then, 
    it will deploy VPC stack after that SecurityGroup Stack will be deployed in order.

*   Layer 3 (Network Layer):
    At the network layer, you can implement security measures such as Network ACLs (Access Control Lists) and Security Groups to control traffic flow between subnets and instances within your VPC.
    In a three-tiered architecture, you might configure Network ACLs to restrict traffic between tiers based on IP addresses, ports, or protocols.
*   Layer 4 (Transport Layer):
    Security Groups operate at the transport layer (Layer 4) of the OSI model. You can configure security groups to control inbound and outbound traffic to EC2 instances or other resources based on protocol, port, and source/destination IP.
    For example, you can define security group rules to allow HTTP traffic (port 80) only from the presentation tier to the application tier.
*   Layer 7 (Application Layer):
    At the application layer, you can implement additional security measures such as AWS WAF (Web Application Firewall) to protect your web applications from common web exploits.
    AWS WAF allows you to create rules to filter HTTP and HTTPS requests based on various criteria such as IP address, request headers, and URI strings.


This set of templates deploys the following network design:


| **Item**        | **CIDR Range**  | **Usable IPs**  |
| --------------- | --------------- | --------------- |
| VPC             | 10.0.0.0/16     | 65,536          |
| Public Subnet 1 | 10.0.1.0/24     | 251             |
| Public Subnet 2 | 10.0.2.0/24     | 251             |
| Private Subent 1| 10.0.3.0/24     | 251             |
| Private Subnet 2| 10.0.4.0/24     | 251             |
