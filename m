Return-Path: <ordex@autistici.org>
Date: Thu, 23 May 2013 11:06:58 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130523090658.GE1679@ritirata.org>
References: <1369248377-16466-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <1369248377-16466-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: forward late OGMs from best
 next hop
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


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 08:46:17PM +0200, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> When a packet is received from another node first and later from the
> best next hop, this packet is dropped. However the first OGM was sent
> with the BATADV_NOT_BEST_NEXT_HOP flag and thus dropped by neighbors.
> The late OGM from the best neighbor is then dropped because it is a
> duplicate.
>=20
> If this situation happens constantly, a node might end up not forwarding
> the "valid" OGMs anymore, and nodes behind will starve from not getting
> valid OGMs.
>=20
> Fix this by changing the is_duplicate behaviour: It will only mark
> duplicates which are received for the same neighbor. OGMs which are not
> from the best next hop will be dropped within batadv_iv_ogm_forward()
> anyway. Therefore, late OGMs are forwarded now and not dropped as
> duplicates.
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Thanks for sending this Simon.

However, even if not reported in the subject, this patch is for maint.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRndwyAAoJEADl0hg6qKeOj3YP/A0bNuAj4o+A+/EFy6SSeUJW
Mj4l6bxIKlONULk0RZBgb10bpEA2etSVyK1ue+UY16lHpYbMEc5ujCoCdQfNZED/
RgJHJj9dKMtBb8FAwwzaTsKtEpxKnTdV8LkXOH5jnq8UHd/Mkoq2wZ0zBFpu5xlk
GNNtvmmUT4NK5yMP8mlZnooISPJJW4K/I95BObSzWfC+EFRzcX1nwTVONEM3X/bM
77zCjuehS7gIvPHDMPn+f3N8Q4NI04IaryIbxtM6u4v9Ty/iU1bGubzugWppRv1c
JZkqNw4YD1ecefSp0FWzKxj2owoc3mWieJEea1ldyrRyJQPewicOIXVtzmBOcW4F
9RFnuxElIfPICES+U0YGwvUlLKmTx/IXgwNgtlrV7Ra3uWRC0AxheQiGl59d03nB
fBuy/ppBnCR8w03y5MvUwyTU4e2CbkEF5UVrJSulgnVqi/htnIGcclT3VZnsJf/p
s8EeBJ+99WWXiDCqRmBStaGGvS+aiZmJwKbaKLKnj7wJ/W4kpeHaTvwpoLXZcjtM
CxActqqzNLUoL7Lw9Ro+weAiivQgXOcA1oJL5CE06vd8GFORj13NSF+BD5z7igcz
UyuVJKbsTbLzbAinRWLvyEUcEBMXAbxSZt+AWWzdKe277SZeVvHlBwvMbL3hOOF1
7cKxq3d9SAkQaBZOfjzO
=YTCk
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
