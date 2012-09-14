// Copyright (c) 2011, XMOS Ltd, All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

#include <platform.h>
#include "xtcp.h"
#include "xhttpd.h"

ethernet_xtcp_ports_t xtcp_ports = ETHERNET_XTCP_DEFAULT_PORTS_INIT;

// IP Config - change this to suit your network.  Leave with all
// 0 values to use DHCP
xtcp_ipconfig_t ipconfig = {
  //		{ 0, 0, 0, 0 }, // ip address (eg 192,168,0,2)
  		{ 192, 168, 1, 178 }, // ip address (eg 192,168,0,2)
		{ 0, 0, 0, 0 }, // netmask (eg 255,255,255,0)
		{ 0, 0, 0, 0 }  // gateway (eg 192,168,0,1)
};

// Program entry point
int main(void) {
       chan xtcp[1];

	par
	{
               on ETHERNET_DEFAULT_TILE: ethernet_xtcp_server(xtcp_ports,
                                                              ipconfig,
                                                              xtcp,
                                                              1);


		// The webserver
		on stdcore[0]: xhttpd(xtcp[0]);

	}
	return 0;
}
