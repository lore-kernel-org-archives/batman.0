Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 00:26:45 +0800
Message-ID: <25996416.6tt6eK7d7k@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1767185.q1OSxUXgPK";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2014.2.0 released
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


--nextPart1767185.q1OSxUXgPK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


June 09, 2014. The B.A.T.M.A.N. team today releases batman-adv 2014.2.0=
 adding=20
a new major component - multicast optimizations - along with a series o=
f bug=20
fixes. As the kernel module always depends on the Linux kernel it is co=
mpiled=20
against, it does not make sense to provide binaries on our website. As =
usual,=20
you will find the signed tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2014.2.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Antonio Quartulli <antonio@meshcoding.com>
 * Fengguang Wu <fengguang.wu@intel.com>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marek Lindner <mareklindner@neomailbox.ch>
 * Martin Hundeb=F8ll <martin@hundeboll.net>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

This release brings the first piece of a more efficient, group aware mu=
lticast=20
forwarding infrastructure in batman-adv. In the past, batman-adv had tr=
eated=20
multicast traffic like ordinary broadcast traffic and simply forwarded =
each=20
multicast packet to every node in the network. Aiming to reduce unneces=
sary=20
packet transmissions in large networks, this initial improvement announ=
ces=20
multicast listeners via the translation table mechanism, thereby signal=
ing=20
interest in certain multicast traffic. Based on this information, batma=
n-adv=20
can make the decision to either drop multicast traffic if no listener i=
s=20
present or forwarding the multicast traffic via unicast if a single lis=
tener=20
signaled interest. Alternatively, multicast traffic is forwarded to the=
 entire=20
network as before.
For now, these optimizations only apply if all nodes in the mesh have n=
o=20
bridge interface on top their batX interface. However, extending these=20=

optimizations beyond the realm of non-bridged interfaces as well as opt=
imizing=20
setups with more than one listener are on the roadmap.

Numerous reference counter imbalances in the heavily lifted routing cod=
e=20
causing all sorts of shutdown issues like system hang on reboot have be=
en=20
addressed. Another reference counter balance was hidden in the fragment=
ation=20
v2 code sparking similar shutdown issues. A kernel crash on accessing a=
n=20
insufficiently protected pointer in the gateway code has been eliminate=
d. In=20
some situations retrieving the originator table would also lead to a ke=
rnel=20
crash due to improper checking. Fast adding and deletion of VLAN interf=
aces on=20
top of batX drove batman-adv into an internal translation table state=20=

mismatch. The resulting translation table exchanges with neighbors were=
 bogus,=20
thus creating inconsistencies on every node in the network. On changing=
 the=20
batX mac address batman-adv did not inform the translation table to als=
o=20
update the entries of all VLAN interfaces on top of batX. Stale mac add=
ress=20
announcements were the consequence.
The code documentation (kernel doc) has been extended, accompanied by t=
he=20
customary code cleanups & Linux coding style adjustments.=20


batctl
=2D-----

The newly added multicast optimizations can be enabled / disabled throu=
gh=20
batctl. Because the local and network-wide multicast mac address announ=
cements=20
are propagated via the translation table, batctl gained an option to fi=
lter=20
multicast mac addresses and 'normal' client mac addresses upon translat=
ion=20
table retrieval.=20
The tcpdump component received a fix for the erroneously printed IP src=
 / dst=20
fields (a regression introduced with the IPv6 parsing support). The loc=
al=20
translation table skip table header parameter was updated to correctly =
skip=20
the lengthened table header.=20


alfred
=2D-----

The detection and handling of once working but now broken network socke=
ts has=20
been improved. Alfred can easily encounter this situation if a local in=
terface=20
was recreated or a mac address changed e.g. due to manual assignment). =
The=20
malfunctioning sockets are now closed and re-opened automatically.


Happy routing,
The B.A.T.M.A.N. team

--nextPart1767185.q1OSxUXgPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTleBJAAoJEFNVTo/uthzAUJcIAJhQ1IHRaVuAUGRb3+eccAr8
d82IOCkMqo83/a0JOlix1m5RFAaVQAKb4EXpNfY6UVGDCzXBaTyboVDGAKIDuAn5
WxPV9q0iUaLR8YJS2hag4IoOEE3zeKJjQ7HgBwtrC+totCsI2aPw1xKQol2Yqy7u
6nNTGg3Ej9+UNowwgRIuBsvS0r08Llt+uf/WkoH0MzfEfQ0PO4HOazK+ruJLE6IC
fyPyLi9kGOMm+FgYiKCyloH1cTJfKqct4IxhcJuiuGWaorxZjip+SrL1X2x1VnyW
z8aD1mrw2gW6O9MQbdoFmYv96DeK5df7/nBobvH9E1TCCjozl7wDnUHxq0SmOuo=
=MFhh
-----END PGP SIGNATURE-----

--nextPart1767185.q1OSxUXgPK--

