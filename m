Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 13 Mar 2014 21:27:56 +0800
Message-ID: <2620023.llp8cNp8dx@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8305181.nMeOxZnbf6";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2014.1.0 released
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


--nextPart8305181.nMeOxZnbf6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


The B.A.T.M.A.N. developers are happy to present batman-adv 2014.1.0,=20=

stabilizing the feature-packed 2014.0.0 release while also pushing rout=
ing=20
improvements and other smaller features. As the kernel module always de=
pends=20
on the Linux kernel it is compiled against, it does not make sense to p=
rovide=20
binaries on our website. As usual, you will find the signed tarballs in=
 our=20
download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2014.1.0/

as well as prepackaged binaries in your distribution.

Thanks
=2D-----

Thanks to all people sending in patches:

 * Antonio Quartulli <antonio@meshcoding.com>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marek Lindner <mareklindner@neomailbox.ch>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Stephen Hemminger <stephen@networkplumber.org>
 * Sven Eckelmann <sven@narfation.org>
 * Ying Xue <ying.xue@windriver.com>

Special thanks to Russell Senior for his vigorous testing and debugging=
=20
efforts.


batman-adv
=2D---------

After having accomplished the heavy infrastructure lifting with the pre=
vious=20
release, the attention shifted towards batman-adv's core functionality =
=2D=20
routing packets - once more. The forwarding mechanism of the mesh proto=
col=20
messages (OGMs) was revamped to allow applying rules when packets are=20=

forwarded from one interface to another. For example, when the same int=
erface=20
is used for sending and receiving, there might be throughput degradatio=
n on=20
half-duplex interfaces such as WiFi which is now reflected in the metri=
c. At=20
the same time, packets switching interfaces (incoming interface is not =
equal=20
to the outgoing one) do not get handicapped, effectively favoring inter=
face=20
switching. To pull all this together, batman-adv now maintains a routin=
g table=20
per interface (plus the default routing table) which essentially allows=
 the=20
kernel module to route traffic based on network wide multi-interface=20=

information.

Also new on board is the extended AP isolation, aiming to grant fine-gr=
ained=20
isolation control by working with a user specified 'skb mark'. Incoming=
=20
broadcast packets carrying the specified skb mark are flagged as 'isola=
ted'=20
(translation table flag). Isolated packets received over the mesh are=20=

transformed back to an skb with a mark before they are forwarded to the=
 upper=20
layers. There, the packets can be filtered, dropped, etc by netfilter a=
nd=20
friends based on the skb mark.

The DHCP packet handling scope was widened to force all DHCP packet typ=
es to=20
unicast transmission (with the gateway feature enabled), covering older=
 /=20
unusual DHCP client implementations. Previously, only DHCP discover pac=
kets=20
were forwarded as unicast. The MTU overhead calculation did not conside=
r the=20
prepended Ethernet header before setting dev->hard_header_len leading t=
o=20
fragmented packets. Also removed was the 1500 bytes MTU limit on the ba=
tX=20
interface by improving the maximum MTU computation. A potential kernel =
crash=20
on skb reallocation was fixed along numerous problems in the translatio=
n table=20
component and a memory leak in the newly introduced TVLV infrastructure=
 code.


batctl
=2D-----

The recent switch to the RTNL API was further enriched by replacing the=
 custom=20
RTNL code with the libnl library to reduce maintenance burden and secur=
ity=20
risks. The batctl Makefile attempts to locate the libnl library by itse=
lf as=20
well as tries to determine the compiler options, thereby facilitating t=
he=20
build process.

To monitor the per-interface routing tables, batctl gained the ability =
to=20
retrieve the routing table of a particular interface (the local routing=
 table=20
is shown per default). Also, the extended AP isolation mark/mask pair c=
an be=20
configured through batctl.


alfred
=2D-----

Fixed was a file descriptor leak in the batadv-vis component which is p=
art of=20
the alfred package. Over a longer period time file descriptors were ope=
ned and=20
'lost', leading batadv-vis to eventually hit the open file limit and st=
op=20
normal operation.


Happy routing,
The B.A.T.M.A.N. team

--nextPart8305181.nMeOxZnbf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTIbJgAAoJEFNVTo/uthzAQ9cIAIszeNSk+MJtwt3TkdmQ6ZpI
IyERxG3djDvNs8NOFAHfMso9guCYSx3clS+y8XF7p8gXALd0CLJhq6+46B1+7SHT
jHdsD2DsihSZzAcPlq5sM9zDGRqnUZAu1ZOrV3xs4mh7n1LwJ2rmyGmj/+Qt1peO
ew5yE7oKVidjREnjl4LpnFWfp7gMv32kG97FkznyJbMDH0GMIjtzBTv388ymQlhj
isWO3w3nHRz4YjUABV/QCsBkeRDiao30HjbbxBxpw6Dn5a5IdtY7yxzC9FYAi0vz
0nO82aAWIQ9MoS/NOCFNmmoxkh1AQAgpPVqNG6LlwdPQV5BAPtx/5uIzF+2nGmo=
=KDM9
-----END PGP SIGNATURE-----

--nextPart8305181.nMeOxZnbf6--

