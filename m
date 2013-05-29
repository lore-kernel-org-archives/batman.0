Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 29 May 2013 16:17:58 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130529141758.GC23657@pandem0nium>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <1369779649-2537-5-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 04/10] batman-adv: add bat_get_metric API
 function
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


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 12:20:43AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Each routing algorithm may store its metric value in a
> different place, therefore a new API function is needed in
> order to ask the algorithm to return the metric of a given
> originator

This looks like a duplicate of the ogm_metric_get() patch in the same series
with the same number ...=20

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGmDhYACgkQrzg/fFk7axacUQCghFYUeICiltZQfSyDa/JBlNdA
HNQAniM4e7PSM3jPYLKr4y0G+CG+x36V
=S4WE
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
