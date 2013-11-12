Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <5282A184.1020704@altermundi.net>
Date: Tue, 12 Nov 2013 18:45:40 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <525B11F2.5030605@altermundi.net>
In-Reply-To: <525B11F2.5030605@altermundi.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] mad mad batman ...
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


back in Quintana... this problem is still showing in every node. The networ=
k is unstable and so it's difficult to debug. If anyone has a clue as to wh=
ere to look for the origin I'll be glad to read your thoughts.

cheers,
Nico


El 13/10/13 18:34, Nicol=E1s Ech=E1niz escribi=F3:
> While I'm still in Europe I've observed that the network in Quintana has
> started performing very poorly today. It was working perfectly fine
> until yesterday.
>=20
> The logs on every router have started showing entries like these:
>=20
> Oct 13 18:09:43 frigorifico kern.warn kernel: [12018.150000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.040000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.040000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.550000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.550000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.570000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.580000] br-lan:
> received packet on bat0 with own address as source address
> Oct 13 18:09:46 frigorifico kern.warn kernel: [12021.040000] br-lan:
> received packet on bat0 with own address as source address
>=20
> As you can see there are many per second.
>=20
>=20
> I've pasted a bit of batctl ll batman; batctl log here:
>=20
> http://pastebin.com/HX1LBPK4
>=20
>=20
> ...it's only showing the "originator packet from myself" lines and one
> line before. (the sample is less than 5 secs of logs)
>=20
> Every node I checked is showing the same.
>=20
>=20
> Last time this happened it was due to a router that had been affected by
> a nearby lightning bolt. The switch went crazy.
> It took a while to detect it and the network was 15 nodes big. Now it's
> 40 and we are quite far away :)
>=20
>=20
> If anyone has an idea of how to better test where the problem is
> originated, I'll be glad to hear it. Also if any batman devel wishes to
> log in to the net to check first hand, just let me know.
>=20
>=20
> Cheers!
> Nico
>=20
>=20
> PS: batman version is 2012.4
>=20

