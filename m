Return-Path: <a@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-11-git-send-email-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5693D141.5080900@unstable.cc>
Date: Mon, 11 Jan 2016 23:58:57 +0800
MIME-Version: 1.0
In-Reply-To: <1451992006-13191-11-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IDeX5BIimAWc2jTw05faOQlvSC0FvGq3g"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 11/31] batman-adv: Drop reference to
 netdevice on last reference
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IDeX5BIimAWc2jTw05faOQlvSC0FvGq3g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/01/16 19:06, Sven Eckelmann wrote:
> +void batadv_hardif_release(struct batadv_hard_iface *hard_iface)
>  {
> -	struct batadv_hard_iface *hard_iface;
> -
> -	hard_iface =3D container_of(rcu, struct batadv_hard_iface, rcu);
>  	dev_put(hard_iface->net_dev);

Sven,

what is wrong in releasing the releasing the reference to net_dev inside
the RCU callback (except for introducing some delay) ?

Cheers,


--=20
Antonio Quartulli


--IDeX5BIimAWc2jTw05faOQlvSC0FvGq3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk9FEAAoJENpFlCjNi1MRifoP/39yj2wGejY3bEcP99Yjtd8Q
zwejd2AYphNFnbwz71X0QIeiQ+RAuQtfhytZGBo0J7KwRW5rPkyjnzkxRlQj4wRj
sgUZNxrZbHEeQPVg04WqXNTWByhLgvYtt/9gJ6284D+AdF6F+pYt8xF8+5QHKKum
fIiXgQPOQsk2gd4X7W3EdrQjUn4sWa2xP2JRMy5cXy6qWT8OU0dnhnnInEJZq9Lk
9MsittC2t/CvvPPJ6GZ8IoHubfS4preRl4NjwsKY1lxZ4NmhMBLixl96q1sFAkFA
u7ML03na2oiTohzqmhlXNnlZ37wZTjg6uzgy8jUr7MtKiLdtG1FOxbzjKpFOQcQR
mff5BkKr9WXai4BRjAhjLb7KW2wU1KdD2beeTezDzQeGCSfSWZPGqgv/VvKbHSzc
3RgB+iK3gmy1rP5XBUeSS9KrAWK8t2EpK5l0ECR1r0qXzwQEJ6JJtDhrxU+bjwzo
x6bAGqL6TsbO4jwmdAQuxQ9g175po/hXhpygRjAE0iMVad8O0zcc8cEW78BhhXvh
3akNuo2qqILITdIlTIn1B2tnAIxoHbkFPzbXQVtR8GBWPfvWLEjYENTEMs3F3+QD
JVbecC9W21L7dPjTML8MyoW1tBUENEgpL7ptzRDLsYAG1XSOa5lPoGaTCQDe3RnG
ZxHUDR1VoUVGPILGsfOx
=eELH
-----END PGP SIGNATURE-----

--IDeX5BIimAWc2jTw05faOQlvSC0FvGq3g--
