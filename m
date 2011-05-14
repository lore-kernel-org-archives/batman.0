Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 May 2011 20:08:20 +0200
References: <1305396082-30309-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1305396082-30309-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2077657.khYvbj3JJy";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105142008.23630.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: reset broadcast flood
	protection on error
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart2077657.khYvbj3JJy
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> The broadcast flood protection should be reset to its original value
> if the primary interface could not be retrieved.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  send.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/send.c b/send.c
> index 76daa46..3377927 100644
> --- a/send.c
> +++ b/send.c
> @@ -421,7 +421,7 @@ int add_bcast_packet_to_list(struct bat_priv *bat_pri=
v,
> struct sk_buff *skb)
>=20
>  	primary_if =3D primary_if_get_selected(bat_priv);
>  	if (!primary_if)
> -		goto out;
> +		goto out_and_inc;
>=20
>  	forw_packet =3D kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);


Acked-by: Sven Eckelmann <sven@narfation.org>

--nextPart2077657.khYvbj3JJy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNzsUWAAoJEF2HCgfBJntGN84P/ixetfpzeP1u1ro2H7yV7uoj
mMCyC5t1GoIyimHfZ4VuFQTdLGxj3/NmcdrMKRodDxzWQuJVNLKF1PCh/1szNsAN
H9eqciDsqf2bPQfSDLDFZbD5z6nOfFkUfI2/CaA5TBwophEDjidjp0DXFA5tlNaQ
V0FFcfQouS7JRDKmYkv9Ojc8zxsCuKXRZykxwd8Kt/r9eWpbCpuxyXaf5Ul659UI
JS971bHIRIYUvxbZQlg1fD1EiFjUw0yNiHF5D8MZQXoElMIIvLvnpYC4sU0a8bLp
ePGIdC0rqIsrC3UKpfBOxeJFNOHKWbWTKhgKLn75JlNoBl32Zw2Rsbubnyd7ErEb
ZRrCjEA14Wxfij4AqbSntIxLbWH5e4LlF6fAkcW5Y1RXNb1eIIN8LbQY0lztkeY5
zGMpltJTtaXVVUfXnjM+WtjAz1b1s2SF5Z8H3W04euSP82DQn86n+WFiQaI5H46Z
UPJZaNiOZVd/jWTn0qXcaEHQwMi+HgPthLrJ7RcmCsVLxtaRAZ/USbB//E4woPc6
d76VUFDaBakvmJTa/TFf9QWBlhUGC/6kHIjMJNaxczXxdo4kUGYsRB9rFseMk8n/
zIuQPZ+Fp9kFUJuqgTuFy3P9Nkedajm/4KZNQKF1uIHDwnBN5e87coPYGruKno8T
1s/w3KfefodWsZw3/VZH
=kNq9
-----END PGP SIGNATURE-----

--nextPart2077657.khYvbj3JJy--
