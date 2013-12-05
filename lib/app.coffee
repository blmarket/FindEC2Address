{ArgumentParser} = require 'argparse'
AWS = require 'aws-sdk'

parser = new ArgumentParser({
  addHelp: true
  description: 'resolve ec2 instance address via its name tag'
})

parser.addArgument(
  [ '-a', '--accessKeyId' ]
  { help: 'AWS access Key' }
)

parser.addArgument(
  [ '-s', '--secretAccessKey' ]
  { help: 'AWS secret Key' }
)

args = parser.parseArgs()

AWS.config.loadFromPath('./config.json')
AWS.config.update(args)

ec2 = new AWS.EC2()

ec2.describeInstances {}, (err, res) ->
  throw err if err?
  for r in res.Reservations
    for inst in r.Instances
      console.log inst.PublicDnsName
      console.log inst.Tags
