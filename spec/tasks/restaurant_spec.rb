# require 'spec_helper'
# require 'rake'
#
# describe 'restaurant namespace rake task' do
#   before :all do
#     Rake.application.rake_require "tasks/restaurant"
#     Rake::Task.define_task(:environment)
#   end
#
#   describe "restaurant:get_core" do
#     let :run_rake_task do
#       Rake::Task["restaurant:get_core"].reenable
#       Rake.application.invoke_task "restaurant:get_core"
#     end
#
#     xit "orderahead" do
#       response = SearchProvider.order_ahead
#
#       expect(response).to be
#     end
#
#   end
# end
