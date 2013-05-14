Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 14 May 2013 11:44:19 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130514094419.GB16545@pandem0nium>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <1367931069-7177-6-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/9] alfred: Use section garbage
 collection to reduce binary size
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


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 02:51:05PM +0200, Sven Eckelmann wrote:
> The linker can identify unused sections of a binary when each symbol is s=
tored
> in a separate section. This mostly removes the unused debugfs function and
> reduces the size by ~5% on mipsel.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  alfred/Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Applied in revision fa23641 (alfred package feed).

Thanks,
	Simon

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGSB3MACgkQrzg/fFk7axa9LgCePmY3Hw5Zs3E7XDxs3N9c8wxF
QKMAoKJ/4Lv84tb201uK7JsoeChMiHuO
=+zNw
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
