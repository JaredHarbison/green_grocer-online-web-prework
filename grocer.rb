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
    apply_coupons_hash = {}
      coupon_items = [] # get coupon item names
        coupons.each do |item|
          coupon_items << item[:item]
        end
    cart.each do |item|
      name = item[0]
      attributes = item[1]
      num_of_coupon = 0
      coupon_price = 0
      coupons.each do |coupon_hash| #get num and cost of that particular item from coupons hash
        if coupon_hash[:item] == name
          num_of_coupon = coupon_hash[:num]
          coupon_price = coupon_hash[:cost]
        end
      end
      num_of_coupon #quantity of item required for coupon to work

      if ((coupon_items.include?(name)) && (attributes[:count] >= num_of_coupon))
      #for the current item, if the count is >= coupon quantity requirement
      #decrease the item count and add the coupon hash 
      quantity = (attributes[:count] / num_of_coupon) #item quantity/coupon quantity
        apply_coupons_hash[name] = {:price => attributes[:price], :clearance => attributes[:clearance], :count =>(attributes[:count] - (num_of_coupon * quantity))}
        apply_coupons_hash[name + ' W/COUPON'] = {:price => coupon_price, :clearance => attributes[:clearance], :count => quantity}
      else #if no coupon for this item, then just add the existing item hash to apply_coupons_hash
        apply_coupons_hash[name] = {:price => attributes[:price], :clearance => attributes[:clearance], :count => attributes[:count]}
      end
    end
    apply_coupons_hash
 end

#####################################################################################

def checkout(cart, coupons)
end