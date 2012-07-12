#! /usr/bin/ruby

# script to upload files to S3

require 'rubygems'
require 'aws/s3'

# needs to have these ENV vars set!!!!!
bucket_name = ENV['S3_BUCKET_NAME']
aws_account_id = ENV['AMAZON_ACCESS_KEY_ID']
aws_secret_key = ENV['AMAZON_SECRET_ACCESS_KEY']

datestamp = ARGV[0]
policy_name = ARGV[1]
filepath = ARGV[2]

# TODO: sanity checks. print usage if the above doesn't work out.
filename = File.basename(filepath)
hostname = `hostname`.chomp

remote_path = "/#{datestamp}/#{hostname}/#{policy_name}/#{filename}"

# debugging information:
STDERR.puts "bucket_name: #{bucket_name}"
STDERR.puts "datestamp: #{datestamp}"
STDERR.puts "policy_name: #{policy_name}"
STDERR.puts "filepath: #{filepath}"
STDERR.puts "remote_path: #{remote_path}\n"

# make connection:
AWS::S3::Base.establish_connection!(
  :access_key_id     => aws_account_id,
  :secret_access_key => aws_secret_key
)

# upload file to the bucket
begin
  AWS::S3::S3Object.store(remote_path, open(filepath), bucket_name)
rescue AWS::S3::NoSuchBucket
  # THE BUCKET BETTER FUCKING EXIST!
  # make sure the bucket exists
  AWS::S3::Bucket.create(bucket_name)
  retry
end

