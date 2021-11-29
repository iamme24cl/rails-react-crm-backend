class ProspectSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :probability, :stage
  belongs_to :company
end
