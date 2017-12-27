declare LED {
	input	address[16];
	input	data[16];
	output	led[8];

	func_in	wren(data);
}

