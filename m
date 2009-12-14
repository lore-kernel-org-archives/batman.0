Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 14 Dec 2009 23:24:14 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091214222414.GA2155@pandem0nium>
References: <20091211210623.GA3538@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20091211210623.GA3538@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batctl] Fix array out of bound	exception
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Linus,

thank you for your patch, i have applied it in svn r1496.

On Fri, Dec 11, 2009 at 10:06:23PM +0100, Linus L=C3=BCssing wrote:
> This patch fixes an array out of bound exception in line 201 of
> functions.c. We need to reserve one extra character for the
> appended null character.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>=20
> Index: batctl/functions.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- batctl/functions.c	(revision 1491)
> +++ batctl/functions.c	(working copy)
> @@ -161,10 +161,10 @@
> =20
>  	if (read_opt & USE_READ_BUFF) {
>  		read_ptr =3D read_buff;
> -		read_len =3D sizeof(read_buff);
> +		read_len =3D sizeof(read_buff)-1;
>  	} else {
>  		read_ptr =3D lbuff;
> -		read_len =3D sizeof(lbuff);
> +		read_len =3D sizeof(lbuff)-1;
>  	}
> =20
>  open:
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksmuw4ACgkQrzg/fFk7axY93wCg2nqxbHeous0Y5EMJ+5JWmzEr
R1cAoO3PSZpLpNxDA36JJ6f91KP1RrmJ
=aG1C
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
