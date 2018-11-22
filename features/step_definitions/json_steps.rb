STATUS = {
  'OK' => 200,
  'BAD REQUEST' => 400,
}

Then("I should receive a(n) {string} response with the following body:") do |status, raw_json|
  expect(last_response.status).to eq(STATUS[status])
  expect(JSON.parse(last_response.body)).to eq(JSON.parse(raw_json))
end
