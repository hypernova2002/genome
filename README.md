# Genome

A library for create and maintaining cloud formation stacks using a simple dsl. Remove all the complications of networking, security groups and iam roles for faster development and better security.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'genome'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install genome

## Usage

### Resources

For a quick start setting up a stack, you can use the built in resources. Simply create a stack class, which includes a resource and then build your stack. This recommended only for testing, as the resources may be updated, causing your stack to change.

```ruby
require_relative 'lib/genome/resources/documentdb'
require_relative 'lib/genome/stack'

class TestStack
  include Genome::Stack

  stack_name :testing

  resource Genome::Resources::DocumentDB

end

TestStack.build
```

Alternatively, you can inherit a resource in order to configure the resource for your needs, without having to build from scratch. The following prevents a new vpc and subnets from being created, so you can configure DocumentDB to use your existing subnets.

```ruby
require_relative 'lib/genome/resources/documentdb'
require_relative 'lib/genome/stack'

class MyResource < Genome::Resources::DocumentDB
  disable_vpc
  disable_subnets

  subnet_ids [
    'subnet-1',
    'subnet-2',
    'subnet-3'
  ]
end


class TestStack
  include Genome::Stack

  stack_name :testing

  resource MyResource

end

TestStack.build
```

For production environments we recommend that you configure your own resources, to ensure that templates never change. It's generally better to use existing resources for testing.

### Templates

Templates define the core configuration needed to generate a basic AWS resource, such as an ec2_instance. Resources can configure a set of templates and define dependency chains for each template. The following creates a basic SQS Queue with a security group

```ruby
require_relative '../resource'
require_relative '../core/templates/ec2_security_group'
require_relative '../core/templates/sqs_queue'

class SQSQueue
  include Resource

  template :SQSSecurityGroup, Genome::Core::Templates::EC2SecurityGroup,
    GroupDescription: 'Security Group for SQS'

  template :SQSQueue, Genome::Core::Templates::SQSQueue,
    QueueName: 'default_queue',
    DependsOn: [ :SQSSecurityGroup ]

end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hypernova2002/genome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

