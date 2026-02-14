## <p style="text-align:center">🔒 VPC Peering across regions (Same Account) using Terraform </p>

Enabled secure, private cross-region communication between **Primary VPC** and **Secondary VPC** on AWS (same account) using **VPC Peering** and **Terraform**.

---

### 📌 Overview:

This project demonstrates how to enable **secure, private, cross-region communication** between two isolated VPCs (**Primary VPC** and **Secondary VPC**) using **VPC Peering** and **Terraform as Infrastructure as Code (IaC)**.

A **Jumpbox (bastion host)** is used for secure administrative access, following AWS best practices by preventing direct SSH access to private EC2 instances.

---

### Live Demo:

Established SSH connection to Jumpbox using SSH agent forwarding

![Jumpbox](./screenshots/jumbox.png)

Connected from Jumpbox to a private EC2 instance (**Primary VPC**) using the same SSH key

![Jumpbox to App](./screenshots/jumbox-to-app.png)

Pinged private EC2 instance in **Secondary VPC** from private EC2 instance in **Primary VPC**

![Primary to Secondary](./screenshots/prim-app-ins-to-sec-app-ins.png)

Pinged private EC2 instance in **Primary VPC** from private EC2 instance in **Secondary VPC**

![Secondary to Primary](./screenshots/sec-app-ins-to-prim-app-ins.png)

---

### Architecture Diagram:

![architecture diagram](./screenshots/diagram.png)

---

### 🚀 Key Features:

- Two VPCs deployed in different AWS regions within the same account  
- Cross-region VPC Peering connection between Primary and Secondary VPC  
- Private EC2 instances deployed in isolated application subnets  
- Route table configuration enabling inter-VPC communication  
- Security group rules controlling service-to-service traffic  
- Jumpbox (bastion host) for secure administrative access  
- Terraform-based infrastructure provisioning (Infrastructure as Code)  
- Reusable Terraform modules for networking components  
- Remote Terraform state management using Amazon S3  

---

### 🚧 Challenges:

- Debugged Jumpbox SSH connectivity issues and fixed them by correcting Terraform HCL function path logic
- Resolved Terraform state conflicts across teams using remote state locking
- Reduced VPC networking code duplication by designing reusable Terraform modules

---

### 🎯 Learning Objectives:

- Understand why separate VPCs cannot communicate privately by default
- Learn how to enable private cross-region communication using VPC Peering
- Gain hands-on experience writing Terraform to provision AWS networking components
- Implement least-privilege network security for service-to-service communication

---

### 👨‍💻 Connect with me:

**Ibrar Munir**

Github: https://github.com/ibrarmunircoder </br>
LinkedIn: https://www.linkedin.com/in/ibrar-munir-53197a16b </br> 
Portfolio: https://ibrarmunir.d3psh89dj43dt6.amplifyapp.com

