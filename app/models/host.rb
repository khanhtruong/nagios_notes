class Host < ActiveRecord::Base
  has_many :services
  attr_accessible :hostname, :ip, :notes
end
