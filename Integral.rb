load 'statlib.rb'

def int(a,b,steps)
	sum=0.0
	r=b-a
	steps.times {
		x=rand*r 
		sum+=yield x
	}
	sum*r/steps
end

p int(  0, PI, 1000000) { |x| sin(x) }
