Return-Path: <ordex@autistici.org>
Date: Sat, 5 May 2012 16:49:41 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120505144940.GB3041@ritirata.org>
References: <1336116752-585-1-git-send-email-sven@narfation.org>
	<1336217249-16071-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <1336217249-16071-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Only set hash class
 after hash is initialized
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


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2012 at 01:27:27 +0200, Sven Eckelmann wrote:
> We must be sure that there was no error during the creation of the hash b=
efore
> we can set the hash lock class. The class set function was added to the w=
rong
> place in 2c9aa3b4c37bd55148f5f25212c89e7bf5f28497
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bridge_loop_avoidance.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index 8bb274b..48831c2 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -1169,13 +1169,13 @@ int bla_init(struct bat_priv *bat_priv)
>  	bat_priv->claim_hash =3D hash_new(128);
>  	bat_priv->backbone_hash =3D hash_new(32);
> =20
> +	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
> +		return -1;
> +

if one hash_new succeeds and and the other fails, should we free the alloca=
ted
structure before returning?


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPpT4EAAoJEFMQTLzJFOZFEcAIAJBKt/sfCnmDJWIb79BKi603
mC4mqyn0WvMbTLQrii6ROEBbu9gjGXlX2PaqoiBJp7UaY1KaiUXp5YTnddeGYtax
rFdbGgwd/BA7X9QcSK4SvoBDQwx5YXmtqAFce4qFIUP2Ip4FCWv/rz7DqjN9LBKB
hniZ0LCcgf1bS63m4krnvm+GOwtkrJjrwBQMbEhu98UI+U63wJn9dGVfHqzz5TKN
2yGuIkXpObvJAKPXXUcpAGMGoCNli3ZjeC+hW9NwsXc26/2frftqBUvZ467EdOxK
BsNatUlJmxb3B7ALyw9hK6xvxJOxRJFppp8FLvU2lg+L7pfv1S5aqwRaXDhpT0Q=
=5PhL
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
