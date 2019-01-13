def consolidate_cart(item)
  final = Hash.new 0 
  count = :count
item.each do |hash|
  hash.each do |food, description|
if final.has_key?(food) == false
  final[food] = description
  final[food][count] = 1
elsif final.has_key?(food)
final[food][:count] +=1
end
end
end
final
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def apply_coupons(cart, coupons)
end
def checkout(cart, coupons)
end