Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <580D980A.1090707@yahoo.com>
Date: Mon, 24 Oct 2016 13:11:38 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: i found time delay is very high and there are more caution info
 , if possible , please give me some advisement
References: <580A26A4.5030005@yahoo.com> <1744565.jjMyA2xSBQ@bentobox>
In-Reply-To: <1744565.jjMyA2xSBQ@bentobox>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?ISO-8859-1?Q?Linus_L=FCssing?= <linus.luessing@c0d3.blue>


Hello Dear Sven and Linus:

                                             You are right , and When i 
check /sys/class/net/bat0/mesh/*   and i found  archlinux lost 
network-coding .

                            They were connected via a single cable as you .

                            Whether i need use older batman version (batman-adv and batctl 2015.2 ) ?

                            and our version is newest version ( Linux alarmpi 4.4.26-1-ARCH ) and hardware platform is raspberry pi B , but

                            i search wiki , i found kernel 4.4 will usebatman 2015.2

                            https://www.open-mesh.org/projects/open-mesh/wiki/Download

                            linux 4.4 => batman-adv 2015.2 (get batctl 2015.2 fromhere  <https://downloads.open-mesh.org/batman/stable/sources/batctl/>).


                                if batman-adv don't support archlinux really , whether ubuntu will support batman-adv .




                                Thanks


                                



[root@alarmpi ~]# grep '' /sys/class/net/bat0/mesh/*
/sys/class/net/bat0/mesh/aggregated_ogms:enabled
/sys/class/net/bat0/mesh/ap_isolation:disabled
/sys/class/net/bat0/mesh/bonding:disabled
/sys/class/net/bat0/mesh/bridge_loop_avoidance:enabled
/sys/class/net/bat0/mesh/distributed_arp_table:enabled
/sys/class/net/bat0/mesh/fragmentation:enabled
/sys/class/net/bat0/mesh/gw_bandwidth:10.0/2.0 MBit
/sys/class/net/bat0/mesh/gw_mode:off
/sys/class/net/bat0/mesh/gw_sel_class:20
/sys/class/net/bat0/mesh/hop_penalty:30
/sys/class/net/bat0/mesh/isolation_mark:0x00000000/0x00000000
/sys/class/net/bat0/mesh/multicast_mode:enabled
/sys/class/net/bat0/mesh/orig_interval:1000
/sys/class/net/bat0/mesh/routing_algo:BATMAN_IV

