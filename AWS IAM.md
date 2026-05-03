AWS IAM controls  everything at the API level  

IAM handles two  different types of access 


type  one : human access this iis what ii was talking about a persson who siigns iin the aws console  using my builder ID I click around create resources check dashboards etc uses IAM  users and IAM groups

type two: Programmatic access this iis for  the apps services and automation tools they dont sign iinto a portal they make api  calls directly this uses IAM roles and access keys 

IAM users are for humans WAhen u create an AWS account you start with a root user which is liike the one on linux it can do anything and everything should rarely use  it thhen we create IAM users for yourself and your team members. Each person gets their own username and password to sign into the console they use  the AWS CLI or SDK

IAM groups are just collections of users instead of giiving permissiions to each user individually you create groups liike "developers", "Adminitrators", or "ReadOnly", and then assign permissions.

IAM Roles are for services and applications this is just  the part thatss different from traditional Linux user management. A role iis an  iidentity that anything not just for humans can assume temporarly. liike  an EC2 instance  can assume a role or a lamda function can assume a  role. your EKSpods can assume a role even userss from the other AWS accountss can ssume a rrole in oyur account  if u can coonfigure it that way. 

**IAM Policies** are JSON documents that define what actions are allowed or denied. A policy might say "allow reading from any S3 bucket" or "allow creating EC2 instances but only t2.micro size" or "deny everything in the production account on weekends." Policies get attached to users, groups, or roles to grant them permissions.