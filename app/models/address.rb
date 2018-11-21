class Address < ApplicationRecord
  belongs_to :record
  belongs_to :host

  scope :by_hostname, ->(hostname) { joins(:host).merge(Host.by_name(hostname)) }
end
