require 'rspec'
require_relative '../lib/software_library'

describe SoftwareLibrary do
  context 'when getting a software installer' do
    let(:ruby) { double :ruby, :is_a_match => false }
    let(:git) { double :git, :is_a_match => true }
    let(:sublime_text) { double :sublime_text, :is_a_match => false }
    it 'should return the first match from the software collection' do
      ruby.should_receive(:is_a_match).with(:git_software)
      git.should_receive(:is_a_match).with(:git_software)
      sublime_text.should_not_receive(:is_a_match)
      sut = SoftwareLibrary.new [ruby, git, sublime_text]
      actual = sut.get(:git_software)
      actual.should == git
    end
  end

  context 'when getting a software installer that is not in the library' do
    let(:ruby) { double :ruby, :is_a_match => false }
    let(:git) { double :git, :is_a_match => false }
    let(:sublime_text) { double :sublime_text, :is_a_match => false }
    it 'should throw an exception' do
      ruby.should_receive(:is_a_match).with(:nodejs)
      git.should_receive(:is_a_match).with(:nodejs)
      sublime_text.should_receive(:is_a_match).with(:nodejs)
      sut = SoftwareLibrary.new [ruby, git, sublime_text]
      lambda { sut.get(:nodejs) }.should raise_error
    end
  end
end