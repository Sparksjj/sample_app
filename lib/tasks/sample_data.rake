namespace :db do
	desc "Fill database with samtle data"
	task populate: :environment do
		User.create!(name: "Example User",
					 email: "example@railstutorial.org",
					 password: "foobar",
					 password_confirmation: "foobar")
		User.create!(name: "Ugene",
					 email: "Arucard2009@yandex.ru",
					 password: "12345",
					 password_confirmation: "12345",
					 admin: true)
		99.times do	|n|
			name = Faker::Name.name
			email ="example-#{n+1}@railstutorial.org"
			password="12345"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end
	end
end