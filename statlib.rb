t=Time.now;at_exit {puts "T: #{Time.now-t} s"}

include Math

def gausnumero(ndis=6)
	sum=-0.5*ndis
	ndis.times {sum+=rand }
	sum*(12.0/ndis)**0.5
end

module Enumerable
	def sum;    inject { |mem, var| mem+var } end
	def avg;    sum.to_f/(size) end
	def avgs;   sum.to_f/(size-1) end
	def stdev;  t=avg; (inject(0) do |mem,i|  mem+(i-t)**2 end/(size))**0.5 end
	def stdevs;  t=avg; (inject(0) do |mem,i|  mem+(i-t)**2 end/(size-1))**0.5 end
	# There was slow down!!!! (i-t) <-----> (i-avg)


	def inform
		a,s,ss = avg, stdev,stdevs
		puts "AVG : %s" % [a]
		puts "s   : %s" % [s]
		puts "ss  : %s" % [ss]
		puts "var : %s %%" % [s/a.abs*100]
		puts "vars: %s %%" % [ss/a.abs*100]
	end

	def proceed (steps=100,sym=false)
		inform
		hist(steps,sym).sort.export ?h
	end

	def proceed2 (steps=100)
		inform
		hist2(steps).sort.export ?h
	end

	def proceed3 (steps=100)
		inform
		export ?d
	end

	def export(ext=nil,file=File.basename($0).sub(/\.rb$/,''))
		open file << (ext ? ?. << ext : '') ,?w do |f|
			each do |step, vals=nil|
				f << "#{step}, #{vals}\n"
			end
		end
	end

	def hist(steps,sym)
		a=Hash.new 0        
		each do |res|
			a[(res*steps).ceil.to_f/steps]+=1
			a[((1-res)*steps).ceil.to_f/steps]+=1 if sym # buggy, if dev<1
		end
		a
	end

	#alternate grouping
	def hist2(steps)
		d=max-min
		return group_by {|e| (e.to_f/d*steps).floor*d/steps }.map{|e,v| [e,v.size]}
	end
end
