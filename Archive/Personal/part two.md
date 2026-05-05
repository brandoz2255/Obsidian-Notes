AWS infra has been architected to be one  of the most flexible and secure cloud computing enviroments available today.  Its a way to provide extremely scalable and highly relaible platform that enables customers  to deploy apps quickly and securely 

the infra it self is built and managed only according to security best practices and  standards, but also wiitth the unique needs of the cloud in mind. AWS uses a redundant and  layered controls, continuous  valiidation and  testing. 

AWS customers benifiit from the data  center and network buiilt to satiisfy the requirements of our most security sensitive customers. Which just means that you  get a resilient  infra  designed for high security witthout capital outllay and operational overhead of a traditional  data center 


![[Pasted image 20251105155244.png]]


# security products  and features 


AWS it self provides  a  tone of security tools such as network firewalls built right into the  Amazon VPC to  let one engineer create private networks and control access to your instances or applications Customers can control encryption in transition TLS across AWS services 

connectivity options that enable private, or dedicated connections from your office or on premise environment

`DDoS` mitigation technologies that apply at layer 3 or 4 as  well as layer 7. These  can be applied as part of application and content delivery strategies

Automatic  encryption of all traffic on AWS global and regional networks between AWS secured facilities 

### Infra config management 

AWS offers a range of tools to allow one  to move fast, while still enabling you to ensure  that your cloud resources comply with organizational standards and best practices

- such as deployment tools to manage th creation and decommiissiooniing  of AWS resources according to  organization standards  
- iinventory of configuration management  tools to identify AWS resources and then track and manage changes
- template defnitions and management tools  to create standard preconfigured hardened virtual machines

###  Data  encryption 

AWS offers the abiliity to add a layer of security to your data at rest iin the cloud, providing scalable and efficient encryption features 

- these include data at rest encryption capabilities availble in most AWS services, such as Amazon EBS, Amazon S3, Amazon RDS, Amazon Redshift, Amazon ElastiCache, AWS Lambda, and Amazon SageMaker AI
- Flexible key management options, including key management service that allow you to choose wheter to have  AWS manage the encryption keys or enable one to keep complete  control over our own keys 
- Dedicated, hardware-based cryptographic key storage using AWS CloudHSM

## Identity and Access Control

AWS offers anyone the capabilities to define, enforce, and  manage user access policies across AWS services. 

- Such as AWS IAM  which lets anyone define individual users with permissions  across AWS resources AWS multi-factor for privileged accounts, including options for software and  hardware based authentication 
	- [[AWS IAM]]
	- IAM is a way to grant any employees and applications federated accesss to the AWS management console and  AWS serviice APIs using our own existing IAM such as Azure AD or other partner offering
- AWS Directory Service: Allows one self to integrate and federate with corporate directories to reduce administrative overhead and improve end-user experience 
- AWS IAM identiity center allows us too centrally manage workforce access to multiple  AWS accounts and applications 

### Monitor and logging 

AWS provides tools features that enable you to see whats happening in your AWS enviroment. These include 

- AWS Cloudtrail: Here we can moniitor our AWS deployments in  the cloud by getting a history of AWS API calls for an account including API calls made by AWS management console the AWS SDK or the CLI tools and Cloudtrail the source  IP addrresss  calls were made from and when the callss occured 
- AWS CloudWatch: Provides a scalable  and flexiible  monitoring solution u can start using withiin minutes no longer need to set up manage and scale monitoring systems and  infra
- AWS GaurdDuty: Is a threat detection service that contiinously monitorss for malicous activity and unauthorized behaviour on the AWS accounts and workloads


