Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 19 Aug 2013 22:12:03 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130819201203.GA18020@pandem0nium>
References: <1376594479-11563-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <1376594479-11563-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think this looks good now! Thanks :)

Reviewed/Tested-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Cheers,
	Simon

On Thu, Aug 15, 2013 at 09:21:14PM +0200, Linus L=C3=BCssing wrote:
> This is the ninth revision of the basic multicast optimization patches.
>=20
> It fixes a regression in Patch 3/5, introduced in v8 while rebasing:
> An atomic_dec() for the orig_list_count got lost.
>=20
> Cheers, Linus
>=20

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlISfBMACgkQrzg/fFk7axb7RgCfX2WyVyBW7K+s18jsSDQxa1Ew
kDwAnAtNC7U8vBZb3HRmdWrsTMMuLZo2
=V6IL
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
