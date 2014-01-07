Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jan 2014 20:53:18 +0800
Message-ID: <4577758.QFzZxb72dK@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14328963.aXyxCV32X8";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
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


--nextPart14328963.aXyxCV32X8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


The B.A.T.M.A.N. team is pleased to announce the immediate availability=
 of=20
batman-adv 2014.0.0 - a release coming with a rewritten packet handling=
 engine=20
and many new features almost uniquely tailored to preserve backward=20
compatibility in the future. As the kernel module always depends on the=
 Linux=20
kernel it was compiled against, it does not make sense to provide binar=
ies on=20
our website. As usual, you will find the signed tarballs in our downloa=
d=20
section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2014.0.0/

as well as prepackaged binaries in your distribution.


Important changes
-----------------

*Compatibility break*: In 2011, batman-adv broke backward compatibility=
 with=20
the introduction of the translation table mechanism. Since then, intere=
sts=20
have been divided between those who wish a stable network with as littl=
e=20
changes as possible and those who wish to experiment with new features =
to=20
bring meshing to the next level. To accommodate both groups the batman-=
adv=20
developers dedicated a lot of effort on building code infrastructure al=
lowing=20
to mix stable nodes with new features without breaking compatibility. T=
his new=20
system is incompatible to the pre-2014.0.0 versions, but it has been de=
signed=20
to stay compatible with future versions for the next decade or so.

At the same time, the legacy visualization support was removed from the=
 kernel=20
module. The alfred user space module provides an adequate replacement.


Thanks
------

Thanks to all people sending in patches:

 * Antonio Quartulli <antonio@meshcoding.com>
 * Joe Perches <joe@perches.com>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marco Dalla Torre <marco.dallato@gmail.com>
 * Marek Lindner <mareklindner@neomailbox.ch>
 * Martin Hundeb=F8ll <martin@hundeboll.net>
 * Simon Wunderlich <sw@simonwunderlich.de>
 * Spyros Gasteratos <morfeas3000@gmail.com>
 * Sven Eckelmann <sven@narfation.org>
 * Tan Xiaojun <tanxiaojun@huawei.com>


batman-adv
----------

Transforming a rather static design to a module architecture in the int=
erest=20
of preserving backward compatibility requires modifications on a multit=
ude of=20
levels. The principal idea behind the TVLV (type-version-length-value)=20=

infrastructure is to break up mesh management data into logic chunks=20=

(containers) which can be extended in the future while preserving backw=
ard=20
compatibility. If a mesh participant receives an unknown TVLV type or v=
ersion=20
of a certain container it can simply skip the current container and pro=
ceed=20
with the next. Therefore, all non-routing data sent with OGMs (e.g. gat=
eway=20
advertisement, translation table data, etc) were transformed to TVLV=20=

containers that are still attached to OGMs. In addition, translation ta=
ble=20
request & response packets as well as roaming advertisement packets wer=
e=20
transformed to TVLV containers too.
While designing the containers a couple of feature requests were also=20=

addressed: The compressed download & upload gateway bandwidth (known as=
=20
'gateway class') was replaced by uncompressed bandwidth information per=
mitting=20
granular gateway bandwidth announcement. DAT and network coding feature=
=20
support is communicated into the mesh through TVLV containers as both=20=

subsystems optimize their performance based on the knowledge which mesh=
=20
participant has the feature enabled.
In the interest of backward compatibility on the packet forwarding leve=
l=20
batman-adv received a general unicast packet forwarding mechanism. This=
=20
mechanism forwards or drops unknown packet types based on the packet ty=
pe=20
numbering.

The batman-adv built-in packet fragmentation has been redesigned and re=
written=20
as part of the 'fragmentation 2' Google Summer of Code project. Major d=
esign=20
goals include: Variable number of fragments (up to 16), generic fragmen=
tation=20
framework capable of handling all types of traffic (the 'old' fragmenta=
tion code=20
was limited to payload unicast packets) and 'upper layer' transparency =
through=20
early re-assembly. The maximum of local clients the translation table i=
s able=20
to handle went up by a factor of 16 (the maximum number of fragmented p=
ackets)=20
as full translation table exchanges are able to take advantage of the n=
ewly=20
introduced generic fragmentation. If the fragmentation is disabled or t=
he MTU=20
altered the local translation table is automatically reduced to fit the=
 new=20
maximum translation table size. Part of the increased maximum table siz=
e is=20
the transition from CRC16 consistency checksumming to CRC32 to reduce=20=

collision probability and take advantage of hardware acceleration suppo=
rt. The=20
translation table also gained full VLAN awareness making it the final c=
omponent=20
receiving full VLAN support. Non-mesh clients are now entirely separate=
d on a=20
per-VLAN basis. As a consequence, the bridge loop avoidance is capable =
of=20
resolving bridge loops more elegantly (one VLAN might be bridged into t=
he LAN=20
while another one is not), the Distributed ARP Table (DAT) builds its=20=

distributed IP-MAC address hash on a per-VLAN basis and the AP isolatio=
n=20
allows fine-grained control over which VLAN should be isolated and whic=
h should=20
not.

The kernel module sets a dummy rx mode handler on batman-adv' virtual=20=

interface creation to be able to accepts static multicast listener=20
configurations on top of the batX interface. In order to help wireless =
drivers=20
to select the suitable traffic queue (e.g. WMM queues), batman-adv peek=
s into=20
the encapsulated payload IP or VLAN header and sets the skb priority fi=
eld=20
accordingly. This priority field is used whenever the lower layer drive=
rs (like=20
wireless or ethernet drivers) are unable to retrieve the prioritization=
=20
themselves due to the batman-adv traffic encapsulation.


batctl
------

As part of our ongoing effort for better IPv6 support quite a few missi=
ng=20
pieces have been tackled: The IP-address-to-MAC-address resolver was ex=
tended=20
to also support IPv6 addresses. This was achieved by porting the intern=
al=20
resolver from the '/proc/net/arp' based approach to the RTNL API. As a =
result=20
the translate, ping and traceroute commands accept IPv6 addresses as=20=

destination argument which batctl tries to convert back to MAC addresse=
s in=20
similar to the IPv4 conversion. Furthermore, the tcpdump component was=20=

enriched with an IPv6 parser being able to decapsulate TCP, UDP and com=
mon=20
ICMPv6 packet types.
The vis export feature has been removed as the kernel module no longer=20=

supports the visualization protocol. A number of cleanups and smaller f=
ixes=20
such as marking local functions as static, adding header include guards=
 and=20
more found their way into this release as well.


alfred
------

The missing libmath linker flag of the alfred-gpsd component was fixed =
and its=20
manpage installation arranged.



Happy routing,
The B.A.T.M.A.N. team

--nextPart14328963.aXyxCV32X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSy/jBAAoJEFNVTo/uthzACXYIAL3LafTV/ha5SQkO/STF24em
RxkFV9EPwqiTmN8Q5DtjwUCVKbfzNnXA/34CZVc/5TdBLTC7+WP6DGJP//ojIuUq
6udilJU77mGtjWYdYIsAR5YlGWuFhZVsLUZ3GxDpRyJV0ALVx6ArrDbs6D74ClNw
8cL0jubLNBtQHRP8FhECZnnxP20c4AfSNT3FQ22200bukpY7pejB34i4ZKtog2B7
hx5we5apX60TYCHe6QLP7CHTbBwjkkqj2N0f5Y3er1S1Eelnat6LOWOKiaLeHOyy
BDRlagGeJo3gvzMbUV/Vx0m8XswmVd+yfl/wtNK2cF8J4R29iRXMdeFJH9MqLOQ=
=IDvv
-----END PGP SIGNATURE-----

--nextPart14328963.aXyxCV32X8--

