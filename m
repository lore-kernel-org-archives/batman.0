Return-Path: <ordex@autistici.org>
Date: Tue, 17 Apr 2012 09:25:38 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120417072537.GB32239@ritirata.org>
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
	<20120417071241.GA32239@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20120417071241.GA32239@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add get_ethtool_stats()
 support
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 09:12:42AM +0200, Antonio Quartulli wrote:
> On Tue, Apr 17, 2012 at 01:24:55 +0200, Martin Hundeb=C3=B8ll wrote:
> > +static void bat_get_ethtool_stats(struct net_device *dev,
> > +				  struct ethtool_stats *stats, u64 *data)
> > +{
> > +	struct bat_priv *bat_priv =3D netdev_priv(dev);
> > +
> > +	data[0] =3D bat_priv->bat_stats.forward;
> > +	data[1] =3D bat_priv->bat_stats.mgmt_tx;
> > +	data[2] =3D bat_priv->bat_stats.mgmt_rx;
> > +	data[3] =3D bat_priv->bat_stats.tt_request_tx;
> > +	data[4] =3D bat_priv->bat_stats.tt_request_rx;
> > +	data[5] =3D bat_priv->bat_stats.tt_response_tx;
> > +	data[6] =3D bat_priv->bat_stats.tt_response_rx;
> > +	data[7] =3D bat_priv->bat_stats.tt_roam_adv_tx;
> > +	data[8] =3D bat_priv->bat_stats.tt_roam_adv_rx;
> > +	data[9] =3D bat_priv->bat_stats.dat_request_tx;
> > +	data[10] =3D bat_priv->bat_stats.dat_request_rx;
> > +	data[11] =3D bat_priv->bat_stats.dat_reply_tx;
> > +	data[12] =3D bat_priv->bat_stats.dat_reply_rx;
> > +}
>=20
> (guess mode ON) why using u64? what if the arch is 32bit? are the values
> correctly assigned anyway? what about longer addresses (do they exist?)?
> As Sven suggested on IRC, you probably want to use uintptr_t instead.


Sorry drop this part. I need to sleep more. Damn.


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjRrxAAoJEFMQTLzJFOZFRzgH/06+dVN0e/3OUHVnR6rx6Ha8
6vPv2x85ICtmJ9oi6oxTQf1htOQbND0KMMhgMzMkInoqnV5T3PZIQ42gKDSfTjIC
Xd6DAhRZKRQ31pY08iN4QPRwSZ6p1krtUZaviTPSJYmjJ3zIil5/Kox0/BjxsL0Q
Pl/DzyZ0IoYe22N4t9veKzM7K+rYj7UtZdzJO8Q/X1HL24CqNRVcTqaW9MsakqcF
rjPNwH+/cyJozTAU/7AlISJ139tpCIXCkf3OKlXFmTmj0gODYJ61mQ/jrZ0tHIz4
ytIadc5vgryuPL4vqMGlS+Qz+Rlf5Yf5PIXvdeVOOxt50nkCyGrAtznu4WnNZ1Q=
=jir0
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
