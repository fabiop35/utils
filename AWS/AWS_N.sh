
console.aws.amazon.com
#
4.2.1 Installing the CLI
 $ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
 $ unzip awscliv2.zip
 $ sudo ./aws/install
 $ aws --version
 $ aws configure
 $ aws ec2 describe-regions
 $ $ aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro"
 
#boto3 is the AWS SDK for Python, allowing Python developers to interact with various AWS services like Amazon S3, EC2, and many others. 
$ pip3 install botocore 
 
##CH09##
  -Creating a highly available network filesystem
  -Mounting a network filesystem on multiple EC2 instances
  -Sharing files between EC2 instances
  -Tweaking the performance of your network filesystem
  -Monitoring possible bottlenecks in your network filesystem
  -Backing up your shared filesystem

-EFS WORKS ONLY WITH LINUX At this time, EFS isn’t supported by Windows EC2 instances. 
-Typically, EBS volumes are used as the root volumes that contain the operating system, or, for relational database systems, to store the state.
-Elastic File System (EFS)
-Elastic Block Store (EBS)
-Instance store
-An EBS volume is tied to a data center and can be attached to only a single EC2 instance from the same data center.
-An instance store consists of a hard drive directly attached to the hardware the virtual machine is running on.An instance store can be regarded as ephemeral storage and is, therefore, used only for temporary data, caching, or for systems with embedded data replication, like many NoSQL databases, for example.
-EFS filesystem supports reads and writes by multiple EC2 instances from different data centers in parallel.
*EBS is a virtual disk, *instance store is a local disk, and *EFS is a shared folder.
-EFS consists of two components: Filesystem - Mount target
-EFS consists of two components:
   -Filesystem—Stores your data
   -Mount target—Makes your data accessible
-The filesystem is the resource that stores your data in an AWS region, but you can’t access it directly. To do so, you must create an EFS mount target in a subnet.
-The filesystem is the resource that stores your files, directories, and links. Like S3, EFS grows with your storage needs. You don’t have to provision the storage up front.
-When using multiple EC2 instances, your users will have a separate home folder on each EC2 instance.
-9.1.2 Pricing
-An EFS mount target makes your data available to EC2 instances via the NFSv4.1 protocol in a subnet. The EC2 instance communicates with the mount target via a TCP/IP network connection.
-Security groups control which traffic is allowed to enter the mount target.
-The NFS protocol uses port 2049 for inbound communication.
-to control traffic as tightly as possible, you won’t grant traffic based on IP addresses. Instead, you’ll create two security groups. The client security group will be attached to all EC2 instances that want to mount the filesystem.

-EFS can also be used in the following other scenarios:
	-Containers (ECS and EKS)
	-Lambda functions
	-On-premises servers

-EFS creates a DNS name for each filesystem following the schema $FileSystemID .efs.$Region.amazonaws.com.

#installing the EFS mount helper
$ sudo yum install amazon-efs-utils 

#mounts an EFS filesystem
$ sudo mount -t efs -o tls,iam $FileSystemID $EFSMountPoint
$ sudo mount -t efs -o tls,iam fs-123456 /home
-tls initiates a TLS tunnel from the EC2 instance to the EFS filesystem to encrypt data in transit.
-iam enables authentication via IAM using the IAM role attached to the EC2 instance.

#use the /ets/fstab config file to automatically mount on startup
$ $FileSystemID:/ $EFSMountPoint efs _netdev,noresvport,tls,iam 0 0
-_netdev —Identifies a network filesystem
-noresvport —Ensures that a new TCP source port is used when reestablishing a connection, which is required when recovering from network problems.

#create a stack based on your template
$ aws cloudformation create-stack --stack-name efsch09 --template-body file://efs.yaml --capabilities CAPABILITY_IAM

#get the EC2 instance IDs of EC2InstanceA and EC2InstanceB
$ aws cloudformation describe-stacks --stack-name efsch09 --query "Stacks[0].Outputs"


-The default user on Amazon Linux 2 is the ec2-user.
-The following factors affect latency, throughput, and I/O operations per second of an EFS filesystem:
 +The performance mode—General Purpose or Max I/O
   -General Purpose mode—Supports up to 35,000 IOPS (IOPS stands for read or write operations per second.)
   -Max I/O mode—Supports 500,000+ IOPS
 +The throughput mode—Bursting or Provisioned
 +The storage class—Standard or One Zone
-General Purpose performance mode, which is fine for most workloads, especially latency-sensitive ones where small files are served most of the time. The /home directory is a perfect example of such a workload. Typical files like documents are relatively small, and users expect low latency when fetching files. 
-For data analytics, latency is not important. Throughput is the metric you want to optimize instead. If you want to analyze gigabytes or terabytes of data, it doesn’t matter if your time to first byte takes 1 ms or 100 ms. Even a small increase in throughput will decrease the time it will take to analyze the data.
*The performance mode being used by an EFS filesystem cannot be changed—you set it when the filesystem is created. Therefore, to change the performance mode, you have to create a new filesystem.
-Recommend you start with the General Purpose performance mode if you are unsure which mode fits best for your workload.
*EFS sends metrics to CloudWatch, allowing us to get insight into the performance of a filesystem. 
-The metric PercentIOLimit tells whether a filesystem is approaching its I/O limit.
-By migrating your data to a filesystem with Max I/O mode, you can increase the I/O limit from 35,000 IOPS to 500,000+ IOPS. Doing so increases read latency from around 600 microseconds to single-digit milliseconds.
 
#CloudWatch alarm to monitor the PercentIOLimit metric. 
 PercentIOLimitTooHighAlarm:
  Type: 'AWS::CloudWatch::Alarm'
  Properties:
    AlarmDescription: 'I/O limit has been reached, consider ...'
    Namespace: 'AWS/EFS'
    MetricName: PercentIOLimit
    Statistic: Maximum
    Period: 600
    EvaluationPeriods: 3
    ComparisonOperator: GreaterThanThreshold
    Threshold: 95
    Dimensions:
    - Name: FileSystemId
      Value: !Ref FileSystem
 
9.5.2 Throughput mode
-Besides the performance mode, the throughput mode determines the maximum throughput of an EFS filesystem using the following modes:
 +Bursting Throughput mode— Comes with a small baseline throughput but is able to burst throughput for short periods of time. 
 +Provisioned Throughput mode— Gives you a constant throughput with a maximum of 1 GiBps. You pay $6.00 per MB/s per month.
 
 

UserData:                                                      
        'Fn::Base64': !Sub |
          #!/bin/bash -ex
          trap '/opt/aws/bin/cfn-signal -e 1 --stack ${AWS::StackName} --resource EC2InstanceA --region ${AWS::Region}' ERR
			
		->'Fn::Base64': !Sub "#!/bin/bash -ex\\ntrap '/opt/aws/bin/cfn-signal -e 1 --stack ${AWS::StackName} --resource EC2InstanceA --region ${AWS::Region}' ERR"	

> ls -d -l /home/*
> cp -a /home/. /oldhome











Resources:                              
  [...]
  FileSystem:
    Type: 'AWS::EFS::FileSystem'
    Properties:
      Encrypted: true                   
      ThroughputMode: bursting          
      PerformanceMode: generalPurpose   
      FileSystemPolicy:                 
        Version: '2012-10-17'
        Statement:
        - Effect: 'Deny'
          Action: '*'
          Principal:
            AWS: '*'
          Condition:
            Bool:
              'aws:SecureTransport': 'false'


Resources:
  [...]
  EFSClientSecurityGroup:                                    
    Type: 'AWS::EC2::SecurityGroup'
    Properties:
      GroupDescription: 'EFS Mount target client'
      VpcId: !Ref VPC
  MountTargetSecurityGroup:                                  
    Type: 'AWS::EC2::SecurityGroup'
    Properties:
      GroupDescription: 'EFS Mount target'
      SecurityGroupIngress:
      - IpProtocol: tcp
        FromPort: 2049                                       
        ToPort: 2049
        SourceSecurityGroupId: !Ref EFSClientSecurityGroup   
      VpcId: !Ref VPC
  MountTargetA:
    Type: 'AWS::EFS::MountTarget'
    Properties:
      FileSystemId: !Ref FileSystem                          
      SecurityGroups:
      - !Ref MountTargetSecurityGroup                        
      SubnetId: !Ref SubnetA








bPNxPUpo+9BOZVm+7gBrm7vdXQuBDqcRgelPR9Fh