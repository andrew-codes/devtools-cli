require 'rspec'
require_relative '../lib/software/git_software'

describe GitSoftware do
  it 'should be pre-installed' do
    sut = GitSoftware.new nil
    sut.is_pre_installed?.should == true
  end
  it 'should be named git' do
    sut = GitSoftware.new nil
    sut.name.should == :git
  end
end