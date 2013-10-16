Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 16 Oct 2013 14:18:49 +0800
Message-ID: <5553213.hTQb2bQGTZ@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1629166.2KmNVlS254";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2013.4.0 released
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


--nextPart1629166.2KmNVlS254
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


On October 16th, B.A.T.M.A.N. has released batman-adv 2013.4.0, the new=
est in=20
a series of stability and bugfix releases. The recently introduced data=
=20
distribution daemon 'alfred' received quite some attention and gained n=
ew=20
features. As the kernel module always depends on the Linux kernel it wa=
s=20
compiled against, it does not make sense to provide binaries on our web=
site.=20
As usual, you will find the signed tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2013.4.0/

as well as prepackaged binaries in your distribution.


Thanks
------

Thanks to all people sending in patches:

 * Andrew Lunn <andrew@lunn.ch>
 * Antonio Quartulli <ordex@autistici.org>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marco Dalla Torre <marco.dallato@gmail.com>
 * Marek Lindner <mareklindner@neomailbox.ch>
 * Matthias Schiffer <mschiffer@universe-factory.net>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Sven Eckelmann <sven@open-mesh.com>
 * Wedson Almeida Filho <wedsonaf@gmail.com>


batman-adv
----------

With this release comes a fix for a kernel crash running on hardware wi=
th=20
specific Ethernet chips triggering a rare code path when forwarding tra=
ffic. A fix=20
for the network coding initialization was submitted to allow to create=20=

multiple batX interfaces when this feature has been included in the mod=
ule.=20
The bridge loop avoidance now correctly handles VLAN tags (a regression=
=20
introduced with the previous release). Additional Linux kernel backward=
=20
compatibility code enables batman-adv to run on various kernel versions=
.


batctl
------

The incorrectly reported TCP payload length in the tcpdump component wa=
s fixed.=20
The hyphens in the manpage were properly escaped to be groff compliant.=
 C types=20
and error handling were improved to better handle some error cases.


alfred
------

In order to allow a mesh topology visualization with true geographic la=
yout=20
alfred was enriched with a location service based on libgpsd. In additi=
on to=20
retrieving the location via GPS on mobile nodes alfred can be configure=
d with a=20
static location on stationary nodes to be announced in the network.=20
A new JSON output format for the vis service was added. The newly added=
 format=20
is JSON compliant throughout an entire message, in contrast to the "leg=
acy"=20
per-line JSON output. Alfred also learned to be tolerant to=20
vanishing/reappearing interfaces and to switch its operation mode=20
(slave/master) without the need for a restart or losing cached informat=
ion. To=20
avoid conflicts in distributions with other "vis" binaries (like the ba=
tmand=20
vis), the binary was renamed to "batadv-vis". Manpages have been added =
to help=20
documenting the growing functionality. Also various code/build system c=
leanups=20
and bugfixes have been integrated.

Happy routing,
The B.A.T.M.A.N. team

--nextPart1629166.2KmNVlS254
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSXi/NAAoJEFNVTo/uthzAjmEH/AqRCNPgXw+XNuRA6r1mjAnN
EGi+UVD6V+r89dAPEcBulFOu9zOVrwromd4TYm8deyRY7oep5C8HlwM4oXbAjybY
fy/en2uxL5bDR+jJF9uH7dqGweLnTS1fanZ8FzOq2qAIplOQdGLBgraMNHF/whOd
ocJ7J++3ZNnw6gPgguAFBrjL9fLZeoNygm8OWyDcRLSdKrSxcUv7UGzUPHT3tayd
nzstybBOKkmT3O9v8q7+5jBgC9gwLA7PRIWgmGPS2vY9Zmf2/m3F2OVW0xLZ9Rsc
x4rJaM1Xx6bgUdV5aVIxZcHbSlt52dMYZhnkSKL6QNuKh0+/ix5AvMtclCu2HEM=
=nCGA
-----END PGP SIGNATURE-----

--nextPart1629166.2KmNVlS254--

