Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Jul 2010 11:57:10 +0200
References: <20100705234246.58a9209b@rechenknecht>
In-Reply-To: <20100705234246.58a9209b@rechenknecht>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11316118.pKaHf9USsF";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007061157.12304.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman adv unicast fragmentation (version 3)
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart11316118.pKaHf9USsF
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andreas Langer wrote:
> >> +			if (!(my_skb_push(frag_skb, hdr_len) >=3D 0 &&
> >> +				my_skb_push(skb, hdr_len) >=3D 0)) {
> >
> >Didn't you wanted to check if one of the my_skb_push failed and not if
> >both failed?
>=20
> This part check if one failed, but you are right if you think that it loo=
ks
> too complicated. I changed it because it is easy to misunderstand this
> expression.

Yes, sry. I mixed it up :)

> And now some words to the implementation. This version of fragmentation
> handles only packets over a batX interface. My test setup follows:
>=20
> laptop tap0 --> br0 (bat0/eth0) host1 eth1 ------> eth0 host2 -----> eth0
> host3
>=20
> ping -s 1472 -M do xxx
>=20
> 1472 bytes - data
> 28   bytes - icmp / ip
> 14   bytes - eth
>=20
> Bat0 receives 1514 bytes (interface_tx, data_len), if data_len +
> unicast_packet is larger than the mtu of the sending interface, this
> packet will be fragmented.
>=20
> In fragmentation 2.0 i would like to implement a solution for the problem
> described by simon ( i hope i understood him correctly). A node has two
> batman interfaces and the mtu of interface2 is smaller then interface1. In
> case a packet from iface1 (with the size of this mtu) travels to iface2,
> we currently have a problem. Version 2.0 will fix this.

You described the problem correct. Just for other people: batman interfaces=
=20
means not a bat0 and a bat1 interface, but two interfaces which are part of=
=20
bat0.

So for example you have a wifi connection with mtu 1530 between node1 and=20
node2 (bat0 interface has mtu 1500) and the connection between node2 and no=
de3=20
is only a fast ethernet connection with mtu 1500 (no jumbo frames support).=
=20

node1 <- mtu 1530 -> node2 <- mtu 1500 -> node3

When we send data like our 1472 ping (needs mtu 1500 on bat0, and on the re=
al=20
interface mtu 1523) to node3, it will not be fragmented between node1 and=20
node2 - thus it will not be fragmented between node2 and node3 (they will j=
ust=20
drop the packet).

So it must not only be fragmented on output (data send directly through bat=
0),=20
but also on forward (when bat0 received data on a participating interface a=
nd=20
forwards it to another/same participating interface).

I see following problem:
 * Data will be fragmented from node1 to node2
 * fragmented packet is to big to be transported to node3

Now we would have to fragment the fragmented packet again... which is ugly.=
=20
But to be honest, bat0 in a mesh which supports fragmented unicast packets =
is=20
hardcoded to 1500. That means that the link between node2 and node3 must ha=
ve=20
the mtu < 775. That would be uncommon and maybe could be forbidden by batma=
n-
adv.

best regards,
	Sven

--nextPart11316118.pKaHf9USsF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMMv33AAoJEF2HCgfBJntGqloP/3vQeYyaHjwq54XlgTOOSSxd
/yETH1RtgBNhn3JGH5+PVtTBufas0lNH8Apov8reVPPOW2hwI+vGmJ2AzBPd3kLA
3CWOAlx6t4f0ZwEHkpnS71UkRagccerETngCrBM/Yn/GDELR1RhMEdxaIz4MdoJf
x7NGMJw5KFGBlMg1on9HogxaRxfipgO5sfUEMo3tr1hXmxqI/Q6ybODJP7izTcT3
hHcBX1R1LAQw2o6IY9lWcTdWQfsg5Cv8yjxgM5D2w2H87ddpRwPV31gUVI2B89qF
dAjoTLje6adrnMaQZaFCkAvtpzg0Wl9+XeqYczZ31P4QfbLafwmSlFEFpz+AzSHD
AQk+tB8m7YwTui0S4Ys5h2SFt7lvzBr+k7iGLWWIk6GQs2pH2LpGzLDILZqP44+5
Hz63U5yJe6qa5CSSTAw87ebtiXvyOyp9MJenCe6wmGaM2/TSDnnzt/AkBtWL3R73
y83EvhWhlfDe8JZM/1xenzvA4/pfqlshmImZVt24tOP8UCUDpHEbbnVNjFuc8dNI
1mk5XVM2Wx3AI5rhg8fhRSfMSUmi7MpnRydrjLzuY2d8yn2TN+bfsOHdEVRnSKhS
vLZOCbH8S6D3+IY3dOXg4sAeOwVN5b09+7vXDAEMGegQTwYSqiTYHqjLt7COzLqJ
x5oWbIhr+s5EVqMvgSLj
=WDX/
-----END PGP SIGNATURE-----

--nextPart11316118.pKaHf9USsF--
