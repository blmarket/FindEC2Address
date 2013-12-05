FindEC2Address
--------------

resolve ec2 instance address via its name tag

If you wanna set your credential info using JSON file, make ~/.aws.credentials.json and fill contents like below.

{ "accessKeyId": "--yours--", "secretAccessKey": "--yours--", "region": "--yours--" }

This configuration will directly passes into AWS Node.js SDK

## Usage

    usage: index.coffee [-h] [-a ACCESSKEYID] [-s SECRETACCESSKEY] [pattern]

    Positional arguments:
      pattern               Instance Name Pattern
    
    Optional arguments:
      -h, --help            Show this help message and exit.
      -a ACCESSKEYID, --accessKeyId ACCESSKEYID
                            AWS access Key
      -s SECRETACCESSKEY, --secretAccessKey SECRETACCESSKEY
                            AWS secret Key
