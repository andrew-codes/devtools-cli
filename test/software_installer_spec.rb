require 'rspec'
require_relative '../lib/software_installer'

describe SoftwareInstaller do
  context 'when installing a software for  platform' do
    let (:software) { double :software, :name => :git, :install_for => nil, :configure_for => nil }
    it 'should set its is_installed? flag to true' do
      sut = SoftwareInstaller.new software
      sut.install_for(:windows)
      sut.is_installed?.should == true
    end

    it 'should install the software for that platform' do
      software.should_receive(:install_for).with(:windows)
      sut = SoftwareInstaller.new software
      sut.install_for(:windows)
    end

    it 'should configure the software for that platform' do
      software.should_receive(:configure_for).with(:windows)
      sut = SoftwareInstaller.new software
      sut.install_for(:windows)
    end
  end
  context 'when installing a software more than one time' do
    let (:software) { double :software, :name => :git, :install_for => nil, :configure_for => nil }
    sut = nil
    before(:each) do
      sut = SoftwareInstaller.new software
      sut.install_for(:windows)
    end
    it 'should not install more than once' do
      software.should_not_receive(:install_for)
      sut.install_for(:windows)
    end
    it 'should configure the software each time' do
      software.should_receive(:configure_for).with(:windows)
      sut.install_for(:windows)
    end
  end
  context 'when installed pre-installed software' do
    let (:software) { double :software, :name => :git, :is_pre_installed? => true, :install_for => nil, :configure_for => nil }
    it 'should not install the software' do
      sut = SoftwareInstaller.new software
      software.should_not_receive(:install_for)
      sut.install_for(:windows)
    end
  end
end