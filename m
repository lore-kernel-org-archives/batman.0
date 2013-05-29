Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 16:12:46 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529141246.GP3333@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-3-git-send-email-ordex@autistici.org>
 <20130529140950.GA23657@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sy9WyBOsCRoUO165"
Content-Disposition: inline
In-Reply-To: <20130529140950.GA23657@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [RFC 02/10] batman-adv: make struct
 batadv_orig_node algorithm agnostic
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


--sy9WyBOsCRoUO165
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:09:51PM +0200, Simon Wunderlich wrote:
> > -	if (!orig_node->bcast_own_sum)
> > -		goto free_bcast_own;
> > +	spin_lock_init(&orig_node->bcast_seqno_lock);
> > +	reset_time =3D jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION=
_MS);
> > +	orig_node->bcast_seqno_reset =3D reset_time;
> > +	orig_node->batman_seqno_reset =3D reset_time;
>=20
> Why are you moving this stuff around in the function? I don't see the pur=
pose ... reset_time
> or bcast_seqno_lock are just moved, but not changed.

well, if you look some lines above you see the vlan stuff being
allocated....hence this is a rebase error :) while merging this change with=
 tt-vlan I
introduced the error.
[...]

> >  	struct list_head vlan_list;
> >  	spinlock_t vlan_list_lock; /* protects vlan_list */
> > +	struct batadv_orig_bat_iv bat_iv;
> >  };
>=20
> Same here: there are various fields which are just moved around for no ob=
vious
> reason (bcast_seqno_lock, batman_seqno_reset, bcast_seqno_reset, last_see=
n, last_ttl,
> ...)

yeah sorry. as before, probably an issue triggered by a rebase.
Luckily this is just an rfc and not the final patchset :)

Thanks!



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--sy9WyBOsCRoUO165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpgzeAAoJEADl0hg6qKeO8+kP+wYgyuPSJnz2i3jo/s+JbfOK
LhvyVqVuylpD38jGZn6nRJXAqRP/74g4BUw2wq1sK9wQY6pDD01lhXFjm6sIIAu6
hVIXDlV6gXwWsUnMbtetv+GWHgCH4fyW+Tlt3LK07rHdXF5atltgK62WnNB3JWuy
32Xlwbsm+KJXu0zKPcHiTyIBPZS9fvx1wm8rPKUnV0+E6c8RtrCQPQRgQbnBZ/SL
v0AYd7vJMmbonkZ7VFfon4mGSRfhKfk5kmmmbjdJc/Y+oup4zxOT1qx2NXGphUjr
53weaMlQ3bCrRJ8XBCE9EYStDYOSMlbayVsgng8mt1c76CwNWqJDZYZuzNFSDy6W
t09KO1Ba7ummK3atYAJ1TmMWJuWEBvvf3fvxV1+dud+KDX9iw8pWQflv06demtpO
AMnYM8YPyBttRZTQrfJ27BjP23S5Zs5mqSW/c9u8Axcf8faeI75f7/6rVLKBxrZe
Xj2hSgHdR9IgyeTucrbq0wUbFPzDQMKmkCjcfVsSkavpQ3uC2KHnLzAO2QhcVymE
iifN2gGYlEJkDy2zQo2VUYxOt8cwDASxI1uo9MP5xJLODmeYM8amoFcLzN5NioYD
BGir3BP1VJmWJ1GQmoetWHsnXo58Bt4ly9tJ1lByPwGL7Y22nxLvISehD9hnKtGD
lMD6L9JC+7FarRAIEF5I
=k8e7
-----END PGP SIGNATURE-----

--sy9WyBOsCRoUO165--
