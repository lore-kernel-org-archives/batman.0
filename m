Return-Path: <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 11:51:37 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131013095137.GL576@neomailbox.net>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
 <1381625420-4062-2-git-send-email-antonio@meshcoding.com>
 <1816584.FKOJ6PKUro@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline
In-Reply-To: <1816584.FKOJ6PKUro@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: don't switch byte
 order too often if not needed
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


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2013 at 05:44:27PM +0800, Marek Lindner wrote:
> On Sunday 13 October 2013 02:50:17 Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > If possible, operations like ntohs/ntohl should not be
> > performed too often. Use a variable to locally store the
> > converted value and then use it.
> >=20
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> >  routing.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> I don't quite see why this patch is part of this series.

because at the very beginning I wrongly did this change within patch 2/4 and
Simon correctly suggested me to separate it....

So since then it has been part of this series, but there is no technical re=
ason.
It is just yet another patch which is not really related to the tt-synch th=
ing.

Cheers,


--=20
Antonio Quartulli

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSWm0pAAoJEADl0hg6qKeOYi8QAJEXqZQauC2YELowkFOUregY
8S0X8UTQSsGye+nmZjgRxke3/tHQcA6BAiqSZDaTA8cil9asZjSQPHCb/AYxqN+f
+Wdhq2JLfr0uAvfVfy3rBgjGHzQpzPBvwV0efUu5HJ8PWNjyoT0ivF7WyM+uNU+l
u0Q/rvTAGO52jlGLVMvK5p+WKCZFDjNbDJa5APsdbCxRdmV/8S4qpR8B8wAUMM3h
ANai8FAn6QpZfe/K3FisSUatKQ7uol0Y0I1UjF2NepAB1UVlct/HegjzIwrynu7l
ObOU/9IiQ9J5CJW6KVU6pza7+lfLcA2UKoVl8nifJHgdkVftpmFqx+oEunC3LP4v
fGq6gevaoPZRltCH07teSmnv1ltwz3IKlKPKEAI2VQQDUCbqUlVZdLWWNC7CiPQ5
Zxl009tdbEVw2OJlI76nihnTCpjRjqtresa73/gGTQoF0iaUyHHR93hYcR3aXLJk
Qpf9LCXcoRH44Ay8CH1hQHM57/H+EeifjgktHXrRXpZpbrl40T8smRV6awaxJhzL
hQCPt5uLLEphsiDgDWqHXE+M4JNmK7Wjpb4O8vm4CrhYBuRQKADxMWDfgBLlgZuL
HLw8DW+b89e0ww11SjlrmLfPsfZL1Sv2Zc+MvA0FfRhsoZiFZuxTPGWCGvOAWYBe
/tCY0a4O7U1MY07QY0Si
=lmSe
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--
