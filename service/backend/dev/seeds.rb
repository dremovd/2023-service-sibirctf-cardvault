require 'pry'
require 'json'
goods = JSON.parse(File.read('../seed/goods.json'))
images = JSON.parse(File.read('../seed/images.json'))

res = goods.map do |good|
  item = images.find { |image| image['name'].downcase.gsub(/\W+/, '') == good['item'].downcase.gsub(/\W+/, '') } || {}
  next unless item

  {
    "item": good['item'],
    "price": good['price'],
    "img": item['img']
  }
end
File.write('../seed/res.json', res.to_json)
