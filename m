Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 9 Nov 2010 10:20:44 +0100
References: <1289260381-6415-1-git-send-email-sven.eckelmann@gmx.de>
	<1289260381-6415-2-git-send-email-sven.eckelmann@gmx.de>
	<20101109083204.GA450@Sellars>
In-Reply-To: <20101109083204.GA450@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1478071.kEKmWj1LC7";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011091020.45241.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use kernel functions to
	identify broadcasts
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

--nextPart1478071.kEKmWj1LC7
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> > is_broadcast_ether_addr(x) =3D> is_multicast_ether_addr(x)
> >=20
> > or when looking more at the implementation:
> >=20
> > (FF:FF:FF:FF:FF:FF =3D=3D x) =3D> [(01:00:00:00:00:00 & x) !=3D
> > 00:00:00:00:00:00]
>=20
> [...]
>=20
> > -	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
> > +	if (is_broadcast_ether_addr(ethhdr->h_dest)) {
> >=20
> >  		ret =3D gw_is_target(bat_priv, skb);
>=20
> So, shouldn't that be the other way round?
> is_multicast_ether_addr() instead?

Correct.

Best regards,
	Sven

--nextPart1478071.kEKmWj1LC7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJM2RJsAAoJEF2HCgfBJntGdhoP+gO0t+fl28U9t6gSYA3G4Ydl
+XFNKzJSI7ZV1+ODbq9U7nPvekFwGom7uJCKhHLzzlW7vDrn6ttDwqocADxZWoe9
LCogblF2ENqn4Nti3nJDZ4jBvwnkI/OPCMmhjWf2zZsFU3025JkdY7A6fzjsRh+A
AThmENiXcCovT3OXWFF1HPHjD5uKSSHcsc03d/jwHHv/x6UOl6CyrILaybvKzbcC
IjMEvEbaI21Ab4ynVMmem3tqAPO2DcVxobPOlpJ36/xisbGzcr86AEbhWbg4YuKw
2PgVktzL34fLKVUPkLdsCQEyf1P0thLuexhOwJUdPfyT5jCBi19Z2xSAFBQTd1Ii
EDLfr1b2BMHV+qMBBdTQMw+sNkAN2LlB0BdwDNRSX/ItmoHUkc95S11tdSrQST2J
JassvHuwV0LwVf2PNRVxyZqUpWs5K3BSd48MkitpZmFMRdePBM7xgK7nBToOnuAw
4KXu1hAgjCy6p66RJBt/d2TerKdIdvzaQZ2YeLjoOtvFHgztcmKJVzLlJRK7xWOb
5H+T8ToHIyVlq06ceqXmhS6ilvjG8bLIaye9IBlQebBTmPoedSZpKeYOewmHW3kv
tNyEKF2mtmtZDB5EkuLeGh4mh6s6gxSHzZb8QEkxnzH0NcWgL+2Z3J6BAf9NHQY1
VMBp4PO28Dhak349DjZO
=wjI4
-----END PGP SIGNATURE-----

--nextPart1478071.kEKmWj1LC7--
