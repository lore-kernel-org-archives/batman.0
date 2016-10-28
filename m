Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 28 Oct 2016 10:53:31 +0200
Message-ID: <4386033.CArizPFJEb@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3478142.1Te1q4jNep";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2016.4
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

--nextPart3478142.1Te1q4jNep
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Oct 27th, 2016. Today the B.A.T.M.A.N. team publishes the October 2016 upda=
te=20
to batman-adv, batctl and alfred! This release netlink support was enhanced=
=20
and now can replace most of the data currently available via debugfs. batma=
n-
adv can therefore be used in multiple network namespaces without collision =
in=20
debugfs. The size of the translation table was optimized and the gateway=20
selection algorithm for B.A.T.M.A.N. V was integrated. Also several bugfixe=
s,=20
code cleanups and code documentation updates are included in this version.

As the kernel module always depends on the Linux kernel it is compiled=20
against, it does not make sense to provide binaries on our website. As usua=
l,=20
you will find the signed tarballs in our download section:

https://downloads.open-mesh.org/batman/releases/batman-adv-2016.4/

as well as prepackaged binaries in your distribution.

Thanks
=2D-----

Thanks to all people sending in patches:

 * Andreas Pape <apape@phoenixcontact.com>
 * Andrew Lunn <andrew@lunn.ch>
 * Antonio Quartulli <a@unstable.cc>
 * Jonathan Haws <jhaws@sdl.usu.edu>
 * Linus L=FCssing <linus.luessing@c0d3.blue>
 * Markus Pargmann <mpa@pengutronix.de>
 * Masahiro Yamada <yamada.masahiro@socionext.com>
 * Matthias Schiffer <mschiffer@universe-factory.net>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Stephen Hemminger <stephen@networkplumber.org>
 * Sven Eckelmann <sven@narfation.org>

batman-adv
=2D---------

 * support latest kernels (3.2 - 4.9)
 * add GW selection algorithm for B.A.T.M.A.N. V
 * add support for querying most tables/lists via netlink
 * adjusted device modifications for easier handling via rtnl (ip-link)
 * disabled (bad) debugfs support in network namespaces
 * add improved compat-patches support (note the new build directory)
 * reduced translation table memory consumption
 * coding style cleanups and refactoring
 * bugs squashed:
   - avoid locking problems when modifying interfaces
   - fix sysfs errors on fast device deletion/creation events
   - add missing memory barriers for neighbor list modifications
   - fix tpmeter debug log output

batctl
=2D-----

 * integrate support for batman-adv netlink
 * coding style cleanups
 * documentation updates
 * bugs squashed:
   - fix endless loop in TP meter on some platforms
   - fix build errors caused by name conflicts

alfred
=2D-----

 * add expert option to specify sync interval
 * fix various bugs in batadv-vis netlink integration
 * fix build build problems with libnl-tiny

Happy routing,

The B.A.T.M.A.N. team

--nextPart3478142.1Te1q4jNep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYExILAAoJEKEr45hCkp6hlzcP/RKel6USX1QIVfjlKmt6b3Kx
vdwG+xra5rnLxhoLilWyTr+ivOT73JKXTkVm3LMDNyOU0M+knWUZYp6Q5JoYdNHM
oK+JLB6MD9RU16cQwmTF8nq75bqFEwAiYCNJX5YPTukeg+YB9FgUrRqVIcVaweog
9MxBZRFaxcuzSOXgNAYwUi8EuQdqN3sYQ62wUzuom6SQUM8eBs6EWuKffdpBb3eb
OVvowgY+5i5ns7MZ28tREZnD4DYUacqZCiVr5aTdTUu9pFBTKMw3Kek+3xL8NvUK
9wgOB8aiLOj4z2veAWnOLwny5itk7TbAuDAw756PMgNLDsxAmbHkjBwMMIq2C6QC
r+Rm79CJVfElYVFKzmC1OS2CIE5UzCXH/dMtpRTCqQiskqPXnl+PWMdUkkjxJ41T
Pa2lcQ2EtUGbxQY2g9pZ8kv2j6NGGV59hBngW8mxetqsU5M/TPNaTna3yuxCIuEL
Br2o6lQ8qWHmETi8ECXpXWW/MAzPUAt2AAX1lTPK2DZv8JQdb2tCgGFc2p2pqU9B
qv74kL3Xi4JD+tsdU4ClOchSuhI+Y14RMcUkR1UEDx/v+3DDNIZLxbkE9eNftd2Y
8wixJQ08rUB5UzhR/0K+YbEdPIzabVg9wLLp3eYOOvoih4AGMlh7IFCn3YX8gs9Z
Z3mwYDYfBwIWVVwEYwU0
=fQ0v
-----END PGP SIGNATURE-----

--nextPart3478142.1Te1q4jNep--

