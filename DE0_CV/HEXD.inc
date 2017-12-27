declare HEXD {
	input	address[3];
	input	data[16];
	output	hex0[4];
	output	hex1[4];
	output	hex2[4];
	output	hex3[4];
	output	hex4[4];
	output	hex5[4];

	func_in	wren(address,data);
}

