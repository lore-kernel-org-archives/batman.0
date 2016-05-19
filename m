Return-Path: <nick.schaf@jci.com>
From: Nick Schaf <nick.schaf@jci.com>
Date: Thu, 19 May 2016 14:22:58 +0000
Message-ID: <a1c140db68d543d482a22adfbac42670@BLUPR97MB0100.062d.mgd.msft.net>
References: <1462190269.1971.52.camel@biplane.com.au>
 <2079546.oo0Mk8DjMd@bentobox>
In-Reply-To: <2079546.oo0Mk8DjMd@bentobox>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] mesh losing internal Ilayer3 connectivity
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I've run into what sounds like a similar problem, but dove in and found mor=
e details.  Here's the setup:

-19 nodes running BATMAN-adv 2014.14.0 on OpenWrt Chaos Calmer; various har=
dware (D-Link, BBB, Open-Mesh, WRTnode, TP-Link).
-bat0 using ad-hoc interface on each node
-bat0 bridged (br-lan) with Ethernet
-br-lan on all nodes (except node 1) get DHCPv4 address from dnsmasq runnin=
g on node 1
-A few PCs are hard-wired to LAN on node 1, one PC wired to LAN at node 11,=
 all other nodes completely standalone
-WAN on node 1 connected to building network - only connection to any outsi=
de network
-DAT enabled
-BLA disabled

Problem:
After several weeks uptime, node 1 could no longer SSH or ping (L3) node 3.=
  Tcpdumps showed ping rec'd at node 3 and node 3 replied, but reply never =
arrived at node 1.  Linux PC wired to LAN at node 1 successfully pings node=
 3. L2 ping (via batctl) works between nodes 1 and 3.
Further investigation showed two entries for node 1's br-lan MAC in the glo=
bal translation table at node 3.  Secondary entry was correct; primary entr=
y pointed to node 4.  Node 4's tables (local and global) were both correct.

root@WifiMesh-03:~# batctl tg | grep c8:d3:a3:70:a9:b0
* 42:5e:78:f3:50:7e    0   (  2) via c8:d3:a3:70:a9:b0     ( 25)   (0xd7886=
ba8) [....]
* c8:d3:a3:70:a9:b0   -1   ( 19) via c8:d3:a3:70:a9:53     ( 19)   (0x10e48=
56e) [....]
 + c8:d3:a3:70:a9:b0   -1   (  2) via c8:d3:a3:70:a9:b0     ( 25)   (0x352c=
5b78) [....]
 * 42:5e:78:f3:50:7e   -1   (  2) via c8:d3:a3:70:a9:b0     ( 25)   (0x352c=
5b78) [....]=20

(Yes, br-lan and adhoc0 have same MAC on node 1.  Yes, these are D-Link rou=
ters.)
...50:7e is bat0 at node 1, ...a9:b0 is adhoc0/br-lan at node 1, ...a9:53 i=
s adhoc0/br-lan at node 4

This part may be odd: problem persisted for a few days while I investigated=
, but resolved immediately after viewing the tables on node 4.  May be coin=
cidence, though, because it didn't work for the following nodes.

At same time, same problem existed with two other nodes on the mesh: node 1=
3 (an OM2P-HS) matched node 3's global table; node 9 (a WRTnode) showed a p=
rimary entry for node 1's br-lan using yet another originator.  Rebooted no=
des to resolve.
Problem happened again more recently, but the destination MAC was that of t=
he Linux PC mentioned above, attached to the LAN on node 1.  In this case, =
most nodes' global tables showed two entries for that MAC, though the origi=
nator in the primary entry was not consistent.
=20
I plan to test with a more recent version of BATMAN-adv once I standardize =
on one model of hardware for the nodes (should be within the next few month=
s).  In the meantime, I plan to watch for secondary entries in the global t=
ranslation tables since the current configuration should never result one c=
lient being accessible through multiple nodes.

Thanks,
-Nick

=20
-----Original Message-----
From: B.A.T.M.A.N [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On Behal=
f Of Sven Eckelmann
Sent: Monday, May 02, 2016 9:55 AM
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] mesh losing internal Ilayer3 connectivity

On Monday 02 May 2016 21:57:49 Karl Auer wrote:
> My apologies up front for a newbie question in this apparently very=20
> technical list. If there is a more appropriate list or forum please=20
> direct me to it.
>=20
> I'm running batman-adv (Chaos Calmer, r47065) on OpenWRT on the GL
> -AR150 platform.

Are you using v2016.1 or some older version of batman-adv? If you use somet=
hing like v2014.4.

What kind of layer 3 are you using? IPv4/IPv6/...?  What is you current con=
figuration (for example are you have enabled DAT, BLA, ...). Did you check =
what exactly goes over the air and what the device (the adhoc one) receives=
/sends? What is what the data sent/received over the batman-adv devices?

Did you hardcode the mac address of the batman-adv device or are you let it=
 change to a random value on each device creation? Is the device part of a =
bridge or is the IP configured directly on the batman-adv device?

Are you sure that the conntrack for the masquerade over the mesh isn't brok=
en?=20
Why are you masquerade over the mesh anyway?

Kind regards,
	Sven
