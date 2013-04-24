Return-Path: <ordex@autistici.org>
Date: Wed, 24 Apr 2013 14:31:16 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130424123116.GG16603@ritirata.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <1366727676-23233-8-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: add per VLAN interface
 attribute framework
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2013 at 04:34:35PM +0200, Antonio Quartulli wrote:
> =20
> +/**
> + * batadv_priv_vlan_free_ref - decrease vlan refcounter and possibly fre=
e it
> + * @priv_vlan: the vlan object to release
> + */
> +void batadv_priv_vlan_free_ref(struct batadv_priv_vlan *priv_vlan)
> +{
> +	if (atomic_dec_and_test(&priv_vlan->refcount))
> +		kfree_rcu(priv_vlan, rcu);

I was just looking at compat.h....I guess this kfree_rcu needs some compat =
work
for kernels older than 3.0.0.

Will add it during the next respin.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRd9CUAAoJEADl0hg6qKeOpKoQAK5ZBqV4iA7vB0GdEjFFbamC
aPwIHovX+5gfTw4vUaBKC+oBHLARwymNjZ9/IQ8xTV2Jw8AjgAwxN7biRHKK+6gc
0kO+mk1hWEl3aqEqSRRnScBdZBOo7pgO4lQDIXhKQ5c6W/XiYjmWX/FqtXIy/++h
DatU4oOrCJ6wZYVpbBGq1aNy+niTWOHs7QP/xDWrJKHslZnaDWJg2PAGSSVpRsHW
YsyXfmMtWKbQzE58Kr9qmAG9mB6ZRptQSYflmBxu1kA+9ZMDBlOXsnhf5ugy7YUn
+xGaDodEEhcsbu+LLSkOnsZRKzWdIf9Bxg+8dOIGMpBDPcafqYTVNoi2hvjCmwjB
h77ifKKvbhSEm3E8Ftg9QLB2+X5CD275XYMStHqAq2GymzQkQXy9eVrFcG5XLt8X
HelhiidjR9guMpdRg8/elh001YNn3MRs3YXyLR0pdyki5dm/yJYAdNnFJdNFxl9d
PulNKm8/fOtOPidBHHG6nV0aFsarW18p+6qDkrr2S8d/K5UOgkyf7dU86xi1gHXS
03Zhz8+1OxeETJ2C/osH/zmhzNCrxczrMexlzyt9uaNy8AhLEBVfSCEdmvheeoXy
XSS328VJqJ8+aKpKcQOszbdcT8RSFWGmsDUjyXWa+6ALRDyhfKUB6M6OqrkFitoH
imZxUs14g21Xank/MsCE
=SrUM
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
