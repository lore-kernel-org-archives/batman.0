Return-Path: <gmazzurco89@gmail.com>
Message-ID: <4FDC4394.7040807@gmail.com>
Date: Sat, 16 Jun 2012 10:28:04 +0200
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
MIME-Version: 1.0
References: <201206160256.01139.lindner_marek@yahoo.de>
In-Reply-To: <201206160256.01139.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv 2012.2.0 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Great job guys and many thanks!!

On 06/15/12 20:56, Marek Lindner wrote:
>=20
> Today, the B.A.T.M.A.N. team releases batman-adv 2012.2.0, packed with ne=
w=20
> features and improvements in various subsystems as well as the usual set =
of=20
> fixes and cleanups. As the kernel module always depends on the Linux kern=
el it=20
> was compiled against, it does not make sense to provide binaries on our=20
> website. As usual, you will find the signed tarballs in our download sect=
ion:
>=20
> http://downloads.open-mesh.org/batman/releases/batman-adv-2012.2.0/
>=20
> as well as prepackaged binaries in your distribution.
>=20
>=20
> Important changes
> -----------------
>=20
> This release comes with a completely rewritten bridge loop avoidance (als=
o=20
> known as bridge loop avoidance II). The concept of the first bridge loop =

> avoidance was simple and worked well in small size LANs while larger netw=
orks=20
> suffered from the overhead. The new concept is very different and require=
s=20
> changes in your batman-adv configuration. If you were using the bridge lo=
op=20
> avoidance you should consult our documentation before upgrading your=20
> network(s).
>=20
> The default "per hop" penalty was increased to encourage batman-adv to ta=
ke=20
> shorter routes. If you notice altered routing behavior and are unhappy wi=
th=20
> the result you should revisit the hop penalty configuration option.
>=20
>=20
> Thanks
> ------
>=20
> Thanks to all people sending in patches:
>=20
>  * Antonio Quartulli <ordex@autistici.org>
>  * Danny Kukawka <danny.kukawka@bisect.de>
>  * David S. Miller <davem@davemloft.net>
>  * Eric Dumazet <eric.dumazet@gmail.com>
>  * Linus Luessing <linus.luessing@web.de>
>  * Marek Lindner <lindner_marek@yahoo.de>
>  * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>  * Sven Eckelmann <sven@narfation.org>
>  * Xabier Rodriguez <xrb@kalrong.net>
>=20
> and to all those that supported us with good advice, code review and/or=20
> rigorous testing:
>=20
>  * Al Viro <viro@ZenIV.linux.org.uk>
>  * David Laight <David.Laight@aculab.com>
>  * Jo-Philipp Wich <jow@openwrt.org>
>  * Martin Hundeb=F8ll <martin@hundeboll.net>
>=20
>=20
> batman-adv
> ----------
>=20
> The new bridge loop avoidance certainly is the most prominent of the new =

> features this release has to offer (completely replacing the old bridge l=
oop=20
> avoidance mechanism). The major design goals were performance and scalabi=
lity.=20
> Since the old implementation was relying on a single gateway to be the ma=
ster=20
> gateway to the LAN for everybody else it created a performance bottleneck=
.=20
> Furthermore, the LAN was used to send traffic to and receive data from th=
e=20
> master gateway. With the number of bridged gateways grew the amount of=20
> broadcast traffic in the LAN. The new bridge loop avoidance splits the cl=
ient=20
> responsibility amongst all participating gateways. Each gateway "claims" =
the=20
> clients it feels responsible for and ignores the traffic from all other=20
> clients to avoid the bridge loop. It also is able to handle multiple VLAN=
s on=20
> top of the batX interface connected to different topologies. All details =
about=20
> the loop avoidance mechanism are explained in our documentation section.
>=20
> The routing code also received lots of attention: The recently added rout=
ing=20
> protocol abstraction was further polished and extended to better accommod=
ate=20
> the needs of alternative routing protocols. B.A.T.M.A.N. IV protocol has =
been=20
> enhanced with an additional flag to apply stricter forwarding rules to OG=
Ms=20
> which allows the protocol to avert routing loops in certain corner cases.=
=20
> Also, the B.A.T.M.A.N. IV sequence numbers are now randomized at startup =
to=20
> reduce the probability of a collision and thus, slowing down the protocol=
 in=20
> the startup phase. Rerouting of unicast payload packets during a roaming =
phase=20
> is handled with greater efficiency to avoid as much packet loss while roa=
ming=20
> as possible.=20
>=20
> All manual HZ-jiffies-calculations have been replaced with the in-kernel =

> jiffies_to_msecs() function. To facilitate comprehension of the code base=
 the=20
> ETH_ALEN macro is used instead of hardcoded numeric constants. The batman=
-adv=20
> internal bitarray operations have been converted to the efficient in-kern=
el=20
> bitmap operations. It was discovered that the TT-Request packet did not a=
lways=20
> send the tt-crc field in network byte order, thereby invalidating the pac=
ket.=20
> This has been fixed alongside the suboptimal DHCP option list parser used=
 by=20
> the gateway extension. OGM sequence numbers now are always printed as uns=
igned=20
> long to avoid misinterpretation while printing the numbers in the debug l=
og.
>=20
>=20
> batctl
> ------
>=20
> The batctl utility supports the new bridge loop avoidance by providing an=
=20
> option to conveniently enable/disable the bridge loop avoidance and expor=
ts=20
> the bridge loop avoidance claim table. It will also warn about features t=
hat=20
> haven't been compiled into batman-adv such as debug log and bridge loop=20
> avoidance. The mini-tcpdump learned to display the newly added 'not best =
hop=20
> flag' when parsing OGMs.=20
>=20
>=20
> Happy routing,=20
> The B.A.T.M.A.N. team
