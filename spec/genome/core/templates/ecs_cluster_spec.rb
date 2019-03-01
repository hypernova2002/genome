require 'spec_helper'
require_relative '../../../../lib/genome/core/templates/ecs_cluster'

RSpec.describe Genome::Core::Templates::ECSCluster do
  subject(:ecs_cluster) { Genome::Core::Templates::ECSCluster }

  context '::aws_template' do
    it 'aws_template is set to AWS::ECS::Cluster' do
      expect(ecs_cluster.aws_template).to eq('AWS::ECS::Cluster')
    end
  end
end
