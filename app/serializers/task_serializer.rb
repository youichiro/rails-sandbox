class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :done, :deadline, :created_at, :updated_at
end
