#
# Copyright (c) 2015 University of Cambridge
# Modified by Salvator Galea
# All rights reserved.
#
# This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
# under National Science Foundation under Grant No. CNS-0855268,
# the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
# by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
# as part of the DARPA MRC research programme.
#
# @NETFPGA_LICENSE_HEADER_START@
#
# Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  NetFPGA licenses this
# file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#   http://www.netfpga-cic.org
#
# Unless required by applicable law or agreed to in writing, Work distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
#
# @NETFPGA_LICENSE_HEADER_END@
#

# Set variables.
# CORE CONFIGURATION parameters should correspond to hdl params
set sharedLogic		"TRUE"
set tdataWidth		256
set convWidth		[expr $tdataWidth/8]

if { $sharedLogic eq "True" || $sharedLogic eq "TRUE" || $sharedLogic eq "true" } {
   set supportLevel 1
} else {
   set supportLevel 0
}

create_ip -name axi_10g_ethernet -vendor xilinx.com -library ip -module_name axi_10g_ethernet_shared
set_property -dict [list CONFIG.Management_Interface {false}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.base_kr {BASE-R}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.SupportLevel $supportLevel] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.autonegotiation {0}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.fec {0}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.Statistics_Gathering {0}] [get_ips axi_10g_ethernet_shared]

set_property generate_synth_checkpoint false [get_files axi_10g_ethernet_shared.xci]
reset_target all [get_ips axi_10g_ethernet_shared]
generate_target all [get_ips axi_10g_ethernet_shared]
