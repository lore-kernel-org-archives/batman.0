Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 14:38:58 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130124133858.GB2507@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <51005884.7090106@universe-factory.net>
 <20130123215352.GD10344@ritirata.org>
 <201301242136.11695.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <201301242136.11695.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
 entries
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2013 at 09:36:11PM +0800, Marek Lindner wrote:
> On Thursday, January 24, 2013 05:53:52 Antonio Quartulli wrote:
> > > It might make sense though to check for different types of addresses
> > > that are invalid for ARP (zeronet, loopback, multicast, etc.), but I
> > > wanted to keep the patch as simple as possible. If you think these
> > > should be filtered as well, I'll prepare a v2.
> >=20
> > in distributed-arp-table.c:784 you can already find these checks ;)
>=20
> If most of the checking is done in batadv_arp_get_type() why not moving t=
hese=20
> checks there too ? That would allow to have all checks in the same place ?

I thought the same, but in batadv_arp_get_type() we have a general check th=
at
discards wrong/bogus ARP request.

Here instead we are filtering "correct" ARP requests that DAT should not ha=
ndle.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRATlyAAoJEADl0hg6qKeOb60QAL1gjDamIMLRjogqhoGgQ7Q3
JoNy5TT03GR1dW8GZsMzMLnW9EVotwArCybbDGwWClLlcKqEzHr+Nj00ruVlji1W
Lkth27tmgsKHfDi326uUCeTJoxtgGSv5PMFoL7wfXSqEwrzLPH1w55GaAcEQ8aWr
EbttvMQzA0N2sHzcPeHuZZSzXYXWooa/uNMTFonx3BoQlNiH7TicirD83VoFfNAi
Aq87tmDEOBRfle0MRhTJ93yBTGzvrJ/Iec3uJlmdalC6o0lMFPfxly8YqVP7nFYQ
1XjhFfmr0q3ZK0yiAf9rTY4DjG49hkU5gL6F8JoqXUyjICpgBDXLhfQ/c1asFcV5
fXqlcvZ5XSHU3GKGjmqQxHTgnb+k9StPyj8DMjJVfDbaRCmsYZFAjBSidCu3g8i7
Pqv4+wmu14Egs6JGWRq1tcdUp5/n/xXvneZoHjf4i2Ncb1NZds7Iw277Pr5QulAp
lpys0LMZMk19TVz4JgXsAwydH4Bh8qPkWfn1AB7xLc6VrU8A5QVaRXmlMXaTPnez
c3IgZVPVEndh+ih+LLB5OXlOm1JKi5sbCunXptipFhlt0ThRbpH9PEhUfBwd7HZT
5gA8BdHYkjHrHbXAN/uTx+psCtrPAZroP0KJa+Wq/8Xm+uAPr7Ck9mGrPIDrYVTI
/7dGAX+uR6u7QKkHBoa5
=JEIC
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
