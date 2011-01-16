Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 16 Jan 2011 18:07:32 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110116170732.GA23342@pandem0nium>
References: <201012130118.14949.lindner_marek@yahoo.de>
	<20101230020917.GA4707@pandem0nium>
	<201101161235.54223.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <201101161235.54223.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: protect bonding with
	rcu	locks
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
To: b.a.t.m.a.n@lists.open-mesh.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

thanks for the review!

On Sun, Jan 16, 2011 at 12:35:53PM +0100, Marek Lindner wrote:
> On Thursday 30 December 2010 03:09:17 Simon Wunderlich wrote:
> [...]
> The changes include:
>=20
> * The bonding / alternating candidate list is not destroyed & re-created =
with=20
> each incoming OGM but candidates are added & deleted in a dynamic fashion.

This is a good idea. As discussed in private, this would add some latency i=
n=20
the update process, but this should not harm the bonding.

> * The memory leaks have been fixed / a workaround has been found. The "fr=
ee=20
> neighbors when an interface is deactivated" patch is also required to get=
 the=20
> full benefit of these memory leak fixes.=20

Good job!

> * I introduced some style changes which are meant to increase readability=
 &=20
> maintainability. Feedback is welcome.  ;-)

Fine with me. :)

> While reorganizing the code I stumbled over these lines which are part of=
 the=20
> interference check:
>=20
> /* we only care if the other candidate is even considered as candidate. */
> if (!list_empty(&tmp_neigh_node2->bonding_list))
>          continue;
>=20
> This seems wrong in this context. If the list is empty then this neighbor=
 is=20
> not part of the candidate list. Wouldn't you agree ?

Agreed, this is wrong. Your patch fixes that, i see.

I've also checked your patch in my VM with 3 hosts and did some ping tests.=
=20
No regressions found, the bonding and alternating worked fine. I did not lo=
ok
into memleaks thou, but feel free to add my signoff and/or merge the patche=
s.

Thanks,
	Simon
=20

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0zJdQACgkQrzg/fFk7axaiWgCgzJQSp8CegF6U0yBtpFSDhAHl
Y2MAn1qe0dHcTVnp7GQBp/iEtSXYxEnC
=xCxs
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
