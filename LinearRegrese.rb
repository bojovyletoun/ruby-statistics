N=1 #gaus generator # chyba nezavisla
DEVI=10 # chyba roste linearne
RANGE=1..9 #mereni 1A, 2A..10A # chyba jen se limitne blize nekam
POCETMERENI=1 # pocet mereni pro jeden proud # chyba -||-

load 'statlib.rb'

def gen # sekvence [proud, [mereni1,mereniN]]
	data=(RANGE).map{ |i| 
		[ i, Array.new(POCETMERENI) { i*50+DEVI*gausnumero(N) } ] 
	}
end

def compute(data) 
	y_,x_=0,0
	v=data.each do |j|
		x,y=j[0],j[1].avg
		y_+=y*x
		x_+=x*x
	end
	y_/x_
end

Array.new(104900){compute gen}.proceed