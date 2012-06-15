class Service < ActiveRecord::Base
  belongs_to :host
  attr_accessible :notes, :service_check
end
