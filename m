Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 02 Sep 2016 16:21:54 +0200
Message-ID: <16550232.yVtnsTEPCk@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1954974.cDSLruhM7t";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2016.3 released
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

--nextPart1954974.cDSLruhM7t
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Sep 1st, 2016. Today the B.A.T.M.A.N. team publishes the August 2016 update=
 to batman-adv, batctl and alfred! This release contains the multicast opti=
mization support for bridged setups and frame priority support for fragment=
ed packets. The initial set of patches to implement netlink support for bat=
man-adv were integrated. As the first step, it is used to interact with the=
 new kernel throughput benchmark code. Future releases will utilize netlink=
 to replace the current debugfs tables in a more memory efficient way. Also=
 several bugfixes, code cleanups and code documentation updates are include=
d in this version.

As from this release, we will report the summaries from our Changelog for e=
ach component instead of a full text.

As the kernel module always depends on the Linux kernel it is compiled agai=
nst, it does not make sense to provide binaries on our website. As usual, y=
ou will find the signed tarballs in our download section:

https://downloads.open-mesh.org/batman/releases/batman-adv-2016.3/

as well as prepackaged binaries in your distribution.
Thanks

Thanks to all people sending in patches:

 * Andrew Lunn <andrew@lunn.ch>
 * Antonio Quartulli <a@unstable.cc>
 * Florian Westphal <fw@strlen.de>
 * Linus L=FCssing <linus.luessing@c0d3.blue>
 * Marek Lindner <mareklindner@neomailbox.ch>
 * Markus Pargmann <mpa@pengutronix.de>
 * Matthias Schiffer <mschiffer@universe-factory.net>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Sven Eckelmann <sven@narfation.org>

batman-adv
=2D---------

 * support latest kernels (3.2 - 4.8)
 * multicast optimization support for bridged setups
 * initial, limited support for batman-adv netlink family
 * throughput meter implementation
 * support for frame priority in fragment packets
 * kernel doc updates and coding style cleanups
 * bugs squashed:
   - fix (re-)initialization of ELP tweaking options
   - fix elp packet data reservation
   - fix nullptr dereference after using vlan_insert_tag
   - fix various reference counting bugs in bonding, bla, tt and originator=
 code
   - fix speedy join in gateway client mode

batctl
=2D-----

 * synchronize common headers with batman-adv
 * support multicast logging and debug table
 * split tcpdump OGM packet filter in OGM and OGMv2 filter
 * add infrastructure to communicate with batadv netlink family
 * integrate command to control new kernel throughput meter

alfred
=2D-----

 * integrate support for batman-adv netlink



Happy routing,

The B.A.T.M.A.N. team

--nextPart1954974.cDSLruhM7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJXyYsCAAoJEKEr45hCkp6htC8P/ApEano74+PUqeMuCbs2h0XU
7czj3ZQVxwuB1godOnxsBGUIUSzwPxEhknJ6eVcy9GL103COZb8YQPJ/QxhMtyt+
zbeL5gRRIMgetlMupgN96h2J6PWeqhxKUm3HjA29GSLMm4I2xujwAF019uPYUE3B
1sf6tfggILlqJNdwZPp9427WlUTpezPaDPOiSvpxm+qP+dvd+sayBKjsNfH4CkUq
ePvTPqMEANgrWAYPl4d65ompe8FwJZrd0F1/lp6m22e44Byl7ii9rph+c0VUJs6s
RmzWSeVo8guDhZAaLVz96rvMIlEhHGAXo0ZoyDuu7kFP3Px15HIxNapiWs3wq/vR
RKTUsV2SYI5QkVM49JEgb+BP5yK6DoKtRtz3KFKe6NobIknY/xhzEyZkRUDzAZ35
TYJDSzPdsDOkidLja1vmPh6SNspugn6Xd2Q5A4SiFBy4zQaJ3c+vGDFTdu3K9K8J
hJDL2JSUw4ML1iiB0txBOo67eCAt48PsfEczmqeWkvbeFhP8cO80mQjEhsf8QxxU
GX5atRoRv3fltFth2nrVLVfBI7mjoDSTHG4kgAaPxI9DKrc+abJB3c/0UT0LyEMM
itnRRqaeTc9Dk4bboFw6bRxYvs8fWtR1BfbPd0Oy+sxKNRbGWpsDJuMYcJ6B45WF
9Uk+4kKyNuE9shyY/Q3N
=ipE+
-----END PGP SIGNATURE-----

--nextPart1954974.cDSLruhM7t--

