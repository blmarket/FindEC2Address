fs = require 'fs'

{ArgumentParser} = require 'argparse'
AWS = require 'aws-sdk'

CONFIG_PATH = './config.json'

PROGRAM_DESCRIPTION = '''
resolve ec2 instance address via its name tag

If you wanna set your credential info using JSON file, make config.json and fill contents like below.

{ "accessKeyId": "--yours--", "secretAccessKey": "--yours--", "region": "--yours--" }

This configuration will directly passes into AWS Node.js SDK
'''

parser = new ArgumentParser({
  addHelp: true
  description: PROGRAM_DESCRIPTION
})

parser.addArgument(
  [ '-a', '--accessKeyId' ]
  { help: 'AWS access Key' }
)

parser.addArgument(
  [ '-s', '--secretAccessKey' ]
  { help: 'AWS secret Key' }
)

parser.addArgument(
  [ 'pattern' ]
  { help: 'Instance Name Pattern', nargs: '?' }
)

args = parser.parseArgs()
pattern = new RegExp(args.pattern ?= '.*')
delete args.pattern

AWS.config.loadFromPath(CONFIG_PATH) if fs.existsSync CONFIG_PATH
AWS.config.update(args)

ec2 = new AWS.EC2()

ec2.describeInstances {}, (err, res) ->
  throw err if err?
  for r in res.Reservations
    for inst in r.Instances
      name = do ->
        for tag in inst.Tags
          return tag.Value if tag.Key.match /^name/i
        return null
      console.log name, inst.PublicDnsName if do ->
        for tag in inst.Tags
          return true if tag.Value.match(pattern)
        return false
  return
