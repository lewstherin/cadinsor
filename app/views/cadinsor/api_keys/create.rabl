object @key
node(:status) {"Error."}
node(:errors) {|key| key.errors.full_messages}