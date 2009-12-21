Return-Path: <bittorf@bluebottle.com>
Date: Mon, 21 Dec 2009 10:23:59 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20091221092358.GF26298@alix.l28.local>
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22C241@RESQNAOEX01.qnao.net>
	<2ced936d0912191025k5fbdbf45s2c1b16d241850549@mail.gmail.com>
	<20091219191559.GA2932@Linus-Debian>
	<200912201601.05350.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
In-Reply-To: <200912201601.05350.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] wireless adapter and linux kernel version
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* elektra <onelektra@gmx.net> [20.12.2009 16:00]:
>=20
> iwconfig <interface> ap 01:CA:FF:EE:BA:BE
>

hi elektra,

please don't do the mistake again:

ad-hoc cell's must begin with 02: to keep it clean.
(means IMHO: unicast + locally administered)

http://en.wikipedia.org/wiki/MAC_address

so use: 02:BE:EF:CA:FF:EE 8-)

bye, Bastian. - cu @ 26c3

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksvPq0ACgkQDonSpHhHLlxpLwCeIr5bLjWFR7UkkIXAugqjb9Rz
NrEAniIvfI58h0XwLg3dwjrlqdEtKrLV
=zBCn
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
