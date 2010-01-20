Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 20 Jan 2010 10:51:52 +0100
References: <20100119145806.275330@gmx.net>
	<201001201015.59477.lindner_marek@yahoo.de>
	<20100120092904.181520@gmx.net>
In-Reply-To: <20100120092904.181520@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3316944.qZIj9y49QN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001201051.55528.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andrew Lunn <andrew@lunn.ch>

--nextPart3316944.qZIj9y49QN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Juha Yl=F6nen wrote:
> -------- Original-Nachricht --------
>=20
> > Datum: Wed, 20 Jan 2010 10:15:59 +0800
> > Von: Marek Lindner <lindner_marek@yahoo.de>
> >
> > Complete configuration means: brctl show, ifconfig, cat /proc/net/batma=
n-
> > adv/interfaces (or batctl if) and ping output.
>=20
> Could be the first one in the list as brctl fails. CONFIG_BRIDGE is not
>  configured in the device kernel. Is batman-adv dependent on this? I'll
>  recompile the kernel and see what happens (it's a slow process), in the
>  meanwhile, what other kernel configurations are needed for batman-adv?

No, bridge stuff is not really a dependency. Only many configurations use i=
s=20
to bridge the bat0 and for example the ethernet interface together. The=20
dependencies of 0.2 are currently PROC_FS and PACKET.

Just as side note for the futyre: Configure the mtu of bat0 to match the mt=
u=20
of your other devices in the bridge or otherwise big packets will be droppe=
d=20
while bridging.

@Andrew: We don't depend on PACKET after the merge of the skb based transfe=
rs.=20
Please remove it from Kconfig - we need NET instead.

Best regards,
	Sven

--nextPart3316944.qZIj9y49QN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLVtI4AAoJEF2HCgfBJntGAbkP/3rs/y6k+2XQc9ulhDe2eImA
VGvttZc1i0Abkx1kJCNkePZ+tJZdF6Bakfe0q/lUwDkJqFKVzgxUhcfYZ22Deepf
pJRaVisPXMcYUXnviEfVM6I9rU58w5abuZy9DagW7TGIBCAY7r0fZbbuJ7yPno2a
V8YHOWX1P+uaWP8Ww3gFrrsQBxWIO36O/VsRtwDRmYMvg1JdrliORF6UxLCwL0QF
5MzoWU8AS1kqd5kcOG1XTewzPvF7KObUTPj92NCr+z1VRF5C8IBVAv+LoQkaXWDW
7kjpx499PkK1jzmn3bdz/YsBElbIU5ze98N1k3oN4yw0FQ68ZKKrfi/6pBGuub5j
VdxZCBidPuZVcJ7Awz8uQMLx5vuMz4b5C7AicwISEKGq270O8SSDWQ0pWhfkSt8q
tAqYW6P2O5tS2cgLx+FMNmieblOEzXLYjk9uFrgpIiH7gRcMGmtFCYcBur0umQ1b
0dwAYgZKgqw7IuAhIBHMtJ5Bc46yQoWqO6g8XCB2WutJbPPOTCID95pRJK/wWG5B
OpjRxKFoGKx42BtvAjqFF2nccwYWq3C+dOYLeQA2vEwx1EPyMzqq+x7k59LLV8T4
lcO9bC6lnlap2BE7DRIMHCspXdXDNy34O83VrwItalLth4dthKoP8+GJPhpEq034
3EGQjzSJgUEoWx3PWXd3
=QoUy
-----END PGP SIGNATURE-----

--nextPart3316944.qZIj9y49QN--
