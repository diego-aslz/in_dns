if @errors
  json.errors @errors
else
  json.id @record.id
end
