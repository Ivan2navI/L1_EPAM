# 6. AWS Cloud Basic 

### 1. Read the terms of Using the[  AWS Free Tier  ](https://docs.aws.amazon.com/en_us/awsaccountbilling/latest/aboutv2/billing-free-tier.html)and the ability to control their own costs.
### 2. [Register  with AWS  ](https://portal.aws.amazon.com/billing/signup?redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation#/start)(first priority) or alternatively, you can request access to courses  in[  AWS ](https://aws.amazon.com/training/awsacademy/member-list/) [Academy  ](https://aws.amazon.com/training/awsacademy/member-list/)if you are currently a student of[  certain University.](https://aws.amazon.com/training/awsacademy/member-list/)
### 3. Find the[  hands-on tutorials  ](https://aws.amazon.com/ru/getting-started/hands-on/?awsf.getting-started-category=category%23compute&amp;awsf.getting-started-content-type=content-type%23hands-on&amp;?e=gs2020&amp;p=gsrc&amp;awsf.getting-started-level=*all)and[  AWS Well-Architected Labs  ](https://www.wellarchitectedlabs.com/)for  your AWS  needs. Explore list of step-by-step tutorials for deferent  category. Use, repeat as  many as you  can and have fun))
### 4. Register and pass courses on[  AWS Educate.](https://www.awseducate.com/) Filter by checking Topic Cloud Computing and Foundational Level. Feel free to pass more. 
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%204.1..png">
</p>

> Actual links to __Credly__:
> - [AWS Educate Introduction to Cloud 101](https://www.credly.com/badges/91260238-f8a4-43cb-a5be-225bf28ece76/public_url)
> - [AWS Educate Getting Started with Compute](https://www.credly.com/badges/c55b57e4-31ab-40fd-a2b4-ff4e1ea87cf7/public_url)
> - [AWS Educate Getting Started with Storage](https://www.credly.com/badges/8a610240-9c44-4ac7-b22c-a447c0addd1e/public_url)
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%204.2..png">
</p>

### 5. Register and pass free courses  on[  AWS Skillbuilder](https://explore.skillbuilder.aws/learn). AWS Cloud  Practitioner Essentials: Core Services, AWS Cloud  Practitioner Essentials: Cloud Concepts. Try AWS Cloud  Quest: Cloud Practitioner. 
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%205..png">
</p>

### 6. Pass free courses on[  Amazon  qwiklabs ](https://amazon.qwiklabs.com/)
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%206..png">
</p>

### 7. Review[  Getting  Started  with  Amazon  EC2.](https://aws.amazon.com/ec2/getting-started/?nc1=h_ls)  Log  Into  Your  AWS  Account,  Launch,  Configure,  Connect and Terminate Your Instance. Do not use Amazon Lightsail. It is recommended to use the t2 or t3.micro instance and the CentOS operating system. 
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%207..png">
</p>

### 8. Create a snapshot of  your instance to keep as a backup.
__[Amazon EC2 backup and recovery with snapshots and AMIs](https://docs.aws.amazon.com/prescriptive-guidance/latest/backup-recovery/ec2-backup.html)__
> __To create multi-volume snapshots using the console__
> - Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/
> - In the navigation pane, choose Snapshots, Create snapshot.
> - For Resource type, choose Instance.
> - For Description, enter a brief description for the snapshots. This description is applied to all of the snapshots.
> - Choose Create snapshot.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%208..png">
</p>

### 9. Create and attach a Disk_D (EBS) to your instance to add more storage space. Create and save some file on Disk_D.

[Make an Amazon EBS volume available for use on Linux](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html)
```console
# Login to your ec2 instance and list the available disks using the following command.
lsblk

# Check if the volume has any data using the following command.
sudo file -s /dev/xvdf
# If the above command output shows “/dev/xvdf: data“, it means your volume is empty.

# Format the volume to the ext4 filesystem using the following command.
sudo mkfs -t ext4 /dev/xvdf
# Alternatively, you can also use the xfs format. You have to use either ext4 or xfs.
sudo mkfs -t xfs /dev/xvdf

# Create a directory of your choice to mount our new ext4 volume.
sudo mkdir Disc_D

# Mount the volume to “Disc_D” directory using the following command.
sudo mount /dev/xvdf Disc_D

# cd into Disc_D directory and check the disk space to validate the volume mount.
cd Disc_D
df -h

# To unmount the volume, use the unmount command as shown below..
umount /dev/xvdf
```
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%209..png">
</p>

### 10. Launch the second instance from backup.

__[Restoring from an Amazon EBS snapshot or an AMI](https://docs.aws.amazon.com/prescriptive-guidance/latest/backup-recovery/restore.html)__
> Follow these steps to restore a volume to an earlier point-in-time backup by using the console:
> - On the Amazon EC2 console, on the Elastic Block Store menu, choose Snapshots.
> - Search for the snapshot that you want to restore, and select it.
> - Choose Actions, and then choose Create Volume.
> - Create the new volume in the same Availability Zone as your EC2 instance.
> - On the Amazon EC2 console, select the instance.
> - In the instance details, make note of the device name that you want to replace in the Root device entry or Block Devices entries.
> - Attach the volume. The process differs for root volumes and non-root volumes.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2010_1..png">
</p>

> For root volumes:
> - Stop the EC2 instance.
> - On the EC2 Elastic Block Store Volumes menu, select the root volume that you want to replace.
> - Choose Actions, and then choose Detach Volume.
> - On the EC2 Elastic Block Store Volumes menu, select the new volume.
> - Choose Actions, and then choose Attach Volume.
> - Select the instance that you want to attach the volume to, and use the same device name that you noted earlier.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2010_2..png">
</p>

### 11. Detach Disk_D from the 1st instance and attach  disk_D to the new instance.
In this case the volume mount to “Disc_D_v2” and check that a file "test_file_from_inst1_RH8" is available.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2011..png">
</p>


### 12. Review the 10-minute [example.](https://aws.amazon.com/getting-started/hands-on/get-a-domain/?nc1=h_ls) Explore the possibilities of creating your own domain and domain  name  for  your  site.  Note,  that  Route  53  not  free  service. Alternatively  you  can  free register the  domain name *.PP.UA and use it.

12.1. Install Apache on RHEL 8
```console
# !!! --- Install firewall-cmd --- 
dnf in firewalld -y

# Start firewalld and enable it to auto-start at the system boot.
systemctl start firewalld
systemctl enable firewalld

# Check the status of firewalld running.
systemctl status firewalld

# Configure the rules.
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

# !!! --- Install package httpd ---
dnf install httpd

# Verify the version of Apache
rpm -qi httpd

# Run and enable the Apache webserver to start after reboot:
systemctl enable httpd
systemctl start httpd
systemctl status httpd

# Apache web server to be accessed from remote locations open HTTP firewall port 80: 
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --reload

# !!! --- Add index.html --- 
echo Apache on RHEL 8 / CentOS 8 > /var/www/html/index.html
```
12.2. Add domain PP.UA to Route 53:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2012..png">
</p>

### 13. Launch and configure a WordPress instance with Amazon Lightsail[  link  ](https://aws.amazon.com/getting-started/hands-on/launch-a-wordpress-website/?trk=gs_card)

13.1 Creating an Amazon Lightsail account & WordPress instance there is.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2013_1..png">
</p>

13.2. For WordPress instance, I will use the previously created elastic IP and DNS zone from Route 53.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2013_2..png">
</p>

### 14. Review the 10-minute[  Store and Retrieve a File.](https://aws.amazon.com/getting-started/hands-on/backup-files-to-amazon-s3/) Repeat, creating your own repository.

14.1. Creating S3 bucket & additing files.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2014_1..png">
</p>

14.2. Download & delete files. With subsequent deletion of the S3 bucket.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2014_2..png">
</p>

### 15. Review  the  10-minute[  example  ](https://aws.amazon.com/getting-started/hands-on/backup-to-s3-cli/?nc1=h_ls)Batch  upload  files  to  the  cloud  to  Amazon  S3  using  the  AWS  CLI. Create a user AWS  IAM, configure CLI AWS and upload any files  to S3.

15.1. Create an AWS IAM User.
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2015_1..png">
</p>

15.2. Using the AWS CLI with Amazon S3
```console
Microsoft Windows [Version 10.0.19043.2251]
(c) Корпорация Майкрософт (Microsoft Corporation). Все права защищены.

C:\>aws configure
AWS Access Key ID [None]: AKIAT47************
AWS Secret Access Key [None]: zBnv9dBKW1******************
Default region name [None]: eu-central-1
Default output format [None]: json

C:\>aws s3 mb s3://my-backup-bucket
make_bucket failed: s3://my-backup-bucket An error occurred (BucketAlreadyExists) when calling the CreateBucket operation: The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.

C:\>aws s3 mb s3://1van-backup-bucket
make_bucket: 1van-backup-bucket

C:\>aws s3 cp "C:\AWS\From PC to AWS.bak" s3://1van-backup-bucket
upload: AWS\From PC to AWS.bak to s3://1van-backup-bucket/From PC to AWS.bak

C:\>aws s3 cp s3://1van-backup-bucket/From_AWS_to_PC.txt C:\AWS\
download: s3://1van-backup-bucket/From_AWS_to_PC.txt to AWS\From_AWS_to_PC.txt

C:\>dir AWS
 Том в устройстве C имеет метку HDD1 [System]
 Серийный номер тома: 07E5-12A8

 Содержимое папки C:\AWS

29.11.2022  22:37    <DIR>          .
29.11.2022  22:37    <DIR>          ..
29.11.2022  22:04                 0 From PC to AWS.bak
29.11.2022  22:31                 0 From_AWS_to_PC.txt
               2 файлов              0 байт
               2 папок  149 939 314 688 байт свободно

C:\>aws s3 rm s3://1van-backup-bucket/From_AWS_to_PC.txt
delete: s3://1van-backup-bucket/From_AWS_to_PC.txt
```
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2015_2..png">
</p>

### 16. Review the 10-minute[  example  ](https://aws.amazon.com/getting-started/hands-on/deploy-docker-containers/?nc1=h_ls)Deploy Docker Containers on Amazon Elastic Container Service (Amazon  ECS).  Repeat,  create  a  cluster,  and  run  the  online  demo  application  or  better  other application with custom settings.

<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2016..png">
</p>

### 17. [Run a Serverless "Hello, World!"  ](https://aws.amazon.com/getting-started/hands-on/run-serverless-code/?nc1=h_ls)with  AWS Lambda. 

<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2017..png">
</p>

### 18. Create a static website on Amazon S3, publicly available [(link1  ](https://docs.aws.amazon.com/AmazonS3/latest/dev/HostingWebsiteOnS3Setup.html)or[  link2  ](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html)- using a custom domain registered with Route 53). Post on the page your own photo, the name of the educational program  (**EPAM  Cloud&DevOps  Fundamentals  Autumn  2022**),  the  list  of  AWS  services  with which the student worked within the educational program or earlier and the full list with links of  completed  labs  (based  on[  tutorials  ](https://aws.amazon.com/getting-started/hands-on/?awsf.getting-started-content-type=content-type%23hands-on&amp;?e=gs2020&amp;p=gsrc)or[  qwiklabs)](https://amazon.qwiklabs.com/).  Provide  the  link  to  the  website  in  your  report and СV.

Add a bucket policy that makes bucket content publicly available.
```console
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::1van.pp.ua/*"
            ]
        }
    ]
}
```
Configuring Amazon Route 53 to route traffic to an S3 Bucket:
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2018_1..png">
</p>

Test websites and domain name PP.UA
- from: http://1van.pp.ua.s3-website.eu-central-1.amazonaws.com/
- to: http://1van.pp.ua/
<p align="center">
  <img src="https://github.com/Ivan2navI/L1_EPAM/blob/main//6.%20AWS/.info/A%2018_2..png">
</p>


---
### PS: [Paste to Markdown](https://euangoddard.github.io/clipboard2markdown/)

Instructions

    Find the text to convert to Markdown (e.g., in another browser tab)
    Copy it to the clipboard (Ctrl+C, or ⌘+C on Mac)
    Paste it into this window (Ctrl+V, or ⌘+V on Mac)
    The converted Markdown will appear!

The conversion is carried out by [to-markdown](https://github.com/domchristie/to-markdown), a Markdown converter written in JavaScript and running locally in the browser.
