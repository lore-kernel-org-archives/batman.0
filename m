Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 7 Aug 2014 10:29:36 +0200
References: <53E32F6D.3010207@aliyun.com>
In-Reply-To: <53E32F6D.3010207@aliyun.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201408071029.36757.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] how to make IP layer handle the change of
	network topology
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi liu,

> Hello, eveyone, I am learning the batman.adv recently.
>=20
> We know that batman.adv works on layer 2. When the network topology chang=
e,
> batman.adv can know this change and handle it. But the IP layer doesn't
> know that. How to make IP layer handle the change of network topology?

The IP layer does not need to know - to the upper layers, a batman-adv netw=
ork=20
appears to be a network where all nodes are just one hop away - although th=
ey=20
might be more far away in practice. So if you insert an IP packet, it will =
get=20
transported automatically to the right destination (provided batman-adv kno=
ws=20
where that is), even over multiple hops.=20

>=20
> For example, I have 3 mesh nodes, client node A, gateway node B and getew=
ay
> node C. A connects  to internet via B. Then I shutdown B. I guess A will
> switch to C as it's gateway node automatically. But it's not so. A
> continuously send the ARP request packet to search the MAC address of B.
> The default gateway is still B, not C.

This will only work if the gateways IP stays the same. This could work like=
=20
that:
 * connect B and C to the same LAN, and enable bridge loop avoidance in=20
batman-adv
 * This LAN should have only one router to the internet (e.g. your ADSL=20
modem).
 * bridge the batman-interface bat0 and you Ethernet interface eth0 using a=
=20
linux bridge device



>=20
> So, how should I do to make the IP layer be aware of that the gateway has
> swithed to another one?
>=20
> Thanks! Best regards.
>=20
> liu
=2D--
Mit freundlichen Gr=FC=DFen / kind regards
Simon Wunderlich

=46on: +49 (0) 3741 / 2518068-0
=46ax: +49 (0) 3741 / 2518068-9
