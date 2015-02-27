class ItemRelationship < ActiveRecord::Base
  belongs_to :item
  belongs_to :sub_item, :class_name => 'Item'
end
