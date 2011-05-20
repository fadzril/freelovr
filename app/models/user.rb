
class User < ActiveRecord::Base
  require "csv"
  has_many :rates
  accepts_nested_attributes_for :rates

#  validates :name, :presence => true
#  validates :email, :presence => true

  has_attached_file :avatar,
                    :styles => { :small => "150x150>", :thumb => "70x70>" },
                    :path => ':rails_root/public/images/:attachment/:filename',
                    :url  => "/:attachment/:filename"


  def self.import_user()
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
  end
end


