Return-Path: <a@unstable.cc>
Date: Mon, 1 Feb 2016 10:57:55 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160201025755.GO22112@prodigo.lan>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
 <1988230.TvXLEl4ULW@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Content-Disposition: inline
In-Reply-To: <1988230.TvXLEl4ULW@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
 in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 11:13:53AM +0100, Sven Eckelmann wrote:
> On Wednesday 20 January 2016 18:48:29 Andrew Lunn wrote:
> > nameplace, so also retrieve the parents name space when finding the
>=20
> s/nameplace/namespace/ ?
>=20
> > Additionally, veth devices come in pairs and they are each others
> > parents. Don't infinitely recurse in this situation.
>=20
> Can we have this part as extra patch so Antonio can ask David for a stabl=
e=20
> backport?

Andrew,

do you have any plan about resending this fix ?
Sven also sent a pair of fixes and it would be nice I could send everything=
 in
on pull request.

Cheers,


--=20
Antonio Quartulli

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWrsmzAAoJENpFlCjNi1MRQJIQAJIfvRPp4IkneKzVONBphepY
BrGwg3CUmmRdgt3GHnKWacWXEqQ6ZrworLCEmcFZkJBEJXa8nAu4ZZeme6hXxI2u
YUcZSgAv/cAUFiaBmkOasb+J7/M8DaT6N+Ao1oMzXOiQZ3MGnRnLbRksRWa3rbm+
VAdvr1FNYA+NPGkVzTbmWnJ8HLqy02uKco/yAJ3xnvrSMPAleX2WDX3Dy2FjOWkc
TMV/BKS8BD3ZfB/82Yb0lNioYo2iQtaq+uawokvUXUxCXrBre+YrRhEiWKSdASru
P7rhyH36/0dON7V0JlGmUUZ9CbKm/eM8ViUgIONR61I4AM8fMVzP038yn62pylTT
bbFbaICte6PXGrK8vBgg51KYOz32WPWXDpBKkgsPCwYrYNncOFSt+sxvrgPQfX/i
rQSQj8YBBjg2012VVuE3JOKdAnrt7ClxiZfEwR9O0ozDmrui3MZynSctbeZnJMvR
oqEOFIWFKwQK927AnfYgbkzKi5ahLEd0kqmIEYTitm52c9iokyPWlAfv9/xcqsCF
UO6KIWtUXnkwStKWoFo58ddVC1JL6dFKk7+I54VFjTvyFNjxNXcjBDyUdfU9YhlY
x4LLPTCzhZ4LIpMSE+tWSyYjW0eb3GYdZWpghNRG3cN58y5aD14NaoNOdaYFAI23
7cfbwzVy2p19okCx7ouu
=cQ/d
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--
