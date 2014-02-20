Return-Path: <antonio@meshcoding.com>
Message-ID: <5305C4C5.8090504@meshcoding.com>
Date: Thu, 20 Feb 2014 10:03:01 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <530521C0.8060705@meshcoding.com>
 <2BC074F4-9F03-4D7D-A0CD-AF66ABB7DAB9@gmx.de>
 <5305308C.5090605@meshcoding.com> <20140220085433.GD11878@lunn.ch>
In-Reply-To: <20140220085433.GD11878@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JR7GK8CWoBRrqKVFSuK3ABsP2t4Hq4gm3"
Subject: Re: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JR7GK8CWoBRrqKVFSuK3ABsP2t4Hq4gm3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/02/14 09:54, Andrew Lunn wrote:
> The routing protocol is known to have problems when a node suddenly
> disappears. A received OGM is what triggers updates to the metric. If
> you stop receiving OGMs the metric is no longer updated until the node
> is purged as dead. This for example causes problems with
> nomadic/mobile nodes. They can go around a corner, loss line of sight,
> but still be considered the best route until purged as dead.

But if you keep receiving OGMs via another neighbour you will have a
route switch *before* the old nexthop is considered as dead.


--=20
Antonio Quartulli


--JR7GK8CWoBRrqKVFSuK3ABsP2t4Hq4gm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTBcTKAAoJEEKTMo6mOh1VSOwP/1OwwPfHoNSQJ25u9sf2zef1
I2vNGoYYo/ZLGrhzpSu526Ls420Ej9qzv0eEAzJXb+ZPNKGwnCS2FOtNGKbba5NG
BQHo9/RY/lywBj9ysFPis72DhG/ugFY2QfWHR6si7LI0FHH+f0AkMc44rqKgElXq
Th0ICG6cZ9MczjI/qKXCapJZZd0ovm7WSfNzv3Zkaq3jQcoVGtMX0M/pl2vuQgAs
/wS/a1aCEXFBVVJ0GquYLZNjmKOvyMG9ypol+1OaF2REiZsaFptwvqPw0RE+aHss
m/axBMzp78WUAsJhzp6ARcpkTADQPjeEwdHvmSPxJ6R9nYy4UT/8xJyZDOMbPLcx
qLt6oz/b8sX41jtRDFJzlAFIZMO+4oyVA7yuEG/6wo++HaaHDY2TEvJ878D7yPDC
xqKkQoBtWoaCgz6RiLY6YcRQPUWngIDnoiyqgroolIP5kVri6QHPoP6M7+jqJxar
1BrKTvvidlIXQ0898xWkgptIJzJm+MpjU+QcRf3MwplImdTWT/qn/oNg+TpzRYuU
53uwJf6duo4cQPUZabrz0SDK+x5sUz/ghGxuvLUiXHTRzR9G7rOBn/GveP6otkFI
eVm1LFna4zlCSu8bNq7pBaLUe86U0bLS0z3v71HIjN2lTsAZeN0YB6AHuSL/Uygo
jOpHR9sxYyxQMlKi9sVw
=MR2c
-----END PGP SIGNATURE-----

--JR7GK8CWoBRrqKVFSuK3ABsP2t4Hq4gm3--
