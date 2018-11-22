class Host < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :records, through: :addresses

  validates :name, presence: true, uniqueness: true

  scope :by_name, ->(name) { where(name: name) }

  def self.group_records_by_name(records)
    records.flat_map(&:hosts).map(&:name).reduce({}) do |hsh, name|
      hsh.merge(name => records.select { |record| record.has_hostname?(name) })
    end
  end
end
