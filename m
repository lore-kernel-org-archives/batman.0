Return-Path: <ordex@autistici.org>
Date: Sat, 12 May 2012 14:07:25 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120512120721.GC14279@ritirata.org>
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
	<20120512115652.GB14279@ritirata.org>
	<1379829.aiuEal9R8A@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <1379829.aiuEal9R8A@sven-desktop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Move hash_ipv4 to
 distributed-arp-table.c
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 12, 2012 at 02:01:41PM +0200, Sven Eckelmann wrote:
> On Saturday 12 May 2012 13:56:55 Antonio Quartulli wrote:
> > On Sat, May 12, 2012 at 01:48:52 +0200, Sven Eckelmann wrote:
> > > hash_ipv4 is only used in distributed-arp-table.c and therefore can be
> > > placed inside this file instead of the header.
> > >=20
> > > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > > ---
> > >=20
> > >  distributed-arp-table.c |   24 +++++++++++++++++++++++-
> > >  distributed-arp-table.h |   22 ----------------------
> > >  2 files changed, 23 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> > > index e678ec4..4894a85 100644
> > > --- a/distributed-arp-table.c
> > > +++ b/distributed-arp-table.c
> > > @@ -32,6 +32,28 @@
> > >=20
> > >  #include "translation-table.h"
> > >  #include "unicast.h"
> > >=20
> > > +/* hash function to choose an entry in a hash table of given size.
> > > + * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
> > > + */
> > > +static uint32_t batadv_hash_ipv4(const void *data, uint32_t size)
> >=20
> > since the function is static, why do we want to use the batadv prefix? =
would
> > this create confusion?
>=20
> Consistent naming scheme.
>=20
> Just imagine that somebody needs some function like that in another file =
and=20
> don't want to move it to the header. That would mean that he removes the=
=20
> static and add a declaration in the header file.... and now we have the=
=20
> problem of the missing batadv_ prefix. Either he changes the name everywh=
ere=20
> or creates those potential namespace problems.
>=20

Oh ok. Then we will use it everywhere.

Thanks Sven.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPrlJ5AAoJEFMQTLzJFOZFMogIAKF1Q2uwPM0L4lOi3dsPyeCb
147mvuP8n/N2YjJmarsIzr1fED1r+yH411tz5IDFnR2yReNNCI+BkpS0GtQmXGN6
5CUoMYtwtRQnA/MK44rU7+5w6Xt+asd0bJL4AlDfg/4K03nj94acHOu3wfQ0n6g2
6YB99JGGujmwxwcXCazF61x3WCWVQrtt+92Z7R29WNDr3w5u9yx6VXuD6CBUruAS
pEPgUDI5IdqcMhMmkLLPXEZVe36nVXJr30qOKAIe4CDOxxEZ+OApsKAuUK3a6dVT
iojG9f5uMz3bkels56txHfykXrIVFJnXD61y9ZbBAvEc3kMrLgTLtykA7yn43N4=
=NDxH
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
