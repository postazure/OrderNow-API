require 'spec_helper'
require 'rake'

xdescribe 'foo namespace rake task' do
  before :all do
    Rake.application.rake_require "tasks/bar"
    Rake::Task.define_task(:environment)
  end

  describe 'foo:bar' do
    before do
      BarOutput.stub(:banner)
      BarOutput.stub(:puts)
    end

    let :run_rake_task do
      Rake::Task["foo:bake_a_bar"].reenable
      Rake.application.invoke_task "foo:bake_a_bar"
    end

    it "should bake a bar" do
      Bar.any_instance.should_receive :bake
      run_rake_task
    end

    it "should bake a bar again" do
      Bar.any_instance.should_receive :bake
      run_rake_task
    end

    it "should output two banners" do
      BarOutput.should_receive(:banner).twice
      run_rake_task
    end

  end
end
