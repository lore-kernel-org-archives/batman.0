Message-ID: <460E7B0C.3030904@bb.banban.jp>
Date: Sun, 01 Apr 2007 00:15:24 +0900
From: Lemonde <zukky@bb.banban.jp>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Relaese: freifunk-batman_0.83.ipk
References: <00e801c73614$8a5c5060$0105a8c0@bluebox>
	<004a01c7734f$ed211f50$fe78a8c0@bluebox>
In-Reply-To: <004a01c7734f$ed211f50$fe78a8c0@bluebox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello, Lui and everyone.

Thank you for your kind work. I've tried.

machine: buffalo whr-hp-g54 x 2
http://www.buffalo-technology.com/products/product-detail.php?productid=124&categoryid=28
one as gateway node (gw) and another as only node (nd)

It seems to work well.
gw:
<nvram>
ff_bat_cron=on
ff_bat_gw_uplink=11
ff_bat_netmig=192.168.1/192.168.2
ff_bat_ran_if=eth1:bat
ff_bat_ran_ip=192.168.2.1
ff_bat_ran_on=1
ff_bat_ran_pf=24
ff_bat_start=1

root@freifunk-batman1:~# ps |grep batman
 1157 root        400 S   batmand -g 11 eth1:bat
 1162 root        400 S   batmand -g 11 eth1:bat
 1164 root        400 S   batmand -g 11 eth1:bat
 1168 root        400 S   batmand -g 11 eth1:bat
 2241 root        420 R   grep batman
root@freifunk-batman1:~# ping 192.168.2.2
PING 192.168.2.2 (192.168.2.2): 56 data bytes
64 bytes from 192.168.2.2: icmp_seq=0 ttl=64 time=1.9 ms
64 bytes from 192.168.2.2: icmp_seq=1 ttl=64 time=1.4 ms
64 bytes from 192.168.2.2: icmp_seq=2 ttl=64 time=1.4 ms
64 bytes from 192.168.2.2: icmp_seq=3 ttl=64 time=1.4 ms

nd:
<nvram>
ff_bat_cron=on
ff_bat_gw_choose=2
ff_bat_gw_uplink=0
ff_bat_netmig=192.168.1/192.168.2
ff_bat_ran_if=eth1:bat
ff_bat_ran_ip=192.168.2.2
ff_bat_ran_on=1
ff_bat_ran_pf=24
ff_bat_start=1

root@freifunk-batman2:~# ps |grep batman
 7236 root        472 S   batmand -r 2 eth1:bat
 7239 root        472 S   batmand -r 2 eth1:bat
 7240 root        472 S   batmand -r 2 eth1:bat
20048 root        268 S   grep batman
root@freifunk-batman2:~# ping 192.168.2.1
PING 192.168.2.1 (192.168.2.1): 56 data bytes
64 bytes from 192.168.2.1: icmp_seq=0 ttl=64 time=3.4 ms
64 bytes from 192.168.2.1: icmp_seq=1 ttl=64 time=1.4 ms
64 bytes from 192.168.2.1: icmp_seq=2 ttl=64 time=1.4 ms
64 bytes from 192.168.2.1: icmp_seq=3 ttl=64 time=1.4 ms


I have some question.
(1) gw shows tun interface,

root@freifunk-batman1:~# ifconfig |grep tun
tun0      Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
root@freifunk-batman1:~#

but nd shows no tun interface.

root@freifunk-batman2:~# ifconfig |grep tun
root@freifunk-batman2:~#

Is this right? Is any setting missed?

(2) From webIF of nd, batman info shows
------------------------------------------------------------------
               | Please wait...
               | S66batman: Connecting B.A.T.M.A.N. (routings)
Statistics:  | S66batman: # batmand -c -b -d 1
               | 192.168.2.1, GW: 192.168.2.1(59) via: 192.168.2.1(59)
-------------------------------------------------------------------
               | S66batman: Connecting B.A.T.M.A.N. (gateways)
               | S66batman: # batmand -c -b -d 2
Gateways: | 192.168.2.1 via: 192.168.2.1(59), gw_class 11 - >6 MBit, 
reliability: 9
               | No gateways in range ...
--------------------------------------------------------------------
Does the last line "No gateways in range ..." mean failure to find 
gateway? If so, why does it happen?

regards,

zukky


Lui wrote:
> Hi,
>
> freifunk-batman_0.83.ipk is out now.
>
> hope it's usefull
> Lui
>   
