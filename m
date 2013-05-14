Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 14 May 2013 11:45:01 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130514094501.GC16545@pandem0nium>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <1367931069-7177-7-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/9] alfred: Enable Link-time optimization
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
Cc: Sven Eckelmann <sven@narfation.org>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 02:51:06PM +0200, Sven Eckelmann wrote:
> Link-time optimization allows to move parts of the optimization from the =
single
> source file to the global source view. This is done by emitting the GIMPLE
> representation in each object file and analyzing it again during the link=
 step.
>=20
> This reduces the binary size by around 10% on mipsel (this includes parts=
 which
> were also removed by garbage collection).
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  alfred/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
Applied in revision bbc581c (alfred package feed).

Thanks,
    Simon


--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGSB50ACgkQrzg/fFk7axbJFgCfag4/vXfF9w1MlsnSPR4yYVt2
p7cAnAtGEt8994cAFjquUIP1S9Ft0ArK
=Cuoq
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
