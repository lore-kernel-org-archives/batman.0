Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <201301040005.05457.lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 17:17:50 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <11DE1CAB-ADE0-429F-97F1-ED38894E1CE1@stephan.homeunix.net>
References: <201301032300.04942.lindner_marek@yahoo.de>
 <6D44E9FE-9AC6-4747-8BF6-52E6647C0625@stephan.homeunix.net>
 <201301040005.05457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Packet-Loss-Peaks in a Freifunk-Network
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

Hello,

Am 03.01.2013 um 17:05 schrieb Marek Lindner:

> On Thursday, January 03, 2013 23:52:42 Jan L=FChr wrote:
>> Well, I started echoing on the underlying VPN-connection as well and
>> changed the chart-titles for clearance:
>>=20
>> In chart 4 and chart 5 RTT / Loss from kif.kbu to node-1 is measured.
>> In chart 4 kif is sending ICMPv6 to the link-local address of
>> bat0-interface - in chart 5 the link_local address of the underlying
>> vpn-interface is used.
>=20
> All tests are from the same node to the same node using exactly the =
same means=20
> (protocols, etc) with the exception of batman-adv ? Sorry for my dumb =
question=20
> but your topology might be obvious to you but isn't for me (us?).

yes.

>=20
> The spikes on your graphs show the packet loss ?

yes.

> How can we have a RTT < 50ms=20
> while experiencing packet loss ?


Collectd uses a ping rate of 10 seconds here, RTT >=3D 0.9s =3D 900ms is =
"loss"
If 1/3 arrives in < 50ms and 2/3 are lost, RTT is < 50ms  while loss =3D =
2/3.

Btw. I you wanna see our setup, we can take a tour via ssh / tmux - I =
can provide the rrd-Files, too.
You can contact my by jabber (yanosz@jabber.ccc.de) as well,

Thanks,
Keep smiling
yanosz

