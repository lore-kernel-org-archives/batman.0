Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 7 Jul 2010 12:33:47 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007070021.43888.clemens-john@gmx.de>
	<201007070030.30940.lindner_marek@yahoo.de>
In-Reply-To: <201007070030.30940.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2914312.nlniSfZsAr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007071233.56171.clemens-john@gmx.de>
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

--nextPart2914312.nlniSfZsAr
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch 07 Juli 2010, 00:30:30 schrieb Marek Lindner:
> > Now batman advanced nodes behind the VPN does not get listet in the
> > originator tables of nodes on the other side of the VPN.
> > But do they get listed on the gateway list? Can Batman advanced choose a
> > gateway behind the VPN?
>=20
> No, because the gateway information travel with the OGMs which you don't
> have on your VPN. Sending dhcp requests via unicast also does not work
> because the VPN interfaces are not controlled by batman.

I just had another Idea but I=B4m not shure if this will work.

If we don=B4t use the Batman advanced gateway feature but run a DHCP Server=
 on=20
gateways only, would a client always choose the "nearest" DHCP server?

So if I=B4m connected wireless to a router that is a gateway and runs a dhc=
p=20
server would my laptop always choose this router as defaultroute also if th=
ere=20
are other routers in the network with a dhcp server running?

If this works I can not choose the "best" gateway, but I would always have =
the=20
nearest gateway.

If this works, is it possible that all dhcp servers distribute the same ip=
=20
range? Will a client/server notice which IP=B4s are already assigned to cli=
ents?

Thank you
Clemens

--nextPart2914312.nlniSfZsAr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkw0WAwACgkQZgdHbA22lqNYQgCg8jIEKMLRMGyo9bP1vlWhtBcD
LoEAoN5kUjUaU7hj8kx/dcG4HN9HKf8b
=3HB7
-----END PGP SIGNATURE-----

--nextPart2914312.nlniSfZsAr--
