require 'rspec'
require_relative '../lib/software/git'

describe Git do
  it 'should be pre-installed' do
    sut = Git.new nil
    sut.is_pre_installed?.should == true
  end
  it 'should be named git' do
    sut = Git.new nil
    sut.name.should == :git
  end
end