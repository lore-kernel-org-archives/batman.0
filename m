Date: Sun, 23 Nov 2008 13:16:27 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing (via gate0)
Message-ID: <20081123121627.GA15419@pandem0nium>
References: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
	<200811230035.05534.lindner_marek@yahoo.de>
	<35921.149.5.32.200.1227387936.squirrel@www.rivertowermail.com>
	<200811231137.11082.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <200811231137.11082.lindner_marek@yahoo.de>
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sun, Nov 23, 2008 at 11:37:10AM +0800, Marek Lindner wrote:
> On Sunday 23 November 2008 05:05:36 Derek C wrote:
> > Does this mean that the mesh nodes cannot ping all the other nodes?   T=
his
> > is if there is no routing to allow the nodes talk to "far-away" nodes n=
ot
> > within their own AdHoc single-hop network?
>=20
> May be I was not clear enough:
> * You can ping every batman node in range.
> * Too far away nodes (out of range) obviously can't be pinged.=20
> * If you have multiple subnetworks which could ping each other but are ro=
uted=20
> differently you just have to make sure the routing is ok. Using HNA is on=
e=20
> possible solution.

just a note so we don't confuse the terms:

Marek means with "range" where the communication can practically succeed, e=
ven=20
over multiple hops. As you have some probablity to lose packets on each
hop, the communication becomes "practically" unusable over very long
distances, e.g. >10 hops (depending on your network setup and
environment ...).
Note that this range is not the single-hop range.

regards,
	Simon

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJKUmbrzg/fFk7axYRArI6AKDxQg49m0Y6Ukhb1+5fHhiJMymhdACfR787
5uDIxaBV70sLhr/iHIUk9lg=
=FigJ
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
