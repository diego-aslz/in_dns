Then("I should receive the following response:") do |raw_json|
  expect(JSON.parse(last_response.body)).to eq(JSON.parse(raw_json))
end
