Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 9 Apr 2012 00:37:51 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120408223751.GA10101@pandem0nium>
References: <1333832769-28493-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1333832769-28493-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/3] clean up patches
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


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

thanks a lot for fixing my style bugs!!

There is a little bug in one (one line doubled), otherwise:

Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Cheers,
	Simon

On Sat, Apr 07, 2012 at 11:06:06PM +0200, Antonio Quartulli wrote:
> ** this patches are for batman-ad/next ***
>=20
> After my first pull request, David S. Miller hardly suggested me to fix s=
ome
> problems that I am going to summarise here. Please respect such suggestio=
ns in
> your next patches:
>=20
> 1) Multi-line comments must end with */ on a new line:
>=20
> /* ..
>  * ..
>  */
>=20
> 2) if we use #ifdef in our headers to redefine some functions depending o=
n the
> fact that we are compiling a component or not, we must use static inline
> functions doing nothing with the correct parameters instead of simple
> "foo(...)". In this way we can allow the compiler to check for the types =
and the
> number of arguments:
>=20
> Instead of:
>=20
> #define bla_init(...) (1)
>=20
> we must do:
>=20
> static inline bla_init(struct bat_priv *bat_priv)
> {=20
> 	return 1;
> }
>=20
>=20
> Other than David's complaining I also get a suggestion from Bernd Petrovi=
tsch
> about the type of stp_addr (it should be "static const uint8_t []" instea=
d of
> "uint8_t []" only). I applied such change in patch 2/3.
>=20
> Cheers,
>=20
>=20
>=20

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk+CEz8ACgkQrzg/fFk7axbpNgCePbNB9Z7lmgKvNjoblm6Jv1E+
TzEAoNMzyXsZYm1r+ldDtlQq5nRnwtlx
=uOwJ
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
