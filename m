Return-Path: <antonio@meshcoding.com>
Message-ID: <558AE222.4050806@meshcoding.com>
Date: Wed, 24 Jun 2015 19:00:18 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1435150249-25322-1-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1435150249-25322-1-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="88WN3fBMVtJaFFCDTOO0aEgQwurFKJb1M"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete deleted
 attribute for gateway node
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
Cc: Simon Wunderlich <simon@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--88WN3fBMVtJaFFCDTOO0aEgQwurFKJb1M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/06/15 14:50, Simon Wunderlich wrote:
> @@ -537,9 +529,15 @@ void batadv_gw_node_update(struct batadv_priv *bat=
_priv,
>  		/* Note: We don't need a NULL check here, since curr_gw never
>  		 * gets dereferenced.
>  		 */
> +		spin_lock_bh(&bat_priv->gw.list_lock);
> +		hlist_del_rcu(&gw_node->list);
> +		spin_unlock_bh(&bat_priv->gw.list_lock);
> +

have you verified that we can't get to this point through two threads
and enter the same problem that Sven and Marek have been discussing and
fixing in these days: removing an element from a list twice

If this is possible, you should check that this element is in the list
before deleting it.

Cheers,

--=20
Antonio Quartulli


--88WN3fBMVtJaFFCDTOO0aEgQwurFKJb1M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViuImAAoJEOb/4TMchkvfMr8P/inWAEKue6zSvMbKOvYmJKay
vRq4lZx/susadyffSyK0f4ADRrU7AqKcEO3kcUzsFVAWm2pFjS8LNL43q013cTOd
bM/KwRaSN7hmstk/AluZHAPhC65HutWGdGB51Lueivm6fnP8Q1A1/AKdbqn54p8/
e52BbbtGmnfsm0dZBWsPBZ0/BIbEh8pRV6d5+z6/HG+Xxzvkhky1KYCEMZwR+agv
6sxd9L4FvBuIlN6/0D99uR+TPu+MWYPdjC9xfVM9ijc0ubNzl5TEJYj+X/0dfQhB
Mmz6SnXIqv8KhdLlLCpWrMhBOWDUYa0x/IFDXOWk/Z8zN8R5yfFZblKr3c9LOap6
e9Ucbv6qXOgpGb7WgkpENKKVnqshv6jjgv2CQWBbujHqPI96H+H7jLaWwjTqQMzN
AVb2AiUUhY/ULTTfxfmBjyWlT0hByXGowJNi9w+MwkUfP1V0tu2IhnvwPBUGv9LT
kzuAKtPj3i8y7EkbhZ7BpNPA0o4o2ZX5M8B6PcnEhTNZFHo63SXCl6p98LJ2hz+X
iFLmSqvb0PQk+bTyQijzO1RNVTGrSB38iXHLvdrDDThSktdxBd9PDl33NPzMWFQU
IFmxNisMUMg768IyWukbfL3x2l0lPxcZ27AOkYaWvAaKvx2AbfTclFqMq9wti7Xw
IZ/ePnC36QBaKYUWDD1z
=QIGC
-----END PGP SIGNATURE-----

--88WN3fBMVtJaFFCDTOO0aEgQwurFKJb1M--
