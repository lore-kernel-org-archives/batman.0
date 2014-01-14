Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52D5B47D.8090406@wirelesspt.net>
Date: Tue, 14 Jan 2014 17:04:45 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot>
In-Reply-To: <4577758.QFzZxb72dK@diderot>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5d4QX6aRM2P6oqHVudTPVa197LnBGgrHH"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5d4QX6aRM2P6oqHVudTPVa197LnBGgrHH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello

Withing the next month or 2 i will be deploying new firmware in my mesh
overseas. I am now testing 2014 and if everything seems ok; the new
builds will have and i can report results. (my current build that was to
be deployed has 2013.4.0-1 v14.

Has anyone started any tests ? If so any results or conclusions in
comparison to previous versions ?


Regarding the docs @
http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-conf=
ig
are they to be updated or to stay as they are ?

The reason i ask is because there seems to be necessary changes such as:

batman_adv: bat0: The MTU of interface adhoc0 is too small (1528) to
handle the transport of batman-adv packets. Packets going over this
interface will be fragmented on layer2 which could impact the
performance. Setting the MTU to 1546 would solve the problem.

Are there any other changes  hat may need to be done for 2014 ?

On 01/07/2014 07:53 AM, Marek Lindner wrote:
>=20
> The B.A.T.M.A.N. team is pleased to announce the immediate availability=
 of=20
> batman-adv 2014.0.0 - a release coming with a rewritten packet handling=
 engine=20
> and many new features almost uniquely tailored to preserve backward=20
> compatibility in the future. As the kernel module always depends on the=
 Linux=20
> kernel it was compiled against, it does not make sense to provide binar=
ies on=20
> our website. As usual, you will find the signed tarballs in our downloa=
d=20
> section:
>=20
> http://downloads.open-mesh.org/batman/releases/batman-adv-2014.0.0/
>=20
> as well as prepackaged binaries in your distribution.
>=20
>=20
> Important changes
> -----------------
>=20
> *Compatibility break*: In 2011, batman-adv broke backward compatibility=
 with=20
> the introduction of the translation table mechanism. Since then, intere=
sts=20
> have been divided between those who wish a stable network with as littl=
e=20
> changes as possible and those who wish to experiment with new features =
to=20
> bring meshing to the next level. To accommodate both groups the batman-=
adv=20
> developers dedicated a lot of effort on building code infrastructure al=
lowing=20
> to mix stable nodes with new features without breaking compatibility. T=
his new=20
> system is incompatible to the pre-2014.0.0 versions, but it has been de=
signed=20
> to stay compatible with future versions for the next decade or so.
>=20
> At the same time, the legacy visualization support was removed from the=
 kernel=20
> module. The alfred user space module provides an adequate replacement.
>=20
>=20
> Thanks
> ------
>=20
> Thanks to all people sending in patches:
>=20
>  * Antonio Quartulli <antonio@meshcoding.com>
>  * Joe Perches <joe@perches.com>
>  * Linus L=C3=BCssing <linus.luessing@web.de>
>  * Marco Dalla Torre <marco.dallato@gmail.com>
>  * Marek Lindner <mareklindner@neomailbox.ch>
>  * Martin Hundeb=C3=B8ll <martin@hundeboll.net>
>  * Simon Wunderlich <sw@simonwunderlich.de>
>  * Spyros Gasteratos <morfeas3000@gmail.com>
>  * Sven Eckelmann <sven@narfation.org>
>  * Tan Xiaojun <tanxiaojun@huawei.com>
>=20
>=20
> batman-adv
> ----------
>=20
> Transforming a rather static design to a module architecture in the int=
erest=20
> of preserving backward compatibility requires modifications on a multit=
ude of=20
> levels. The principal idea behind the TVLV (type-version-length-value) =

> infrastructure is to break up mesh management data into logic chunks=20
> (containers) which can be extended in the future while preserving backw=
ard=20
> compatibility. If a mesh participant receives an unknown TVLV type or v=
ersion=20
> of a certain container it can simply skip the current container and pro=
ceed=20
> with the next. Therefore, all non-routing data sent with OGMs (e.g. gat=
eway=20
> advertisement, translation table data, etc) were transformed to TVLV=20
> containers that are still attached to OGMs. In addition, translation ta=
ble=20
> request & response packets as well as roaming advertisement packets wer=
e=20
> transformed to TVLV containers too.
> While designing the containers a couple of feature requests were also=20
> addressed: The compressed download & upload gateway bandwidth (known as=
=20
> 'gateway class') was replaced by uncompressed bandwidth information per=
mitting=20
> granular gateway bandwidth announcement. DAT and network coding feature=
=20
> support is communicated into the mesh through TVLV containers as both=20
> subsystems optimize their performance based on the knowledge which mesh=
=20
> participant has the feature enabled.
> In the interest of backward compatibility on the packet forwarding leve=
l=20
> batman-adv received a general unicast packet forwarding mechanism. This=
=20
> mechanism forwards or drops unknown packet types based on the packet ty=
pe=20
> numbering.
>=20
> The batman-adv built-in packet fragmentation has been redesigned and re=
written=20
> as part of the 'fragmentation 2' Google Summer of Code project. Major d=
esign=20
> goals include: Variable number of fragments (up to 16), generic fragmen=
tation=20
> framework capable of handling all types of traffic (the 'old' fragmenta=
tion code=20
> was limited to payload unicast packets) and 'upper layer' transparency =
through=20
> early re-assembly. The maximum of local clients the translation table i=
s able=20
> to handle went up by a factor of 16 (the maximum number of fragmented p=
ackets)=20
> as full translation table exchanges are able to take advantage of the n=
ewly=20
> introduced generic fragmentation. If the fragmentation is disabled or t=
he MTU=20
> altered the local translation table is automatically reduced to fit the=
 new=20
> maximum translation table size. Part of the increased maximum table siz=
e is=20
> the transition from CRC16 consistency checksumming to CRC32 to reduce=20
> collision probability and take advantage of hardware acceleration suppo=
rt. The=20
> translation table also gained full VLAN awareness making it the final c=
omponent=20
> receiving full VLAN support. Non-mesh clients are now entirely separate=
d on a=20
> per-VLAN basis. As a consequence, the bridge loop avoidance is capable =
of=20
> resolving bridge loops more elegantly (one VLAN might be bridged into t=
he LAN=20
> while another one is not), the Distributed ARP Table (DAT) builds its=20
> distributed IP-MAC address hash on a per-VLAN basis and the AP isolatio=
n=20
> allows fine-grained control over which VLAN should be isolated and whic=
h should=20
> not.
>=20
> The kernel module sets a dummy rx mode handler on batman-adv' virtual=20
> interface creation to be able to accepts static multicast listener=20
> configurations on top of the batX interface. In order to help wireless =
drivers=20
> to select the suitable traffic queue (e.g. WMM queues), batman-adv peek=
s into=20
> the encapsulated payload IP or VLAN header and sets the skb priority fi=
eld=20
> accordingly. This priority field is used whenever the lower layer drive=
rs (like=20
> wireless or ethernet drivers) are unable to retrieve the prioritization=
=20
> themselves due to the batman-adv traffic encapsulation.
>=20
>=20
> batctl
> ------
>=20
> As part of our ongoing effort for better IPv6 support quite a few missi=
ng=20
> pieces have been tackled: The IP-address-to-MAC-address resolver was ex=
tended=20
> to also support IPv6 addresses. This was achieved by porting the intern=
al=20
> resolver from the '/proc/net/arp' based approach to the RTNL API. As a =
result=20
> the translate, ping and traceroute commands accept IPv6 addresses as=20
> destination argument which batctl tries to convert back to MAC addresse=
s in=20
> similar to the IPv4 conversion. Furthermore, the tcpdump component was =

> enriched with an IPv6 parser being able to decapsulate TCP, UDP and com=
mon=20
> ICMPv6 packet types.
> The vis export feature has been removed as the kernel module no longer =

> supports the visualization protocol. A number of cleanups and smaller f=
ixes=20
> such as marking local functions as static, adding header include guards=
 and=20
> more found their way into this release as well.
>=20
>=20
> alfred
> ------
>=20
> The missing libmath linker flag of the alfred-gpsd component was fixed =
and its=20
> manpage installation arranged.
>=20
>=20
>=20
> Happy routing,
> The B.A.T.M.A.N. team
>=20


--5d4QX6aRM2P6oqHVudTPVa197LnBGgrHH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS1bSLAAoJENmyd4cVxLOCjT8QAJxQSNTcNoXEwDauDxbetSFJ
pe/8M41s3A7bSpmb6WZ4kpJq8fzJ1FAoaS/hn/mt0bH08GRAsE1Y8qYFNnj/4jaE
Zr3evmCN9kKIv52bR5Dn/FAxybxpaoXQIaZe5PmcNTLpfBHKiJT3a63RK2x8x8YK
B2LiVydckKcgLvnoAWTkKGx3FwrbC+2yzucE63jyn1YU3qDN+XZXP4jjXiwbSae5
6TctH8KiBU2CHSCbf32daMvLyl42dK771ntquF5MVhx6SdTwUJ3bPMIEn0gqRWhR
B/ck9dIE1PY1tkWSkOURllSNuSlwcBix+Ayr6cVrHExJszsm3iL6y1TCVDRr4slI
/atuXaPdf+EurqSicwBxOQe05mo5gzHzVFb1Sg2RExz8EiCCdBeZ5ar+7Dqd4OdF
IqABX3X8VGLoOV7S/Ve6Q/Ky9B1CYxCEED6BpoWt1bQ9mIpyRP8vSVfpGJ2G3dFn
yDNWvLZaAXxVQ5Tum5iylvUbSqJVi2yg09HzSvLl9JrAQaQIQ9sIGBwOtbbooXoV
N+hvDNDXM+rmfHMkftaapnGf9MTXxAPnRgRU//TmSZ6lt/6Y4v94faWf8FoT1u5S
021H7t6Eg1K9abmR6rOSXE85wnf2D1G2Af+xD+ZXoc5LtHkceZx4c2mX9KjtNiyG
S47NibknIm3dlUW++wlE
=Hzsh
-----END PGP SIGNATURE-----

--5d4QX6aRM2P6oqHVudTPVa197LnBGgrHH--
