json.records_count @records.total_count

json.hostnames @records_by_hostname do |name, records|
  json.name name
  json.matching_records_count records.size
end

json.records @records do |record|
  json.id record.id
  json.ip record.ip.to_s
end
