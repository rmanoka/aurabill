class Item < ActiveRecord::Base
  has_many :item_relationships
  has_many :sub_items, :through => :item_relationships

  def parent
    ItemRelationship.where(sub_item: self).first.try(:item)      
  end
end
