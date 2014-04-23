# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'
require 'spec/factories/talk'

Audience.find_or_create_by(name: "Designers")
Audience.find_or_create_by(name: "Desenvolvedores front-end")
Audience.find_or_create_by(name: "Desenvolvedores back-end")

20.times { FactoryGirl.create(:talk, audience_ids: [Audience.all.sample.id]) }
