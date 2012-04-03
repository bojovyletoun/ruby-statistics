load "statlib.rb"

STEPS=300
SAMPLES=100
DIM=5

vals=Array.new(SAMPLES) do
	sum=0
	STEPS.times do
		r=0
		DIM.times do r+=rand**2 end
		if r<1 then  sum+=1 end
	end
	sum.to_f/STEPS*2**DIM
end

vals.inform
