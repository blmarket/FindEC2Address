{ArgumentParser} = require 'argparse'

parser = new ArgumentParser({
  addHelp: true
  description: 'resolve ec2 instance address via its name tag'
})

parser.addArgument(
  [ '-k', '--key' ]
  { help: 'AWS access Key' }
)

parser.addArgument(
  [ '-s', '--secret' ]
  { help: 'AWS secret Key' }
)

args = parser.parseArgs()
console.dir args