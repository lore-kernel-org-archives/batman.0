Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 01 Jun 2017 10:07:39 +0200
Message-ID: <2097745.f56AfyDzbC@prime>
In-Reply-To: <20170531155631.GG29826@otheros>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
 <8268015.CIqWAenRvX@prime> <20170531155631.GG29826@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1549448.NsRbUOjWj7";
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

--nextPart1549448.NsRbUOjWj7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, May 31, 2017 5:56:31 PM CEST Linus L=FCssing wrote:
> On Wed, May 31, 2017 at 04:40:56PM +0200, Simon Wunderlich wrote:
> Although, sending these mesh wide sounds like it could create quite
> some overhead? Is this new to BLA2?

Yes, it's new in BLA2. Actually it wasn't in the first BLA2 as well, we mer=
ged=20
the patch not so long ago.

The loop detection packet is sent every 60 seconds as a broadcast to the LA=
N.=20
It will therefore only end up in the mesh if there are other mesh nodes on =
the=20
same backbone LAN to forward it. Therefore, I think the overhead for commun=
ity=20
networks at least should be minimal.

Cheers,
      Simon
--nextPart1549448.NsRbUOjWj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkvy0sACgkQoSvjmEKS
nqG9ZxAAwFJ1MoNb8BXXwuewCZG7gWShz/IW+5NPAwIjuu3bCq/OuPciisSSNTLP
rqBDTfOecTnbJ149tP+l9CI0iOOqhY2dNGKp1iLbFpc2+QlGuRalvskQiMfyrKBQ
J/JD0nDIyP5lne5bVGX0ulOuSkqm08yzd/0W9MS9SiNHqSXgOp5GjTcceEOZkgGt
0O6fC+jZ+LaWIeNCqcmK3f93ayuF+8mSzEVajjd3qfzbeX7GdfwgX4QdfkuqpjR2
MqlrTu3j9BRP7bM7bNEkrM9VuOanpbe/0aAdtRxW9dxi4P4ZxpN5G1ZYfi63Mcsh
BURbAgBeGMXb9vIqzjDXTfK5YHM2K3Y3XR1307qKHQWJZfonOOBqYqsO7H6R+opi
EWUl/m6SiGmk1uF2kaPSnQ8Lfeh93TiozBSKQ59Ty9ZiffjwvrfzFkI/WoeSwyBi
TXDigeaJVH8Oi0vemp8A/KXO01j2jJYPDfYLNQrIJavja2KX2R+9a4xmucXGaEwh
43D42BTZMI1gs5FUgy2SUM6tBKqu3+oTvK17K6FNYOUMVKKCBz094Ctq1b4enRNM
w50r8LdPj7gwLofZm8OxucOYBjq4kGExqbHH5EOTM49s278KhqTEd+1yDxVTPjcf
ABTV000waS+PzO4RoirQ0iACdGJavyVqjlKprZmqaWEGSAA+46M=
=anNI
-----END PGP SIGNATURE-----

--nextPart1549448.NsRbUOjWj7--

