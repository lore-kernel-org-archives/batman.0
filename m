Return-Path: <gbastien@versatic.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_fRPPnr/RtSnCoslmWT3/5A)"
Message-id: <4FE3DA9B.9040401@versatic.net>
Date: Thu, 21 Jun 2012 22:38:19 -0400
From: =?ISO-8859-15?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
References: <4FE1350E.9040807@versatic.net>
	<201206211028.18281.lindner_marek@yahoo.de>
In-reply-to: <201206211028.18281.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] packets not processed by batman on eth0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This is a multi-part message in MIME format.

--Boundary_(ID_fRPPnr/RtSnCoslmWT3/5A)
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12-06-21 04:28 AM, Marek Lindner wrote:
> Hi,
>
>> I talked to marec last week on irc (I'm tahini).  I have a linksys
>> router that runs batman on the eth0 interface and other routers or
>> laptops are connected to it.  Problem is, even though the batman packets
>> pass from the other machines to the linksys, it seems something weird
>> happens on the linksys and the interface is not recognized as a batman
>> neighbor.
> the problem is that leon does not receive any packets from its neighbors.=
 Its
> log only repeatedly states "Sending own packet" but no information about
> incoming packets is printed. If you compare it with the other logs you wi=
ll
> see what I mean.
But doesn't the 'batctl td eth0' output show it receives the packets=20
from the neighbors?  What happens to those packets?

> A common mistake leading to this symptom is a bridge misconfiguration. Is=
 eth0
> on leon part of a bridge ?
No, the bat0 interface is on the bridge, but eth0 is a vlan, I think. =20
Maybe it is a vlan misconfiguration?
Attached are some outputs and config files from leon.  What other=20
commands should I look for to help find the problem?

Thanks,
Genevi=E8ve

--Boundary_(ID_fRPPnr/RtSnCoslmWT3/5A)
Content-type: text/plain; CHARSET=US-ASCII; name=leon_files
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=leon_files

root@leon:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		8000.8a62a119c9ef	no		bat0


root@leon:~# batctl if
eth0: active


root@leon:/etc/config# cat batman-adv

config 'mesh' 'bat0'
	option 'interfaces' 'mesh1'
	option 'aggregated_ogms'
	option 'ap_isolation'
	option 'bonding'
	option 'fragmentation'
	option 'gw_bandwidth'
	option 'gw_mode'
	option 'gw_sel_class'
	option 'log_level'
	option 'orig_interval'
	option 'vis_mode'
	option 'bridge_loop_avoidance'

# yet another batX instance
# config 'mesh' 'bat5'
#	option 'interfaces' 'second_mesh'



root@leon:/etc/config# cat network

config switch 'eth0'
	option enable '1'

config switch_vlan 'eth0_0'
	option device 'eth0'
	option vlan '0'
	option ports '0 1 2 3 4 5'
	#option ports '0 1 2 3 5'

config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config interface 'lan'
	option proto 'static'
	option netmask '255.255.0.0'
	option ipaddr '172.16.11.1'
	option type 'bridge'
	option _orig_ifname 'eth0'
	option _orig_bridge 'false'
	option ifname 'bat0'

config interface 'wan'
	option ifname 'eth1'
	option macaddr '00:0c:41:14:e0:90'
	option proto 'dhcp'

config interface 'wifi'
	option 'proto' 'static'
	option ipaddr '192.168.22.1'
	option netmask '255.255.0.0'

config interface 'bat0'
	option ifname 'bat0'
	option proto 'none'
	option mtu '1500'

config interface 'mesh1'
	option proto 'none'
	option ifname 'eth0'
	option mtu '1528'


--Boundary_(ID_fRPPnr/RtSnCoslmWT3/5A)--
