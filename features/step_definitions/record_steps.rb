Given("the following DNS records:") do |table|
  records_attributes = table.hashes.map do |attributes|
    next attributes if attributes['hostnames'].blank?

    host_ids = attributes['hostnames'].split(', ').map { |name| Host.find_or_create_by!(name: name).id }

    attributes.except('hostnames').merge(host_ids: host_ids)
  end

  Record.create!(records_attributes)
end

When("I add the following DNS record:") do |table|
  params = table.rows_hash

  params['hostnames'] = params['hostnames'].split(', ') if params['hostnames'].present?

  post '/records', params
end

When("I query for DNS records with the following parameters:") do |table|
  params = table.rows_hash

  %w[hostnames except_hostnames].each do |param|
    params[param] = params[param].split(', ') if params[param].present?
  end

  get '/records', params
end

Then("I should have the following DNS records:") do |table|
  table.diff!(Record.all.map { |record| { 'ip' => record.ip.to_s, 'hostnames' => record.hostnames.sort.join(', ') } })
end
