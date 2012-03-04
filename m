Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Mar 2012 16:13:05 +0800
References: <4F51CA9D.2090404@codigosur.org>
	<201203031932.15663.lindner_marek@yahoo.de>
	<4F52D3B6.5060402@codigosur.org>
In-Reply-To: <4F52D3B6.5060402@codigosur.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RQyUPM250EZn+Ac"
Message-Id: <201203041613.05681.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
	+ ethernet
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

--Boundary-00=_RQyUPM250EZn+Ac
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday, March 04, 2012 10:30:14 Nicol=E1s Ech=E1niz wrote:
> When marisa-mr_wlan0 is disabled, pings loose 0% end-to-end even with
> big packets an 0.1s interval and transfer speed is quite good, around
> 5Mbit/s end to end and 30Mbit/s on the best links.
>=20
>=20
> One other thing that took some time to learn (the hard way) is that the
> network won't fully recover when we revert the changes in marisa-mr.
> Loops are gone and pings are normal, but transfer speed sucks.
> All related nodes (marisa-mr, marisa-blt, cisterna and czuk) need to be
> restarted for the transfer speed to get back to normal. We assumed this
> is some kind of problem with the wireles modules, ath9k and ath9k_htc
> that we use, but it's just an assumption.
>=20
>=20
>=20
> Let me know if you find anything unusual in the setup I sent you.

The setup looks good as far as I can tell. I backported 2 patches for 2011.=
4.0=20
that we currently have in the pipeline. They are meant to address temporary=
=20
routing loops. Somewhat similar to what you are experiencing but I am not 1=
00%=20
sure it will help in your case. Could you please apply these patches to=20
batman-adv and install the patched binary on all nodes ? It is essential th=
at=20
all the nodes run the same version to avoid odd routing behavior.

Let us know how it goes!

Cheers,
Marek

--Boundary-00=_RQyUPM250EZn+Ac
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-batman-adv-refactor-is_single_hop_neigh-to-increase-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-batman-adv-refactor-is_single_hop_neigh-to-increase-.patch"

=46rom 8469a72e3609ad06f0f1dc11e1793ba90f25ddb1 Mon Sep 17 00:00:00 2001
=46rom: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Jan 2012 21:20:32 +0800
Subject: [PATCH 1/2] batman-adv: refactor is_single_hop_neigh to increase
 readability

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
=2D--
 bat_iv_ogm.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 3512e25..52eb052 100644
=2D-- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -464,7 +464,8 @@ static void bat_ogm_queue_add(struct bat_priv *bat_priv,
 static void bat_ogm_forward(struct orig_node *orig_node,
 			    const struct ethhdr *ethhdr,
 			    struct batman_ogm_packet *batman_ogm_packet,
=2D			    int directlink, struct hard_iface *if_incoming)
+			    bool is_single_hop_neigh,
+			    struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *router;
@@ -517,7 +518,7 @@ static void bat_ogm_forward(struct orig_node *orig_node,
=20
 	/* switch of primaries first hop flag when forwarding */
 	batman_ogm_packet->flags &=3D ~PRIMARIES_FIRST_HOP;
=2D	if (directlink)
+	if (is_single_hop_neigh)
 		batman_ogm_packet->flags |=3D DIRECTLINK;
 	else
 		batman_ogm_packet->flags &=3D ~DIRECTLINK;
@@ -902,7 +903,8 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 	struct neigh_node *orig_neigh_router =3D NULL;
 	int has_directlink_flag;
 	int is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;
=2D	int is_broadcast =3D 0, is_bidirectional, is_single_hop_neigh;
+	int is_broadcast =3D 0, is_bidirectional;
+	bool is_single_hop_neigh =3D false;
 	int is_duplicate;
 	uint32_t if_incoming_seqno;
=20
@@ -926,8 +928,8 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
=20
 	has_directlink_flag =3D (batman_ogm_packet->flags & DIRECTLINK ? 1 : 0);
=20
=2D	is_single_hop_neigh =3D (compare_eth(ethhdr->h_source,
=2D					   batman_ogm_packet->orig) ? 1 : 0);
+	if (compare_eth(ethhdr->h_source, batman_ogm_packet->orig))
+		is_single_hop_neigh =3D true;
=20
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
@@ -1101,7 +1103,7 @@ static void bat_ogm_process(const struct ethhdr *ethh=
dr,
=20
 		/* mark direct link on incoming interface */
 		bat_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
=2D				1, if_incoming);
+				is_single_hop_neigh, if_incoming);
=20
 		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
 			"rebroadcast neighbor packet with direct link flag\n");
@@ -1123,7 +1125,8 @@ static void bat_ogm_process(const struct ethhdr *ethh=
dr,
=20
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
=2D	bat_ogm_forward(orig_node, ethhdr, batman_ogm_packet, 0, if_incoming);
+	bat_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
+			is_single_hop_neigh, if_incoming);
=20
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
=2D-=20
1.7.9


--Boundary-00=_RQyUPM250EZn+Ac
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-batman-adv-avoid-temporary-routing-loops-by-being-st.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-batman-adv-avoid-temporary-routing-loops-by-being-st.patch"

=46rom 4c01bde01c9977bdcf06cf4cdb16805c28f5e634 Mon Sep 17 00:00:00 2001
=46rom: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Jan 2012 21:45:45 +0800
Subject: [PATCH 2/2] batman-adv: avoid temporary routing loops by being
 strict on forwarded OGMs

batman-adv would forward OGMs from non-besthops while replacing the the TQ
and TTL values with the values from the best hop. In certain corner cases
this leads to a temporary routing loop.
This patch changes this behavior: Only packets from best next hops are
forwarded - TQ and TTL values won't be replaced anymore. However, the proto=
col
needs to rebroadcast OGMs from single hop neighbors regardless of whether or
not they are the best hop. To handle this case a new flag is introduced to
alert neighboring nodes about the forwarded OGM that is not from my best
next hop. It is to be discarded by all nodes except for the one originating
the OGM.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
=2D--
 bat_iv_ogm.c |   61 ++++++++++++++++++++++++++++++------------------------=
=2D--
 packet.h     |    1 +
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 52eb052..a0aa3b3 100644
=2D-- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -465,11 +465,10 @@ static void bat_ogm_forward(struct orig_node *orig_no=
de,
 			    const struct ethhdr *ethhdr,
 			    struct batman_ogm_packet *batman_ogm_packet,
 			    bool is_single_hop_neigh,
+			    bool is_from_best_next_hop,
 			    struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
=2D	struct neigh_node *router;
=2D	uint8_t in_tq, in_ttl, tq_avg =3D 0;
 	uint8_t tt_num_changes;
=20
 	if (batman_ogm_packet->ttl <=3D 1) {
@@ -477,41 +476,31 @@ static void bat_ogm_forward(struct orig_node *orig_no=
de,
 		return;
 	}
=20
=2D	router =3D orig_node_get_router(orig_node);
+	if (!is_from_best_next_hop) {
+		/**
+		* Mark the forwarded packet when it is not coming from our best
+		* next hop. We still need to forward the packet for our neighbor
+		* link quality detection to work in case the packet originated
+		* from a single hop neighbor. Otherwise we can simply drop the
+		* ogm.
+		*/
+		if (is_single_hop_neigh)
+			batman_ogm_packet->flags |=3D NOT_BEST_NEXT_HOP;
+		else
+			return;
+	}
=20
=2D	in_tq =3D batman_ogm_packet->tq;
=2D	in_ttl =3D batman_ogm_packet->ttl;
 	tt_num_changes =3D batman_ogm_packet->tt_num_changes;
=20
 	batman_ogm_packet->ttl--;
 	memcpy(batman_ogm_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
=20
=2D	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
=2D	 * of our best tq value */
=2D	if (router && router->tq_avg !=3D 0) {
=2D
=2D		/* rebroadcast ogm of best ranking neighbor as is */
=2D		if (!compare_eth(router->addr, ethhdr->h_source)) {
=2D			batman_ogm_packet->tq =3D router->tq_avg;
=2D
=2D			if (router->last_ttl)
=2D				batman_ogm_packet->ttl =3D router->last_ttl - 1;
=2D		}
=2D
=2D		tq_avg =3D router->tq_avg;
=2D	}
=2D
=2D	if (router)
=2D		neigh_node_free_ref(router);
=2D
 	/* apply hop penalty */
 	batman_ogm_packet->tq =3D hop_penalty(batman_ogm_packet->tq, bat_priv);
=20
 	bat_dbg(DBG_BATMAN, bat_priv,
=2D		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
=2D		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
=2D		in_tq, tq_avg, batman_ogm_packet->tq, in_ttl - 1,
=2D		batman_ogm_packet->ttl);
+		"Forwarding packet: tq: %i, ttl: %i\n",
+		batman_ogm_packet->tq, batman_ogm_packet->ttl);
=20
 	batman_ogm_packet->seqno =3D htonl(batman_ogm_packet->seqno);
 	batman_ogm_packet->tt_crc =3D htons(batman_ogm_packet->tt_crc);
@@ -905,6 +894,7 @@ static void bat_ogm_process(const struct ethhdr *ethhdr,
 	int is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;
 	int is_broadcast =3D 0, is_bidirectional;
 	bool is_single_hop_neigh =3D false;
+	bool is_from_best_next_hop =3D false;
 	int is_duplicate;
 	uint32_t if_incoming_seqno;
=20
@@ -1029,6 +1019,13 @@ static void bat_ogm_process(const struct ethhdr *eth=
hdr,
 		return;
 	}
=20
+	if (batman_ogm_packet->flags & NOT_BEST_NEXT_HOP) {
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Drop packet: ignoring all packets not forwarded from "
+			"the best next hop (sender: %pM)\n", ethhdr->h_source);
+		return;
+	}
+
 	orig_node =3D get_orig_node(bat_priv, batman_ogm_packet->orig);
 	if (!orig_node)
 		return;
@@ -1053,6 +1050,10 @@ static void bat_ogm_process(const struct ethhdr *eth=
hdr,
 	if (router)
 		router_router =3D orig_node_get_router(router->orig_node);
=20
+	if ((router && router->tq_avg !=3D 0) &&
+	    (compare_eth(router->addr, ethhdr->h_source)))
+		is_from_best_next_hop =3D true;
+
 	/* avoid temporary routing loops */
 	if (router && router_router &&
 	    (compare_eth(router->addr, batman_ogm_packet->prev_sender)) &&
@@ -1103,7 +1104,8 @@ static void bat_ogm_process(const struct ethhdr *ethh=
dr,
=20
 		/* mark direct link on incoming interface */
 		bat_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
=2D				is_single_hop_neigh, if_incoming);
+				is_single_hop_neigh, is_from_best_next_hop,
+				if_incoming);
=20
 		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
 			"rebroadcast neighbor packet with direct link flag\n");
@@ -1126,7 +1128,8 @@ static void bat_ogm_process(const struct ethhdr *ethh=
dr,
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
 	bat_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
=2D			is_single_hop_neigh, if_incoming);
+			is_single_hop_neigh, is_from_best_next_hop,
+			if_incoming);
=20
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
diff --git a/packet.h b/packet.h
index 4d9e54c..667ed75 100644
=2D-- a/packet.h
+++ b/packet.h
@@ -39,6 +39,7 @@ enum bat_packettype {
 #define COMPAT_VERSION 14
=20
 enum batman_flags {
+	NOT_BEST_NEXT_HOP   =3D 1 << 3,
 	PRIMARIES_FIRST_HOP =3D 1 << 4,
 	VIS_SERVER	    =3D 1 << 5,
 	DIRECTLINK	    =3D 1 << 6
=2D-=20
1.7.9


--Boundary-00=_RQyUPM250EZn+Ac--
