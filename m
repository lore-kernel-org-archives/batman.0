Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 8 Nov 2013 10:51:26 +0100
References: <2578313.zUW7Pc5dQb@flohlap>
 <201311041128.20618.sw@simonwunderlich.de> <4645807.Ug7HQD34Gu@flohlap>
In-Reply-To: <4645807.Ug7HQD34Gu@flohlap>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201311081051.26384.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Bad link quality if routers are connected by 2
	interfaces
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
To: Clemens John <clemens-john@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hey Clemens,

> Am Montag, 4. November 2013, 11:28:20 schrieben Sie:
> > this is certainly not the expected behaviour. Are you building a bridge
> > loop by any chance? Please explain your configuration (batctl if, brctl
> > show, ...) and check if you have a high amount of broadcasts somehow.
>=20
> Sorry for my late answer. I was busy during the week and didnt find the
> time to look into out setup in detail till now.
>=20
> We have two wireless interfaces wlan0 and wlan0-1. We also have two
> ethernet interfaces eth0.1 and eth0.3 and one VPN interface ffolVPN.
>=20
> The interfaces wlan0 and eth0.1 are the interfaces used for clients. They
> are bridged together with bat0:
> root@RosenplatzVPN:~# brctl show
> bridge name   bridge id                     STP enabled     interfaces
> br-mesh          8000.a0f3c15b54a6   no                    bat0
>                                                                          =
 =20
>      eth0.1 wlan0
>=20
> The interfaces wlan0-1 and eth0.3 are the interfaces we use for meshing
> with other routers in the same "mesh cloud". These are the interfaces both
> routers are connected by each other. The vpn interface ffolVPN is used to
> connect with outher "mesh clouds" but the two routers in this case are not
> connected by this interface. On the interfaces wlan0-1, eth0.3 and ffolVPN
> runs Batman advanced:
> root@RosenplatzVPN:~# batctl if
> eth0.3: active
> wlan0-1: active
> ffolVPN: active
>=20
> To analyze the amount of broadcast traffic I did a tcpdump on the Batman
> interfaces wlan0-1 and eth0.3. For me there seems to be a big amount of
> broadcast traffic, but I don=B4t know the normal level of brodcasts so I
> can=B4t compare which amount is right and which is wrong. But maybe you c=
an
> so I uploaded the files for you. You can analyze them using wireshark or
> some other tool:
> * https://dev.freifunk-ol.de/tcpdumps/eth0.3.dump
> * https://dev.freifunk-ol.de/tcpdumps/wlan0-1.dump
>=20
> If you need more data just ask and I will try to provide it.

Thanks for the explanation and the dumps! I had a look at your dumps, but i=
t=20
doesn't look like a bridge loop - the number of broadcasts is normal. I don=
't=20
have a clue yet where this behaviour comes from. I'd like to make a few mor=
e=20
suggestions for debugging:

 * can you please make a debug log of batman-adv on the two nodes at the sa=
me=20
time (batctl ll batman && batctl l > logfile.$hostname or something like th=
is)

 * what are the MAC addresses of these two nodes?
As far as I see in the debug output, on one node there is:
 * Ethernet fa:d1:11:af:fd:15
 * WLAN fa:d1:11:af:fd:16

However, a2:f3:c1:5b:54:a6 is used as Ethernet source address for sending i=
n=20
both eth0.3 and wlan0-1 dumps. Is it possible that there is a mac address=20
conflict?

Cheers,
    Simon
