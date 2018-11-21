class Address < ApplicationRecord
  belongs_to :record
  belongs_to :host
end
