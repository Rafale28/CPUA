declare ALU {
	input	Fn[4];
	input	inA[16];
	input	inB[16];
	output	outY[16];
	output	outZ;

	func_in	exe(Fn,inA,inB):outY;
}

declare CPUA {
	input	datai[16];
	output	adrs[16];
	output	datao[16];
/////////debug signal///////
	output	cpuen;
	output	pc[16];
	output	op[16];
	output	im[16];
	output	st[16];
	output	ra[16];
///////////////////////////
	func_in	start(datai);
	func_in	hlt();
	func_out memory_read(adrs):datai;
	func_out memory_write(adrs,datao);
}

declare SHIFT16 {
	input a[16];
	input b[4];
	input c[4];
	input flag;
	output q[16];

	func_in exe(a,b,c,flag):q;
}

declare CLA16 {
	input a[16];
	output b[16];
	func_in exe(a):b;
}

