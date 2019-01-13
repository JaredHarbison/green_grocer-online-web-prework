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
  coupons.each do |coupon_hash|
    fruit_name = coupon_hash[:item]
    new_coupon_hash = {
      :price => coupon_hash[:cost],
      :clearance => "true",
      :count => coupon_hash[:num]
    }
     if cart.key?(fruit_name)
      new_coupon_hash[:clearance] = cart[fruit_name][:clearance]
      if cart[fruit_name][:count]>= new_coupon_hash[:count]
        new_coupon_hash[:count] = (cart[fruit_name][:count]/new_coupon_hash[:count]).floor
        cart[fruit_name][:count] = (coupon_hash[:num])%(cart[fruit_name][:count])
      end
      cart[fruit_name + " W/COUPON"] = new_coupon_hash 
    end
    end
  return cart
end


#####################################################################################

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(cart, coupons)
  
  clearance_applied = apply_clearance(coupons_applied)
  #puts clearance_applied
  clearance_applied.each do |item, item_hash|
    if item_hash[:count] < 0 
      item_hash[:count] = -(item_hash[:count])
    end
    if !item.include?('W/COUPON')
      if clearance_applied[item][:count] < clearance_applied["#{item} W/COUPON"][:count]
        clearance_applied["#{item} W/COUPON"][:count] = clearance_applied[item][:count]
      end
    end
    #if clearance_applied[item][:count] < clearance_applied["#{item} W/COUPON"][:count]
      #clearance_applied["#{item} W/COUPON"][:count] = clearance_applied[item][:count]
    #end
    total += (item_hash[:price] * item_hash[:count])
    puts total
  end
  if total >= 100
    total = total - (total *0.10)
  else 
    total
  end
end
