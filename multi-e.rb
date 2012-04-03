load 'statlib.rb'

FILE='multi-e'
DIST=(1..15).to_a | [20] 
STEPS=500
SAMPLES=1_000_000

# no funcs from, lib, <= multiple values too specific

def gaus
	s,sum,last=[],0,0
	DIST.each do |i| 
		(i-last).times{sum+=rand;last=i}
		s<<sum/i
	end
	s
end

a=Hash.new 
SAMPLES.times do
	r = gaus()
	r.map! do |e|(e*STEPS).floor.to_f/STEPS end	
	DIST.each_with_index do |d,i|
		a[r[i]]||=Array.new DIST.size,0
		a[r[i]][i]+=1
	end
end

open FILE ,?w do|f|
	a.sort.each do |step,vals|
		tx="#{step}, #{vals.join ", "}" << $/
		f << tx
	end
end



cmd=<<EE
set style data lines
t= "multi-e"
set output "multi-e.png"
set terminal png enhanced size 1920, 1080
plot t,t u 2,t u 3,t u 4,t u 5,t u 6,t u 7,t u 8,t u 9,t u 10, t u 11, t u 12, t u 13, t u 14, t 15, t u 17
EE
