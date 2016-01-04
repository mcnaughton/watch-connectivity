# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.identifier = 'media.mcnaughton.testing'
  app.provisioning_profile = "./profiles/testing_development.mobileprovision"
  app.name = 'watch-connectivity'
  app.frameworks << 'WatchConnectivity'
  app.target 'watch', :watchapp
end
