Audience.find_or_create_by(name: "Designers")
Audience.find_or_create_by(name: "Desenvolvedores front-end")
Audience.find_or_create_by(name: "Desenvolvedores back-end")

20.times { FactoryGirl.create(:talk, audience_ids: [Audience.all.sample.id]) }
