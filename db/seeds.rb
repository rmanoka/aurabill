# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


menu = Item.where(name: 'Menu',
                  audio_clip: 'Coffee.wav').first_or_create do |p|


  
  food = Item.where(name: 'Food',
                    audio_clip: 'Food.ogg').first_or_create do |p|

    dosa = Item.where(name: 'Dosa',
                      audio_clip: 'Dosa.ogg').first_or_create do |p|
    end
    ItemRelationship.create(item: p, sub_item: dosa)


    samosa = Item.where(name: 'Samosa',
                        audio_clip: 'Samosa.ogg').first_or_create do |p|
    end
    ItemRelationship.create(item: p, sub_item: samosa)
    
    
  end
  ItemRelationship.create(item: p, sub_item: food)


  drinks = Item.where(name: 'Drinks',
                      audio_clip: 'Drinks.ogg').first_or_create do |p|

    coffee = Item.where(name: 'Coffee',
                        audio_clip: 'Coffee.ogg').first_or_create do |p|
    end



    
    tea = Item.where(name: 'Tea',
                     audio_clip: 'Tea.ogg').first_or_create do |p|
    end



    
    sdrinks = Item.where(name: 'Cool Drinks',
                         audio_clip: 'Cool_Drinks.ogg').first_or_create do |p|

      
      coke = Item.where(name: 'Coco Cola',
                        audio_clip: 'Coca_Cola.ogg').first_or_create do |p|
      end

      pepsi = Item.where(name: 'Pepsi',
                         audio_clip: 'Pepsi.ogg').first_or_create do |p|
      end

      sevenup = Item.where(name: '7up',
                           audio_clip: '7up.ogg').first_or_create do |p|
      end
      

      ItemRelationship.create(item: p, sub_item: coke)
      ItemRelationship.create(item: p, sub_item: pepsi)
      ItemRelationship.create(item: p, sub_item: sevenup)

      
    end


    ItemRelationship.create(item: p, sub_item: coffee)
    ItemRelationship.create(item: p, sub_item: tea)
    ItemRelationship.create(item: p, sub_item: sdrinks)
    
    
  end
  ItemRelationship.create(item: p, sub_item: drinks)

end




  # Drinks
  # -> Coffee, Tea, Soft Drinks



