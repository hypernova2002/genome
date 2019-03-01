require 'spec_helper'

RSpec.describe Genome do
  it 'has a version number' do
    expect(Genome::VERSION).not_to be nil
  end
end
