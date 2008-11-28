Date: Fri, 28 Nov 2008 21:07:00 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
Message-ID: <20081128200700.GA25072@pandem0nium>
References: <492DDC20.7090900@web.de>
	<200811280043.26990.lindner_marek@yahoo.de>
	<49302F8E.2040502@web.de> <49303E38.1050001@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <49303E38.1050001@web.de>
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


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Chris,

just a short note: rev 1160 - 1162 should [tm] only be cosmetic changes.
We added some defines to avoid confusion in the routing code. Therefore
rev 1159 and rev 1162 should behave equally (assuming that no new bugs were
introduced ... ;] ).

best regards,
	Simon

On Fri, Nov 28, 2008 at 08:53:44PM +0200, Chris W. wrote:
> Hello Marek,
>=20
> with rv 1162 routing seems to be much better,
> all nodes and subnets are reachable.
>=20
> After some minutes I saw this error on 10.4.2.50:
> Jan  1 05:55:40 wgt634u_50 daemon.err batmand[7357]: Error - can't add=20
> throw route to 10.2.50.0/24 via 0.0.0.0 (table 68): File exists
>=20
> greetings,
> Chris
>=20
>=20
> >>>-3- previously announced networks are not deleted (8.106), the routing
> >>>table collects multiple entries for the same destination
> >>
> >>Thanks for the hint. Fixed in revision 1159.
> >>
> >Yes, no multiple entries anymore in 1161.
> >
> >The announced network of 2.72 gets lost after some minutes on all nodes.
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJME9krzg/fFk7axYRAiJmAKDdQkSTaoo0pqRRbSeYbLn08LwG6wCfY3F7
Fg6Iu00X0vYnMcTb0fQ8U2I=
=09O/
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
