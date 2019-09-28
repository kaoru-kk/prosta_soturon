input_day = "2019-09-02"

all_time = current_user.timers.where(created_at: input_day.in_time_zone.all_month)

array_time = (all_time.group(:created_at).sum(:total)).to_a

slice = array_time.count
array = Array.new(slice, 0)

(0..slice-1).each do |f|
	array[f] = array_time[f][1]
end

p array

