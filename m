Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: b.a.t.m.a.n. specification
Date: Tue, 28 Apr 2020 17:33:44 +0200
Message-ID: <1691638.nYY6pOqhUW@prime>
In-Reply-To: <a4778f23-2eec-b3aa-b661-fe06112dccae@si6networks.com>
References: <a4778f23-2eec-b3aa-b661-fe06112dccae@si6networks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1848796.Aj0k4S2dUG"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Fernando Gont <fgont@si6networks.com>

 
--nextPart1848796.Aj0k4S2dUG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Fernando,

On Tuesday, April 28, 2020 5:07:00 PM CEST Fernando Gont wrote:
> Hello, folks,
> 
> While looking at batman, I came across your IETF Internet-Draft
> https://tools.ietf.org/id/draft-openmesh-b-a-t-m-a-n-00.txt.
> 
> Questions:
> 
> 1) Is this the closest there is to an specification of batman?

Yes, that's the closest complete specification. There are various aspects 
documented on open-mesh.org in the documentation section, although those are 
not really complete.

> 
> 2) Does it described the current protocol, or have there been changes
> since then that have not been reflected into the internet-draft?


There have been various changes. The algorithm described in the internet draft 
was called B.A.T.M.A.N. III ; there have been amendments which have been then 
implemented as algorithm version B.A.T.M.A.N. IV. Since then, batman-adv has 
been implemented as Layer 2 mesh software (BATMAN as described was a Layer 3 
routing daemon). There have been more modifications since then like multi 
interface routing, bonding, interface alternating, bridge loop avoidance etc.

See: https://www.open-mesh.org/projects/batman-adv/wiki/BATMAN_IV

> 
> 3) Any reason why the draft wasn't published as an IETF RFC?


The initial draft received various devastating reviews from some professors, 
including missing mathematical proofs and that we should change the name since 
it was considered ridiculous. We thought otherwise, but didn't want to spend 
energy making reviewers happy. Instead we focused on the software itself. I 
believe the original draft received around a thousand scientific references 
(although nobody should reference IETF drafts, but after all its the most 
complete document there is). Batman-adv is now in the Linux kernel, and the 
old Layer 3 BATMAN daemon development is pretty much abandoned for years, but 
still available for download. Almost everyone is using the layer 2 variant, 
which wouldn't fit well with IETF in the first place but would more be an IEEE 
thing.

Cheers,
       Simon
--nextPart1848796.Aj0k4S2dUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl6oTNgACgkQoSvjmEKS
nqFxQQ/7Bt2uD/4vhqSTVd1Aw/K+gd4Z5UKEmBgcP5QGJ5y0Lzwq4ahjUM3IBOml
vxvY2d/OZCAC58/QM39rlHeq4OAUnXPEYNF5Yi9URIO1zRUH+48r/46qVTcyAnbc
OEiauApED5wlCMAZVjdzdNqnqrlJCD+FlHvpkE2TLTYFkvh+BT7x8KZiEi4oFBmC
BzDD9B+g2qiW1bXt/Lt9evhk+jnT1OaTNfjYliCQyZdJm2rXZfoNsGyowiCGDw8r
wW/XKzFKrYv1tNVC0VUQrQ7yNZ6uJLRidrlC/l0r5NyHFvpsnfkzSGIYumq6UhUc
mC/3aC2GAZLEwCu2rUqge8IfjWKz21C6KRvBhE/jv79TkuV9DVxHo3mPVvTUely0
5kmQegNfdqVjIiFzmZbx2aiJpBH4sEsv9DJBwb2Xr83j4HPsXuMshjQfZtY+VQU8
g809Ib0tXOIiglpcjVQtcBfpaIQo8I+wchn4W188IAe7PfulEDdbXIAVnizYfDNf
l8ExuiDgXKZmHp1hNLyj3q5oH3Q2IHi/knNNoFZ8tAm7l6aJaT6T+HJFDNvU0M5c
K1rLm+AnhUfuhRBhtVsQBcdLsvvk+2WHKJXF+15hZcBATTESw/6ZKxpYhwfGihyv
NhbVxFwNt7YJCy2CErf8L6naNupzx7aW6gjRvujopNBZ3LB4k64=
=Av3V
-----END PGP SIGNATURE-----

--nextPart1848796.Aj0k4S2dUG--


