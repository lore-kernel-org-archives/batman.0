Return-Path: <gregkh@linuxfoundation.org>
Subject: Patch "batman-adv: Fix own OGM check in aggregated OGMs" has been
 added to the 4.9-stable tree
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Nov 2021 13:43:01 +0100
In-Reply-To: <20211120123958.260826-3-sven@narfation.org>
Message-ID: <16376713811943@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, gregkh@linuxfoundation.org, linus.luessing@c0d3.blue, sven@narfation.org, sw@simonwunderlich.de
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    batman-adv: Fix own OGM check in aggregated OGMs

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git=
;a=3Dsummary

The filename of the patch is:
     batman-adv-fix-own-ogm-check-in-aggregated-ogms.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Nov 23 01:37:10 PM CET 2021
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 20 Nov 2021 13:39:53 +0100
Subject: batman-adv: Fix own OGM check in aggregated OGMs
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, "Linus L=FCssing" <linus.luessing@c0d3=
.blue>, "Simon Wunderlich" <sw@simonwunderlich.de>, "Sven Eckelmann" <sven@=
narfation.org>
Message-ID: <20211120123958.260826-3-sven@narfation.org>

From: Linus L=FCssing <linus.luessing@c0d3.blue>

commit d8bf0c01642275c7dca1e5d02c34e4199c200b1f upstream.

The own OGM check is currently misplaced and can lead to the following
issues:

For one thing we might receive an aggregated OGM from a neighbor node
which has our own OGM in the first place. We would then not only skip
our own OGM but erroneously also any other, following OGM in the
aggregate.

For another, we might receive an OGM aggregate which has our own OGM in
a place other then the first one. Then we would wrongly not skip this
OGM, leading to populating the orginator and gateway table with ourself.

Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[ bp: 4.9 backported: adjust context, correct fixes line ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v_ogm.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -690,6 +690,12 @@ static void batadv_v_ogm_process(const s
 		   ntohl(ogm_packet->seqno), ogm_throughput, ogm_packet->ttl,
 		   ogm_packet->version, ntohs(ogm_packet->tvlv_len));
=20
+	if (batadv_is_my_mac(bat_priv, ogm_packet->orig)) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: originator packet from ourself\n");
+		return;
+	}
+
 	/* If the troughput metric is 0, immediately drop the packet. No need to
 	 * create orig_node / neigh_node for an unusable route.
 	 */
@@ -788,11 +794,6 @@ int batadv_v_ogm_packet_recv(struct sk_b
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		return NET_RX_DROP;
=20
-	ogm_packet =3D (struct batadv_ogm2_packet *)skb->data;
-
-	if (batadv_is_my_mac(bat_priv, ogm_packet->orig))
-		return NET_RX_DROP;
-
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_RX_BYTES,
 			   skb->len + ETH_HLEN);


Patches currently in stable-queue which might be from sven@narfation.org are

queue-4.9/batman-adv-consider-fragmentation-for-needed_headroom.patch
queue-4.9/ath9k-fix-potential-interrupt-storm-on-queue-reset.patch
queue-4.9/batman-adv-mcast-fix-duplicate-mcast-packets-from-bla-backbone-to=
-mesh.patch
queue-4.9/ath10k-fix-max-antenna-gain-unit.patch
queue-4.9/batman-adv-mcast-fix-duplicate-mcast-packets-in-bla-backbone-from=
-lan.patch
queue-4.9/batman-adv-reserve-needed_-room-for-fragments.patch
queue-4.9/batman-adv-fix-own-ogm-check-in-aggregated-ogms.patch
queue-4.9/batman-adv-keep-fragments-equally-sized.patch
queue-4.9/batman-adv-don-t-always-reallocate-the-fragmentation-skb-head.pat=
ch
