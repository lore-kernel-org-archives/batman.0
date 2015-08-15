Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 15 Aug 2015 19:21:11 +0800
Message-ID: <4337440.xR3JPofVg4@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11998162.DtNyxaWbOM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2015.1 released
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


--nextPart11998162.DtNyxaWbOM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


August 10, 2015. The B.A.T.M.A.N. team today releases batman-adv 2015.1=
=20
focusing on code cleanups, stability and bugfixes. Since no major code =
changes=20
were introduced upgrading to this version should bear minimal risks. As=
 the=20
kernel module always depends on the Linux kernel it is compiled against=
, it=20
does not make sense to provide binaries on our website. As usual, you w=
ill=20
find the signed tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2015.1/

as well as prepackaged binaries in your distribution.


Important changes
=2D----------------

The default settings for enabling Network Coding and the bridge loop av=
oidance=20
have been changed. If you are using either feature, please verify that =
your=20
setup still behaves as expected after the upgrade.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Alex Suykov <alex.suykov@gmail.com>
 * Antonio Quartulli <antonio@meshcoding.com>
 * Linus L=FCssing <linus.luessing@c0d3.blue>
 * Marek Lindner <mareklindner@neomailbox.ch>
 * Markus Pargmann <mpa@pengutronix.de>
 * Ruben Wisniewsi <ruben@vfn-nrw.de>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

With this release the source directory structure has been modified to a=
lign=20
with the batman-adv directory structure in the Linux kernel. This shoul=
d=20
facilitate proposing and applying patches based on the code base shippe=
d with=20
Linux kernel. In parallel to this restructuring effort, the compat laye=
r=20
(needed to support older Linux kernel versions) also has been modernize=
d. The=20
single compat include file has been divided into separate header files =
named=20
after their up-to-date counterparts. Previously needed explicit compat=20=

includes could be removed, thus further reducing the difference between=
 the=20
Linux kernel code and the out-of-tree repository.

To make the first time deployment a better experience the default=20
configuration has been changed: Network Coding support has been disable=
d due=20
to its dependency on WiFi promiscuous mode that not all WiFi chips/driv=
ers=20
support. The bridge loop avoidance mechanism (BLA) has been enabled to =
prevent=20
accidental bridge loops from being created.

The batman-adv module came with its own Jenkins hash implementation use=
d by=20
all sorts of components like the originator table, the translation tabl=
e and=20
more. That implementation has been replaced with the in-kernel Jenkins =
hash=20
which provides better optimized code. The debugfs components aren't com=
piled=20
into the module anymore when debugfs is not compiled into the kernel. T=
he=20
initialization upon detection of a batman-adv gateway has been fixed as=
 it=20
could cause the kernel to hang on module unload. Various race condition=
s=20
triggered by concurrent delete events in the translation table code hav=
e been=20
fixed as well. Payload broadcast packets scheduled to be forwarded righ=
t on=20
batman-adv disable or module onload are now properly purged to prevent =
memory=20
leaks. With enabled distributed ARP table (DAT) batman-adv might have a=
nswered=20
an ARP request for a local client. An additional mac address check prev=
ents=20
confusing switches in the LAN which rely on ARP to learn behind which p=
ort the=20
client is located. Quite some effort was spent to improve the overall c=
ode=20
readability, cleanups and coding style issues.


batctl
=2D-----

To support building batctl in combination with the musl C library the=20=

if_ether.h header file is now included from the 'netinet' folder instea=
d of=20
the 'linux' folder because musl does not allow mixing includes from 'ne=
tinet'=20
and 'linux' at the same time.


alfred
=2D-----

Interfaces with more than one link-local addresses are now supported by=
 alfred=20
binding to specific an interfaces and its link-local EUI64 address. All=
=20
outgoing alfred packets will be originating from that single address.

The size of the maximum alfred payload was slightly reduced. This ensur=
es that=20
the UDP/IPv6 stack is able to transfer the push data packets between di=
fferent=20
alfred servers.


Happy routing,
The B.A.T.M.A.N. team
--nextPart11998162.DtNyxaWbOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVzyCvAAoJEFNVTo/uthzAs+gH/RcekS+zC9JGpYNd8SC5IIYE
kAfiyCkaUwNTTdvRxjT/PZh0Ncn4KqEUHW53n75eErEp7B7O6TbNmxSWZsxlO0tt
Hk7LE5K/4ASKIPzE/1epEK0CCpZ+PYT35nRc03T4g+8KVdZpzAKRG9vSWSLiOSZY
dq9y1o9QsNnypchLv6+bQBUM05BmXDCbqCFRdxtpxXgXgaziTQAxasZVliWeq3j2
D8yKeEZ9vLXqGjJA0YhUYBzIvo+bnhW1MY9VfhEbiFAItwIzrkbun4YPjVzMRvQt
HWxUplGvgEvLUqNqRZabXYT4YSXjmqFi3DVS4jSBBCGhahQMvG/QmiJglymCkeM=
=X7lU
-----END PGP SIGNATURE-----

--nextPart11998162.DtNyxaWbOM--

