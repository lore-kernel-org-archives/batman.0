Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 5 Jul 2010 11:24:13 +0200
References: <20100630205846.230b2112@rechenknecht>
	<20100704215741.GA28501@pandem0nium>
In-Reply-To: <20100704215741.GA28501@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2088213.uctSEiAObu";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007051124.16464.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman adv unicast fragmentation
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

--nextPart2088213.uctSEiAObu
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Simon Wunderlich wrote:
> Hello Andreas,
>=20
> thank you very much for your patch. I've tested the patchset in my KVM
> setup. The fragmentation seems to work fine over one or multiple hops if i
> use the same MTUs on all hosts, but some corner cases might not bet
> handled yet.
>=20
> For example:
>=20
> Host 1 has one interface with MTU 1500 to host 2.
> Host 2 has two interfaces, one with MTU 1500 (to host 1) and one interface
> with MTU 1470 (to host 3), which might be a VPN connection.
> Host 3 has one interface with MTU 1470 to host 2.
>=20
> Now i can send packets with size 1470 or 1440 from host 1 to host 3 witho=
ut
> problems, but packets with size 1450 fail. The reason for this might be
> that host 1 sends the packet as is without fragmentation, but host 2 can
> not forward it because the MTU (1470) is too low, but does not fragment
> it. The packets therefore get dropped.
> (note: when i say packets of size xxxx i do: ping -M do -s xxxx)

I've checked some parts of the patch yesterday and would also say that this=
 is
a problem. Just to explain it a little bit further how I understood it (I a=
m a
little bit confused about your ping example because ping -s 1440 would crea=
te
a packet with the size

  1440 (data)
+    8 (icmp header)
+   20 (ip header)
+   14 (included ethernet header)
+    9 (batman-adv unicast header)
=3D=3D=3D=3D=3D=3D
  1491

Which means that we are over the mtu of 1470 between node2 and node3. Maybe
you wanted to say that size xxxx means `ping -M do -s xxxx-28`. But that wo=
uld
also mean that 1470 is not big enough to get splitted in node1.


So to my test scenario:

node1 <- mtu 1500 -> node2

Each soft-interface (bat0) has now a interface_tx function which is called
when data must be send over it (directly send and not when data must get
routed). When node1 sends a packet which would have more than 1500 bytes (w=
ith
batman-adv-unicast-header and the included ethernet header) we would split =
in
two unicast-frag-packet with roughly the half size (size / 2 + 18 bytes
unicast-frag packet).

So here an example on node1 to node2:
 * ping -s 1472 (would need mtu of 1523) - two packets (775, 775)
 * ping -s 1440 (would need mtu of 1491) - one packet (1491)
 * ping -s 1449 (would need mtu of 1500) - one packet (1500)
 * ping -s 1450 (would need mtu of 1501) - one packet (1501)  !!!!! error !=
!!!
 * ping -s 1451 (would need mtu of 1502) - one packet (1502)  !!!!! error !=
!!!
 * ping -s 1452 (would need mtu of 1503) - one packet (1503)  !!!!! error !=
!!!
 * ping -s 1453 (would need mtu of 1504) - one packet (1504)  !!!!! error !=
!!!
 * ping -s 1454 (would need mtu of 1505) - one packet (1505)  !!!!! error !=
!!!
 * ping -s 1455 (would need mtu of 1506) - two packets (766, 767)

We only accept packets with the the maximum data size of 1500 and 1501 is o=
ver
that.

It is quite easy to fix, because you misused sizeof in you check. So here s=
ome
kind of patch for your patch (as hint and not really a patch) :)

Best regards,
	Sven

diff --git a/batman-adv/fragmentation.c b/batman-adv/fragmentation.c
index f36ad0e..1a33eab 100644
=2D-- a/batman-adv/fragmentation.c
+++ b/batman-adv/fragmentation.c
@@ -74,8 +74,7 @@ void create_frag_buffer(struct list_head *head)
 	struct frag_packet_list_entry *tfp;
=20
 	for (i =3D 0; i < FRAG_BUFFER_SIZE; i++) {
=2D		tfp =3D kmalloc(sizeof(struct frag_packet_list_entry),
=2D			GFP_ATOMIC);
+		tfp =3D kmalloc(sizeof(*tfp), GFP_ATOMIC);
 		tfp->skb =3D NULL;
 		tfp->seqno =3D 0;
 		INIT_LIST_HEAD(&tfp->list);
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index ccc97c6..8e3cc40 100644
=2D-- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -221,7 +221,7 @@ int interface_tx(struct sk_buff *skb, struct net_device=
 *dev)
 			goto dropped;
=20
 		if (atomic_read(&bat_priv->frag_enabled) &&
=2D		   data_len + sizeof(unicast_packet) >
+		   data_len + sizeof(*unicast_packet) >
 		   batman_if->net_dev->mtu) {
=20
 			hdr_len =3D sizeof(struct unicast_frag_packet);
@@ -247,8 +247,7 @@ int interface_tx(struct sk_buff *skb, struct net_device=
 *dev)
 				batman_if->net_dev->dev_addr, ETH_ALEN);
 			memcpy(ucast_frag1->dest, orig_node->orig, ETH_ALEN);
=20
=2D			memcpy(ucast_frag2, ucast_frag1,
=2D			       sizeof(struct unicast_frag_packet));
+			memcpy(ucast_frag2, ucast_frag1, sizeof(*ucast_frag1));
=20
 			ucast_frag1->flags |=3D UNI_FRAG_HEAD;
 			ucast_frag2->flags &=3D ~UNI_FRAG_HEAD;

--nextPart2088213.uctSEiAObu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMMaS+AAoJEF2HCgfBJntG2FsQALFImiurjE4OxyA5Filc345t
TG29TfhghaL3TWZ/tFI8PxjphoewwDM1wulZ5ovA9mjnd6W0dXm+Oi1+tcPhOZBq
RvW1O7WVsQIhQeu/DA3DSovmc7XCKIQM5VerYnT94mt3Uc6HMA8JfMagLP3efY03
ywc1Sq1bEVa6Td8fY5m2DCjQivuCa7sQYkHdrY31foXMqPNZw94sVInRhnTEBhMB
xt9GjLykqhNXDc7mDXVj+++fnsR+7DvHJFvUFxW1Z9KK6fjILFImV+7+h9JvBRwC
7NvcYYs/mw/6RdjneV6Oi/MFQxbq1xy+hk7j8E8qUx0bXVl/7dRWJzimHXT0SI+X
4jNrSyQ9Xb6J23Ht1pTns9XvMbJBQ2SpIpVMd6Kq4pioaYcJg4wCuerDvrEi0VAQ
06isalIOnZ09mIc37HT05fKPoHsoc1G0bmgzU9URZWSsRTKVvuaQHLGZDbvgupA0
DdBgHXmt4D6eRipw8RI5ilXvl4NmPxh+xTzwn3ui19xnkuHVsWb+EB7vTB/pLnKh
06gasjDg0vksKw3PTiqi+cWXHIUEE2xZdEySE0adl+eomrK5RdISp/ZN1tmUBIHR
NUKw8c04xP3u0W/DdILShH8S+6bInLgbzZ2M4qetKO8xmGQCiW2f53EX/yMddbRV
v1aFpQQzvylGZ1wHB87W
=aqqH
-----END PGP SIGNATURE-----

--nextPart2088213.uctSEiAObu--
