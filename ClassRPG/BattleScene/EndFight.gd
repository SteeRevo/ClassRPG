extends States

func enter(host):
	host.stateName.set_state_name("End of Fight")
	print("End of fight")
	
