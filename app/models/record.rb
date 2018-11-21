class Record < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :hosts, through: :addresses
end
