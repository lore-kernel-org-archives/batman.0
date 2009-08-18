Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 18 Aug 2009 20:56:39 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090818185639.GA561@pandem0nium>
References: <20090818081041.GL3168@ma.tech.ascom.ch>
	<200908181051.10826.sven.eckelmann@gmx.de>
	<20090818085903.GN3168@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20090818085903.GN3168@ma.tech.ascom.ch>
Subject: Re: [B.A.T.M.A.N.] batman-adv applying for an official Ethertype?
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Andrew,

i'm only aware of ether-wake which uses 0x8042 as (unregistered) ethertype =
to send=20
WOL packets and was obviously used in scyld beowulf systems according to=20
the manpage [1]. Wireshark also recognizes these packets [2].

I know this ethertype because we used this ethertype in our first batman-adv
implementations as well (because it is such a nice number ...). ;)

Maybe we find someone funding the money for the ethertype some time, but cu=
rrently
i don't know anyone who would be interested in this.

According to the Ethertype list from the IEEE [3], our ethertype 0x4305 is=
=20
currently not in use, so the chance to collide is quite low.

best regards,
	Simon

[1] http://linux.die.net/man/8/ether-wake
[2] http://wiki.wireshark.org/WakeOnLAN
[3] http://standards.ieee.org/regauth/ethertype/eth.txt

On Tue, Aug 18, 2009 at 10:59:03AM +0200, Andrew Lunn wrote:
> > We know about it. Nobody gave us the money yet... and I think it will n=
ever=20
> > happen that a rich boy come to us and give us that money just for 16 bi=
t...
>=20
> The fee is about equivalent to 3 man days of work. So its not that big
> a sum for a commercial entity wanting to use batman in a product.
>=20
> However, when i posed this question, i had Linux mainline in the back
> of my head. Would batman get into mainline when it is using an
> unofficial ethertype? I guess i need to see if any other protocol is
> using an unofficial ethertype.
>=20
>       Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqK+WcACgkQrzg/fFk7axZARgCeIDt/jkjOxW9gj2c2qU3M7N4y
BWwAoOW6YetNEm3oJ5vf0HcQqLCn3M0y
=1b6Q
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
