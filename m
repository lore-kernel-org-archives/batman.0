Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 31 May 2017 16:40:56 +0200
Message-ID: <8268015.CIqWAenRvX@prime>
In-Reply-To: <20170531142013.GD29826@otheros>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
 <13855542.45yYzsjnKj@prime> <20170531142013.GD29826@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1832872.zB6yUiAvcD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] MAC addresses of loop detect frames in global
 translation-table
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

--nextPart1832872.zB6yUiAvcD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, May 31, 2017 4:20:13 PM CEST Linus L=FCssing wrote:
> On Wed, May 31, 2017 at 03:39:23PM +0200, Simon Wunderlich wrote:
> > Hi Andreas,
> >=20
> > yes, those are loop detection packets. Preventing these entries from the
> > local translation table has been implemented only recently. We can
> > potentially do the same for global addresses as well, it just hasn't be=
en
> > done so far ... at least I don't see a reason prevening us from that. It
> > is probably added by "speedy join" in the first place.
>=20
> This was the case at least for me. Andreas, do yours have the
> temporary flag set, too?
>=20
> I'm wondering why these packets end up in the mesh in the first
> place. (Preventing things as late as in tt_gobal_add() / on
> mesh receiving nodes seems like a workaround?)

Hey Linus,

we actually want those frames to pass through the mesh - otherwise we can't=
=20
find out if "regular" packets would loop through the mesh, so we have handl=
e=20
those special packets like regular ones.

If we don't want to see them, we have to hide them, but we can't remove the=
=20
packet without hurting the functionality. :)

Cheers,
    Simon

--nextPart1832872.zB6yUiAvcD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlku1fgACgkQoSvjmEKS
nqF7YQ/5AReNKWo4fixUkyK0PijeqY7zG6oKQtlwYq6ohUF29oNr92LNX3qtUuTo
LHVZqtqEIBqTX/TiczM1uq5ZVuqlTmsj8zd5otl5afnY532DLHUyRTnXxSE0vEfo
c4kTDHJ3GYW9GbEcWgGientS5yA0gC1egBKo8JpnlBGhOLaxij42sequZW5PF++u
pNqMUGntrNyeFYgdREpbjHUKfjh5XzguZukCIa+riaROMqKeLkt+rGwFR2yO6FsP
pc+Ae3VUZlQ7pbILTQI3NpfZWfke59+l+uxIb+/iKH//djes0NYHPNSXZvq4hy+D
zl4R0wT3yd/9uok1RMngQwKhnVSUIx9MsfUfbmln1lCmj/KlG6oPB3lCsLKYAxZV
XmJS07lGNL6qU4tqOW5OvHJWbb4RxY+WVw7kdJHtXGOvVn0tXIX/z/DIkzLfSyLo
qxJjL6Ju9RnGDlJ1wZsJ6IiRgbQeIFB8/pwh9e6RWREkItUtgZpQ3xwy5OHUdoW3
FUe1JftfkzN6+zPI91R7aElMCqNNhNr082Iy5/S4m1kbGznfipeMYy4SabVudud/
frt38vGsy65TZiZWllhgkkfnbpSzyUzMw61PGtkcNLDNPxpNYMBH+qMK7BTHraYu
6miaqwvqZ3wQR5/dwyxoJG45j4YPB4GVhC0951BULh9ZuyH0HBk=
=prP6
-----END PGP SIGNATURE-----

--nextPart1832872.zB6yUiAvcD--

