json.array! @restaurants do |restaurant|
    json.partial! 'restaurants/restaurant', restaurant: restaurant
end