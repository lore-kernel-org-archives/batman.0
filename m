Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 14 May 2013 11:41:42 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130514094142.GA16545@pandem0nium>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <1367931069-7177-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] alfred: Add CFLAGS to the linker step
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 02:51:01PM +0200, Sven Eckelmann wrote:
> The GCC manual states for different parameters that the options for compi=
lation
> must also be used when linking. The options for compilation are stored in
> CFLAGS and added to LINK.o to fix the behavior.
>=20
> Option which need this are for example -fPIC/-fPIE or -flto.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile     | 2 +-
>  vis/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision c693d67.

Thanks,
	Simon

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGSBtYACgkQrzg/fFk7axbe/QCgjNj6SPV+hmocudYcnEHRJ14z
qhsAoNtfd7ElKudF/TmnkW6ArC9fjDa6
=gBOA
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
