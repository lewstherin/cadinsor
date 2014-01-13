object @key
if !@key
  node(:status) {"Error."}
  node(:errors) {"No valid key found with id: " + params[:id].to_s}
else
  node(:status) {"Success."}
  attribute :value => :key
end