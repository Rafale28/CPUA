#include <stdio.h>
#include <iostream>

#include <verilated.h>
#include "debug/obj_dir/VCPUA.h"

using namespace std;

VCPUA *cpua_i;

unsigned long int pc;

double sc_time_stamp(){
	return pc;
}

void init(){
	cpua_i->m_clock=0;
	cpua_i->p_reset=0;
	cpua_i->eval();
	cpua_i->m_clock=1;
	cpua_i->p_reset=1;
	cpua_i->eval();
	cpua_i->m_clock=0;
	cpua_i->p_reset=0;
	cpua_i->eval();
	pc=0;
}

void falling_clock(){
	cpua_i->m_clock=0;
	cpua_i->p_reset=1;
	cpua_i->eval();
}

void rising_clock(){
	cpua_i->m_clock=1;
	pc++;
	cpua_i->eval();
}

int main(int argv,char *argc[]){

	int i=0;

	cpua_i = new VCPUA();

	init();

	while(i<0xf){
		falling_clock();

		//input
		cpua_i->a=i;
		cpua_i->b=i;
		cpua_i->exe=1;

		rising_clock();

		//output
		printf("%x %x\n",i,cpua_i->c);

		i++;
	}
	return 0;
}

