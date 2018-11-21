class Record < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :hosts, through: :addresses

  def self.by_hostnames(hostnames)
    Array(hostnames).reduce(all) { |scope, name| scope.where(id: Address.by_hostname(name).select(:record_id)) }
  end

  def self.except_hostnames(hostnames)
    Array(hostnames).reduce(all) { |scope, name| scope.where.not(id: Address.by_hostname(name).select(:record_id)) }
  end

  def has_hostname?(name)
    hosts.map(&:name).include?(name)
  end
end
