class Host < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :records, through: :addresses
end
