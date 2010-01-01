Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 1 Jan 2010 20:53:25 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100101195325.GA20226@pandem0nium>
References: <20100101175259.GB31328@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20100101175259.GB31328@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Missing unlocks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

thank you, i've commited a patch for this in revision 1529. This should fix=
 this bug
and make sparse happy. :)

best regards,
	Simon

On Fri, Jan 01, 2010 at 06:52:59PM +0100, Andrew Lunn wrote:
> Hi Simon
>=20
> I just built batman-adv with make C=3D1 so that sparse it used to check
> the code. It found a few missing unlocks...
>=20
> drivers/staging/batman-adv/routing.c:585:12: warning: context imbalance i=
n 'recv_my_icmp_packet' - different lock contexts for basic block
>=20
> This is the return if the skb_copy() fails.
>=20
> drivers/staging/batman-adv/routing.c:640:12: warning: context imbalance i=
n 'recv_icmp_ttl_exceeded' - different lock contexts for basic block
>=20
> Same again.
>=20
> drivers/staging/batman-adv/routing.c:695:5: warning: context imbalance in=
 'recv_icmp_packet' - different lock contexts for basic block
>=20
> and same again...
>=20
> in each case you are missing a=20
>=20
> spin_unlock_irqrestore(&orig_hash_lock, flags);
>=20
> before the=20
>=20
> return NET_RX_DROP;
>=20
>     Andrew
>=20

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks+UrUACgkQrzg/fFk7axbpGQCfV3zRL1RocxBCjZ6lh7pUwnCg
F8MAniMru40c8laMojVIy+YqGWv1Xttz
=hjXd
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
