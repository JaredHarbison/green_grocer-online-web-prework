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

def apply_coupons(cart:[], coupons:[])
  result = {}
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
end	

def checkout(cart, coupons)
end