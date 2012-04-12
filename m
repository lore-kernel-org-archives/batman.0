Return-Path: <ordex@autistici.org>
Date: Thu, 12 Apr 2012 08:50:23 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120412065022.GA8528@ritirata.org>
References: <1333832769-28493-1-git-send-email-ordex@autistici.org>
	<20120408223751.GA10101@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20120408223751.GA10101@pandem0nium>
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


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2012 at 12:37:51AM +0200, Simon Wunderlich wrote:
> Hey Antonio,
>=20
> thanks a lot for fixing my style bugs!!
>=20
> There is a little bug in one (one line doubled), otherwise:
>=20
> Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>=20
> Cheers,
> 	Simon

Hi guys,

I'm sorry, but I didn't make this "double line" fix in the last pull-reques=
t.
So, please commit this patches as they are. We need another clean up patch =
that
will be sent within the next pull-request.

Cheers,

>=20
> On Sat, Apr 07, 2012 at 11:06:06PM +0200, Antonio Quartulli wrote:
> > ** this patches are for batman-ad/next ***
> >=20
> > After my first pull request, David S. Miller hardly suggested me to fix=
 some
> > problems that I am going to summarise here. Please respect such suggest=
ions in
> > your next patches:
> >=20
> > 1) Multi-line comments must end with */ on a new line:
> >=20
> > /* ..
> >  * ..
> >  */
> >=20
> > 2) if we use #ifdef in our headers to redefine some functions depending=
 on the
> > fact that we are compiling a component or not, we must use static inline
> > functions doing nothing with the correct parameters instead of simple
> > "foo(...)". In this way we can allow the compiler to check for the type=
s and the
> > number of arguments:
> >=20
> > Instead of:
> >=20
> > #define bla_init(...) (1)
> >=20
> > we must do:
> >=20
> > static inline bla_init(struct bat_priv *bat_priv)
> > {=20
> > 	return 1;
> > }
> >=20
> >=20
> > Other than David's complaining I also get a suggestion from Bernd Petro=
vitsch
> > about the type of stp_addr (it should be "static const uint8_t []" inst=
ead of
> > "uint8_t []" only). I applied such change in patch 2/3.
> >=20
> > Cheers,
> >=20
> >=20
> >=20



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPhnsuAAoJEFMQTLzJFOZF/CUH/2vnVXHbaHbHUA8GGs9+BCBo
VDrKwrhZGlqowIg5YBn1QNRBRQFy8kcwEdQ6yOGtglpLYEvvqFA0MbnHtMfLVkRx
a1UHnePxv/N0DWlfLVp+1GpL+C9ussqRToTGxo54HxEMs1RYqwVJmRJf5vLuFV7t
/8NDwRb5mAoMyeJbOFZu6VCPKuXCv6DZ+P6hoFQZ6bRhKxK3m7R/pBIWILEAhmoE
pc7dr5V1jbnsVqSoPO+31Wwpe99GJflRxmdUlBnAsp8+Endo1PDLGKTOxmDMbq+P
bwRxzsSUFyJ1/56qrvzTgH21iU/tTEsoEaW1n3lGBTEEvOL5afgpYIWEk6ts8nw=
=Cq8W
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
