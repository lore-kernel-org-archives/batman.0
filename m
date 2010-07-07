Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 7 Jul 2010 15:49:22 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007071433.59862.clemens-john@gmx.de>
	<20100707124417.GC10395@ritirata.org>
In-Reply-To: <20100707124417.GC10395@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2256882.y6tKQURo0D";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007071549.31203.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2256882.y6tKQURo0D
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch 07 Juli 2010, 14:44:17 schrieb Antonio Quartulli:
> > Yes the network is working well but in this setup the central dhcp serv=
er
> > is the only gateway because I only get the defaultroute of this server.
> >=20
> > What if I have more gateways? I know that I can set the defaultroute to
> > this server by hand but a "normal" user can=C2=B4t do this. I need a me=
thod
> > to choose the gateway individually and automatically so that the user
> > gets the best gateway available.
> >=20
> > Are there any ideas to do this? Or am I completely on the wrong way?

Marek asked me to describe our setup a bit more particularly so I=C2=B4ll t=
ry to:

We have several clouds that can not see each other via WLAN.
These clouds are connected to each other with Tinc VPN via the Internet.
Batman runs only on WLAN, not on the VPN.
The clients usually have no Batman advanced but connecting via a wlan=20
interface which is bridged with bat0.
The Tinc VPN interface is bridged with bat0 too.

All Nodes which are not a gateway have a link local IPv6 address only.
We have a node with a DHCP server which is also gateway.
This node has an IPv4 address and distributes IPv4 addresses with DHCP.
Clients now get an IPv4 address from this node and set their default route =
to=20
this node to get Internet.=20

The exact setup (only configurationfiles) is listed here:
http://wiki.freifunk-ol.de/index.php?title=3DOpenWrt_Freifunk_B.A.T.M.A.N-
advanced_konfiguration_2

With Tinc we are now well decentralised but we currently have the centralis=
ed=20
gateway solution left so we would also like to decentralize the Gateway thi=
ng.
That means multiple gateways with DHCP servers in different clouds (but not=
 in=20
every cloud).
Each client should in theory have access to any gateway, but in practice th=
ey=20
always get automatically access to the internet via the best possible gatew=
ay.

The question why the traffic is in some cases first routet through the VPN =
and=20
then headed to the Internet is pretty easy to answer:
We have 3 clouds. In two of them are people who are confident (the whole is=
=20
indeed always a matter of law) with offering a gateway. The third cloud now=
 in=20
theory is connected to the Internet.
But the person who offers the connection to the VPN does not want to head t=
he=20
traffic of the network through his connection direcly to the internet (beca=
use=20
of reasons of law) so clients in this cloud have to use a gateway on the ot=
her=20
side of the VPN.

> If I'm not wrong, at this point you could put a dhcp server on each
> gateway and use the gw-mode feature of batman, so that each gw will
> anounce itself as gw and a dhcp request, becoming from a client, will be
> redirected to the best gw in the mesh.
>=20
> Please someone corrects me if I am wrong.

This sounds interesting. Is this practicalbe? Has somebody tried this alrea=
dy=20
or does someone know a better solution?

Btw.: Big thank you for so much patience ;)
I=C2=B4m also online on irc so maybe we can discuss these questions there?

Greetings
Clemens

--nextPart2256882.y6tKQURo0D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkw0heMACgkQZgdHbA22lqMuOgCfdMgPTCUp2KMEAg6NM+YA4CYm
YI4Anjc8P6uZyqy8cuKGLSInInzjJKsq
=ViuZ
-----END PGP SIGNATURE-----

--nextPart2256882.y6tKQURo0D--
