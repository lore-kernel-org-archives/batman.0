Return-Path: <ordex@autistici.org>
Date: Sun, 29 Apr 2012 11:12:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120429091253.GB30759@ritirata.org>
References: <1335690403-25228-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <1335690403-25228-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Free local translation
 table on error in tt_init
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


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 29, 2012 at 11:06:42AM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <ordex@autistici.org>

Thank you Sven!

> ---
>  translation-table.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index 88c62f1..c3b7773 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -1776,8 +1776,10 @@ int tt_init(struct bat_priv *bat_priv)
>  	if (!tt_local_init(bat_priv))
>  		return 0;
> =20
> -	if (!tt_global_init(bat_priv))
> +	if (!tt_global_init(bat_priv)) {
> +		tt_local_table_free(bat_priv);
>  		return 0;
> +	}
> =20
>  	tt_start_timer(bat_priv);
> =20
> --=20
> 1.7.10

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPnQYVAAoJEFMQTLzJFOZF5R8IAIicNWeQ2ojCcHzGatg2F3t2
AFhTN5SgXnQ9A5h/j3lcecF1E01tEophoLIiQSnAOXtEuYmUObzZ6pGRVtcns+nH
3YEVKBnZDfBVpstsuwVmqP6DgvhEfb5NE0eDZGIVWDqNS/yMmlKgZinYxY4MQXad
XtcWr6boddPOb+EnU0ibNhMMKdfuImxfqQ9OU9Fk0xv4O2o18otitBn5Qj+ahYPz
c4hCRs1LOnPrv2AuvL4zTQQtmCo7vewzwi7SyhFR8/Jwc/a+L800KjL6JbWpWBtz
sylzEdsXUWYKNhTZMwH3yLd7j3xMXQQjFkqkn3yMO7xHFbN54/Qyod194LZgBwQ=
=o3us
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
