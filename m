Return-Path: <ditwal001@gmail.com>
From: "Walter Robert Ditzler" <ditwal001@gmail.com>
Date: Tue, 5 Jun 2012 22:09:51 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de-ch
Subject: [B.A.T.M.A.N.] bridging problem
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

hi batman list,

i have problem setting up batman-adv "clients". i could need some help
indeed.

thank you very much for replying!

walter


what i want
**********

| eth0  bat0(wlan0) | <mesh network> | bat(wlan0) eth0 |  <ethernet>
(backbone lan)


| wlan0 (Client)       |

my questions:
***********
1) do i need 2 wifi network cards in the mp box to connect with wireless
hosts (laptop's)?
2) if yes, how can i make the bridging to work form connected hosts
(laptop's) and eth0?

with what i work
**************
1) alix2 boards
2) debian 6.0.5
3) kernel 3.4 486

what i did
********
#!/bin/bash

ifconfig eth0 down
ifconfig wlan0 down
ifconfig wlan1 down

iw dev wlan0 del
iw dev wlan1 del

iw phy phy0 interface add mesh0 type adhoc
ifconfig mesh0 mtu 1528
iwconfig mesh0 mode ad-hoc essid adradix_mesh ap 02:12:34:56:78:9A channel 3

batctl if add mesh0

ifconfig mesh0 0.0.0.0 up
ifconfig bat0 0.0.0.0 up
ifconfig eth0 0.0.0.0 up

brctl addbr br0
brctl addif br0 bat0
brctl addif br0 eth0
ifconfig br0 10.10.10.11 netmask 255.255.255.0 up

route add default gw 10.10.10.1

exit 0;


