require 'machinist/active_record'
require 'sham'
require 'faker'


Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraphs(3) }

# Rider.blueprint do
#   name          { Sham.name }
# end

# User.blueprint do
#   password      { 'password' }
#   email         { Sham.email }
# end

# Video.blueprint do
#   title         { Sham.title }
#   width         { '640px' }
#   height        { '480px' }
#   user_id       { User.make.id }
#   status        { nil }
# end

