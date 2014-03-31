Return-Path: <baantunes@gmail.com>
From: Bruno Antunes <baantunes@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Message-Id: <0643725B-CC5E-4AAA-8908-C6A0EA4CE631@gmail.com>
Date: Mon, 31 Mar 2014 12:23:52 +0100
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: [B.A.T.M.A.N.] Batman-adv 2014.1.0 and 2014.0.0 issues with 3.10
	and 3.8 kernels
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi,

Are recent batman-acv versions unusable with 3.10 or 3.8 kernels?

The reason i'm asking is that with 2104.1.0 with two connected sta after =
restarting the wifi
(also the same if restarting all the network) it gives the following =
message:=20

root@Laguna1:/etc/config# wifi
[37620.920000] batman_adv: bat0: Interface deactivated: adhoc0
[37621.140000] batman_adv: bat0: Removing interface: adhoc0
[37621.250000] br-mesh: port 2(bat0) entered disabled state
[37621.250000] device bat0 left promiscuous mode
[37621.260000] br-mesh: port 2(bat0) entered disabled state
[37631.340000] unregister_netdevice: waiting for adhoc0 to become free. =
Usage count =3D 1
[37641.390000] unregister_netdevice: waiting for adhoc0 to become free. =
Usage count =3D 1
[37651.410000] unregister_netdevice: waiting for adhoc0 to become free. =
Usage count =3D 1
=85

And only restarting is possible to get the device back to work.

Going back to 2014.0.0 it's worst with the system being very unstable =
and continuously restarting.

After following the instructions from cmsv <cmsv@wirelesspt.net>
and replacing the feeds.conf with
src-git routing https://github.com/libre-mesh/openwrt-routing-packages

I was able to compile the 2013.4.0 release which is very stable.

But I really would like the vlan support from recent releases.

My systems are:=20
Laguna board
OpenWrt trunk r38938
batctl 2013.4.0 [batman-adv: 2013.4.0]
Linux Laguna1 3.8.13 #6 SMP Thu Mar 27 16:10:18 WET 2014 armv6l =
GNU/Linux

Router station
OpenWrt trunk r38938
batctl 2013.4.0 [batman-adv: 2013.4.0]
Linux RSPro2 3.10.18 #2 Thu Mar 27 18:24:29 WET 2014 mips GNU/Linux

Thanks in advance,
Bruno



