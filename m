Return-Path: <antonio@meshcoding.com>
Date: Fri, 13 Sep 2013 13:49:55 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130913114955.GA896@neomailbox.net>
References: <20130912093641.GX1558@medion.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20130912093641.GX1558@medion.lan>
Subject: Re: [B.A.T.M.A.N.] fool batman by simulating a layer3 mesh
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
To: b.a.t.m.a.n@lists.open-mesh.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2013 at 11:36:41AM +0200, Bastian Bittorf wrote:
> discussed in IRC, i'am searched for a better way to
> load-balance a batman network. not the whole shaping/splashing
> should run on one (central) node, so we needed something to stick it
> to the node/AP which the user is connected to. than we have also
> the ability to show a good page when the network is b0rken.
>=20

I'd like to remember that you could also do the same by using iptables and =
the
netfilter hook in the bridge code (look for netfilter_bridge). It would all=
ow
you to apply shaping/firewalling rules directly onto a bridge, without
transforming each and every AP in a Layer 3 Gateway.

I think this would also fit a Layer2 mesh network better.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSMvvjAAoJEADl0hg6qKeOH8IP/3PBR4uXJjAg0b6UN6BjmQDq
T8hDdMh1X+LJOet87BLBqf4FmKxBdDwOg+B/2Zxy7tLSoGsGzMuO+kW7n3Ax+xI/
WkeJYlECMxKDuu7YEFRn4MG8K0XBeeZlbGjQQg3PYoCmLUk2r018jE4gpyc4iNy0
ni7f8hb9ctXwj715iaOySgu8sQmo2MMCkRrF2A7W1/TW27orATbE/9Qr84Zwexk5
7fTMTXa2oupek2Xne3epTsaWM7vQqn/oMPkrmeP1+AeGZ2rfmOE5mfzSOCJ2xEff
MRbJ/uM1wXW8drfgEEJKOop2g7XdeRB9kUywp20wRttE6oaVqgcQRYz/s/i4ZaEI
Q+xbzS/Q8hrcIn/2Ugn6Ew2b5F2+JiPJjFD+ZZ73DKvG7xWBoTfTBypZbNI/PzRz
AYaoJMY64PUpaOUQeh+WXX6bZBQUEYIxG9r7RZ6eO586t5XHmZm9tLSqH9usP0Ze
/zlutc+7hlFaH6WmxO8BnqzOOAkGiDhZ5bHxLezj3OL79cKMW7fAlWbXXKlrHj9x
xHTe/wYR09E79jyJdREAsc74jXO6dbkONDsFgppa4tIl+iQwrCBqB9lHzrLXAnyy
ypuoEdyiwcb860yItClLVie+Jl/P4m/3Iehvg2XsqDVk2NJzSyg3A4YRkQoYekgJ
lW6WTPlQaryP9oD0rtFU
=Y3id
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
