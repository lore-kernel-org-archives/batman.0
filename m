Date: Mon, 21 Apr 2008 14:30:02 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Message-ID: <20080421203002.GA4490@apoderado.ometepe.net>
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<560c7c9a0804210557v2c94a553w5a2c8dd2efb8eead@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <560c7c9a0804210557v2c94a553w5a2c8dd2efb8eead@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2008 at 02:57:44PM +0200, Benjamin Henrion wrote:
> On Mon, Apr 21, 2008 at 2:39 PM, Jan Hetges <tran@ms20.net> wrote:
> >  i'm running bmxd_rv972 for almost three months now, without
> >  any mayor problems :-)... thanks.
> >  what i recognized lately, on two nodes (the ones with more than
> >  one bmx interface), show alternativeNextHops, which are *NO*
> >  alternative. It seems there gets some 'information' lost between
> >  the two IFs. I suppose that's a known issue ;-), any ideas how to
> >  fix/workaround ? iirc, i saw once or twice a node "on the other
> >  interface" even listed as the bestNextHop.
> >
> Can you describe a little more extensively your network configuration?

sorry ;-):

  x.x.0.0/24---x.x.0.1/x.x.3.1---x.x.3.0/24---x.x.3.160/x.x.4.1---x.x.4.0/24
		     |
		  internet  =20

batman network x.x.0.0/20.
=2E0.1/.3.1 is one node with two radios, and .3.160/.4.1 the other one.
and, .3.160/.4.1 lists .4.162 as alternativeNextHop to .3.128.
where .3.1 and .3.137 can see .3.128, but .4.162 can not. So, there is a re=
al
alternativeNextHop to .3.128 ... .3.137, which is listed after .4.162
on .3.160/.4.1. I attach the output of bmxd -cbd8.
But after i really think through it, it shouldn't really matter,
because, if the connection between .3.160 and .3.1 gets interrupted,
=2E4.162 should probably fall back behind .3.137 in .3.160's statistic.

  --Jan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDPlKlTtvZdk47D4RAn4lAJwM8OZ+BiX0iORgBF5Ligt7UynEEQCeIhWw
SclmyLcOs7+SLj5NYnrtsqI=
=iY7X
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
