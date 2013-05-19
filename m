Return-Path: <ordex@autistici.org>
Date: Sun, 19 May 2013 12:27:14 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130519102714.GM3350@ritirata.org>
References: <1368778903-2289-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SgT04PEqo/+yUDw3"
Content-Disposition: inline
In-Reply-To: <1368778903-2289-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use __constant_htons when
 possible
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


--SgT04PEqo/+yUDw3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2013 at 10:21:43AM +0200, Antonio Quartulli wrote:
> When comparing a network ordered value with a constant, it
> is better to convert the constant at compile time by means
> of __constant_htons() instead of converting the value at
> runtime using ntohs().
>=20
> This refactoring may slightly improve the code performance.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

After discussing with Simon, we realised that using __constant_htons is use=
less
since htons is smart enough to be as efficient as his brother __constant*.

Therefore this patch will be re-arranged to use htons only.
It will still remove some ntohs and make use of htons at their place.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--SgT04PEqo/+yUDw3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRmKkCAAoJEADl0hg6qKeOWNYP/1AXcB8qaHig9aSfdcM9q1sQ
Dlv0gq7eLeAsV2OAORSWTcJ5Fzdv8aV/KeOqnrQtNXEYQz7evPTuBTLE1Tvz1HkU
zXNGP9Rjn9c+8M+xkEDxvvyQ7t6NroDI+gVkJG6zsywrWPeZ0VsnA8Ll+N/yDhjH
XS8OdQjkRsWYxKHLEXJtco9B1OHI9Qe4UUw/JWWZUUusEIDaWjO1d7fwRwwMEXIX
BbP2+ucqIqULJ2l9Q0pJ2SGf546ZMgXGQ/dlvIj9tpHtNbUfqXcK7viuxY4h1JDk
lDi1Oo6H8VkpXQOiHq2drw4T6u6qhBFknXfTowjPV8w/NikOrMGlPV3WT9IujtKc
nuuF+0/01HGvwdEKe86qP26PtaB2G6LtW0T0edpB+5HXyfnGYhWAn0hBKEzk3Hea
ba2PfpEQHEICwdL8/Jf318jGYlpKQasvGDHsOrAl5sGD3UXa9BfG/u2UzKR3J6lS
YNQXK0wzURwBFRtqXLLNXFe4mazB7E6MjpOGaX5yFONCl3ALCNhFo0Zmn/+z+k55
/OfS0T1fFzhmbEESsL25t7QqriRnPH3RoG24vGxZpUbaF0bNdCvnzUB56/BApjY5
SHXN7s6vRaSEVx9nz3l7Zk4JrY99543xQDMSZKh1CdTMPLV4XkNzSNNBWC7gmrSD
tCYSwyQycGP4/pKqgTNl
=viQB
-----END PGP SIGNATURE-----

--SgT04PEqo/+yUDw3--
