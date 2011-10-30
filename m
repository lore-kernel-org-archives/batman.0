Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 21:58:26 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111030205826.GA7160@pandem0nium>
References: <1319988980-3548-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<201110302124.31362.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <201110302124.31362.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix style changes
 reported by cppcheck
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Patch 2/2 was created accidently due to my lack of git skills, please
assume [PATCH]. :)

The output of cppcheck (before the applying the patch):=20

$ cppcheck -q --enable=3Dall .
[bat_iv_ogm.c:993]: (style) The scope of the variable 'offset' can be reduc=
ed
[routing.c:980]: (style) The scope of the variable 'ret' can be reduced
[soft-interface.c:695]: (style) The scope of the variable 'ret' can be redu=
ced

Note that reduced scope may be a matter of taste, I could not really find
anything about that in the CodingStyle.

Cheers
	Simon


On Sun, Oct 30, 2011 at 09:24:31PM +0100, Marek Lindner wrote:
> On Sunday, October 30, 2011 16:36:20 Simon Wunderlich wrote:
> > cppcheck reported some style issues this patch fixes.
> >=20
> > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > ---
> >  bat_iv_ogm.c     |    2 +-
> >  routing.c        |    2 +-
> >  soft-interface.c |    2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> Do you mind saying what cppcheck reported ?
> What happened to patch 2/2 ?
>=20
> Regards,
> Marek
>=20

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6tunIACgkQrzg/fFk7axYLBQCfU2nM+jyJ+dhC2Sr5nxsTpQxT
mg0AoJ8DfmOzZyxpMgPVCHxtr6UN6JPE
=AYTu
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
