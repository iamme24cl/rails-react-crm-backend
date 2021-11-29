class SessionSerializer < ActiveModel::Serializer
  attributes :id, :bearer_id, :bearer_type, :token 
end
