# Import the Boto3 library
import boto3

# Create a Boto3 client for EC2, RDS, S3, and other services you want to list
ec2_client = boto3.client('ec2')
rds_client = boto3.client('rds')
s3_client = boto3.client('s3')

# Get a list of all available AWS regions
regions = [region['RegionName'] for region in ec2_client.describe_regions()['Regions']]

# Loop through each region and list the resources
for region in regions:
    print(f"Resources in region {region}:")
    ec2_instances = ec2_client.describe_instances()['Reservations']
    for ec2_instance in ec2_instances:
        print(f"EC2 instance: {ec2_instance['Instances'][0]['InstanceId']}")
    rds_instances = rds_client.describe_db_instances()['DBInstances']
    for rds_instance in rds_instances:
        print(f"RDS instance: {rds_instance['DBInstanceIdentifier']}")
    s3_buckets = s3_client.list_buckets()['Buckets']
    for s3_bucket in s3_buckets:
        print(f"S3 bucket: {s3_bucket['Name']}")
    # Add more commands for other resources you want to list




# Import the Boto3 library
import boto3

# Create a Boto3 client for EC2, RDS, S3, and other services you want to list
ec2_client = boto3.client('ec2')
rds_client = boto3.client('rds')
s3_client = boto3.client('s3')

# Get a list of all available AWS regions
regions = [region['RegionName'] for region in ec2_client.describe_regions()['Regions']]

# Loop through each region and list the resources in detail
for region in regions:
    print(f"Resources in region {region}:")
    
    # EC2 instances
    ec2_instances = ec2_client.describe_instances()['Reservations']
    print(f"EC2 instances:")
    for ec2_instance in ec2_instances:
        print(f"  Instance ID: {ec2_instance['Instances'][0]['InstanceId']}")
        print(f"  Instance Type: {ec2_instance['Instances'][0]['InstanceType']}")
        print(f"  Private IP: {ec2_instance['Instances'][0]['PrivateIpAddress']}")
        print(f"  Public IP: {ec2_instance['Instances'][0]['PublicIpAddress']}")
    
    # RDS instances
    rds_instances = rds_client.describe_db_instances()['DBInstances']
    print(f"RDS instances:")
    for rds_instance in rds_instances:
        print(f"  Instance ID: {rds_instance['DBInstanceIdentifier']}")
        print(f"  Instance Class: {rds_instance['DBInstanceClass']}")
        print(f"  Engine: {rds_instance['Engine']}")
        print(f"  Engine Version: {rds_instance['EngineVersion']}")
    
    # S3 buckets
    s3_buckets = s3_client.list_buckets()['Buckets']
    print(f"S3 buckets:")
    for s3_bucket in s3_buckets:
        print(f"  Bucket Name: {s3_bucket['Name']}")
        print(f"  Creation Date: {s3_bucket['CreationDate']}")
    
    # Add more commands for other resources you want to list
