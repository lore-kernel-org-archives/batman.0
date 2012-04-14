Return-Path: <ordex@autistici.org>
Date: Sat, 14 Apr 2012 13:41:27 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120414114126.GB24739@ritirata.org>
References: <1334402127-5211-1-git-send-email-ordex@autistici.org>
	<20120414112915.GA24739@ritirata.org>
	<201204141334.16051.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <201204141334.16051.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/2] Fixes reported by Al Viro
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2012 at 01:34:15PM +0200, Marek Lindner wrote:
> On Saturday, April 14, 2012 13:29:15 Antonio Quartulli wrote:
> >   On Sat, Apr 14, 2012 at 01:15:25PM +0200, Antonio Quartulli wrote:
> > > The following two patches fix the two issues found by Al Viro and
> > > reported in his email.
> > >
> > >=20
> > >
> > > Patch 1) simply convert the tt_crc field in the bat_priv structure fr=
om
> > > atomic_t to uint16_t. Actually there is no reason to declare it as
> > > atomic_t.
> > >
> > >=20
> > >
> > > Patch 2) fixes a little bug we have when sending a tt_request message:
> > > now we don't convert the tt_crc that we are sending within the request
> > > to network order. OTOH we convert this field from NO to HO on the
> > > receiver side.
> > >
> > >=20
> > >
> > > Therefore, nodes on the path of the request, which have HO different =
=66rom
> > > NO, will fail to reply to the request and will forward it towards the
> > > final destination.
> >=20
> > I think David'd want to see this fix in the next pull request or
> > so...should we commit these patches to next directly?
>=20
> Probably. The second patch could even go to stable, right ?

I'd say so


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPiWJmAAoJEFMQTLzJFOZF6pQIAISWZoa/qSGpye05gAfil5bD
H3UXnLBLrjMmj7CD/HT/o27SCJsXrVVpRRi2m6HmzdWVZdNOhbvA0DlTqj241EM+
ghs0IAVztbuhlDDVSTSuOkCquJK2YD7fI4MPIKWq7lk/3ayBGZAmtvpBkqLI6PAi
7UmsxDuewjDm/JVhJ5qwVFuIQKFUXHtIpxRyuD9J1jwg2aBtN17fcTU4+AZGPkX2
kgoEsQwt/GuWhHj/36bvI1pWnQTKkWEUKqmPKBoEuQYlIrYuMnGgVamMcmhbDZ68
gDQ61TiihHiV24G8rq1ZXFUaZ9TY+6c2YDp29Bb5lXQ60fkbbxIn0P7+WGMBxD0=
=61+S
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
