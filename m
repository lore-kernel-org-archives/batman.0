Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 8 Sep 2013 23:53:44 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130908215344.GA7824@pandem0nium>
References: <1378585186-7970-1-git-send-email-nils@nilsschneider.net>
 <20130907203207.GN1570@ritirata.org>
 <87hadw1hbs.wl%nils@nilsschneider.net>
 <201309081039.23458.lindner_marek@yahoo.de>
 <87ppsj66pn.wl%nils@nilsschneider.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <87ppsj66pn.wl%nils@nilsschneider.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: output valid JSON
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


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nils,

thanks for your patch!

On Sun, Sep 08, 2013 at 10:47:00AM +0200, Nils Schneider wrote:
> The current output format of alfred -r looks like this:
>=20
> { "fe:f1:00:00:01:01", "OpenWRT-node-1\x0a" },
> { "fe:f1:00:00:02:01", "OpenWRT-node-2\x0a" },
> { "fe:f1:00:00:03:01", "OpenWRT-node-3\x0a" },
>=20
> It's not clear how one should parse this as there is no documentation
> except the source code.

The output was first designed for debugging and scripts who should parse
that (binary programs like vis may access the unix sockets directly).

>=20
> With my patch, it'll look like this:
>=20
> {
>   "fe:f1:00:00:01:01": "OpenWRT-node-1\u000a",
>   "fe:f1:00:00:02:01": "OpenWRT-node-2\u000a",
>   "fe:f1:00:00:03:01": "OpenWRT-node-3\u000a"
> }
>=20
> This is JSO=CE=9D which is well documented and thus can be parsed
> easily. It's a dictionary with the node's ID as the key and the data
> as value.

I think your suggestion/patch is a good idea, it will result in a more
general format. I'd like to ask you to send your patch again with a
revised commit message (e.g. add your examples from this mail and a
short explanation why the old format was bad, and why JSON is better).

I'd then would like to wait for approx. 1 week to gather comments from
people who already parse the old format already (Guido?), and if there are
no objections merge it.

Thanks!
	Simon
>=20
> At Sun, 8 Sep 2013 10:39:23 +0800,
> Marek Lindner wrote:
> >=20
> > On Sunday, September 08, 2013 04:56:39 Nils Schneider wrote:
> > > The current output format isn't really broken, just tricky to parse.
> > > I decided to make it valid JSO=CE=9D as it was already pretty close. =
This
> > > allows parsing with virtually any programming language.
> >=20
> > Please be more specific about what was broken and how your fix addresse=
s the=20
> > problem. An example would be nice too.
> >=20
> > Cheers,
> > Marek

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIs8egACgkQrzg/fFk7axYSUgCfTK0OzCsWmgMW3g5AN7u6KY7L
iJ4AoIWyFtAGRE2CWKL7u3FdcRZPDk4Q
=zjMp
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
