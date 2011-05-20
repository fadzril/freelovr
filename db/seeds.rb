# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require "csv"
CSV.foreach('public/uploads/dumplovr.csv') do |row|
  users = User.new(
                 :name          => row[0],
                 :email         => row[1],
                 :website       => row[2],
                 :twitter       => row[3],
                 :scope         => row[4],
                 :experience    => row[5],
                 :level         => row[6],
                 :designation   => row[7],
                 :skillset      => row[8],
                 :other         => row[9],
                 :recommended   => row[10],
                 :rates_attributes => {
                   '0' => {
                     :currency  => row[11],
                     :rate      => row[12],
                     :based     => row[13]
                   }
                 }
               )
  users.save!
end
