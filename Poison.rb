load 'statlib.rb'
LANDA=3
SAMPLES=5100
HIST_SAMPLES=31000
PROB=LANDA.fdiv SAMPLES

def success
	hits=0
	#SAMPLES.times do  hits+=1 if accept gen end ################ SLOW!
	SAMPLES.times do  hits+=1 if rand<PROB end
	hits
end
	
Array.new(HIST_SAMPLES) {success}.proceed