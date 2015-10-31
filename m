Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2015 13:03:22 +0100
Message-ID: <4759436.052WzdkNzK@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3453667.cQFfaUo3dp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Missing patches in net-next
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

--nextPart3453667.cQFfaUo3dp
Content-Type: multipart/mixed; boundary="nextPart65742485.gvcUmVIpm8"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart65742485.gvcUmVIpm8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

there are some patches waiting in batman-adv's next branch which are currently 
missing in davem's net-next. The diff from the daily build_test is stable 
since 1 1/2 months [1]:

     net/batman-adv/bridge_loop_avoidance.c |   35 +++---------------------
     net/batman-adv/routing.c               |   19 ++-----------
     net/batman-adv/translation-table.c     |   24 ++--------------
     net/batman-adv/types.h                 |    2 -
     4 files changed, 12 insertions(+), 68 deletions(-)

The patches which are currently missing in net-next are:

2decb5f1fef1484f1b7319aaf2f36b5492d8d943
4a73d7438dfb60c7ac82758875292bc14f363b45
2dd1d9f06ac1208b1921aa90d479c3940bc70b4f
b307e72d119f0ca5cf3c00d05d62320975261ef4

All of them are from maint and thus have conflicts with patches that are 
already in net-next. The rebased/squashed patches can be found in the 
attachments.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/linux-merge/2015-September/002582.html

=2D-nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0001-batman-adv-detect-local-excess-vlans-in-TT-request.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-detect-local-excess-vlans-in-TT-request.patch"

From=20cf709aace56d480affa9a39ad62d1d9d8ab73cd6 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 2 Sep 2015 20:09:56 +0200
Subject: [PATCH 1/4] batman-adv: detect local excess vlans in TT request

If the local representation of the global TT table of one originator has
more VLAN entries than the respective TT update, there is some
inconsistency present. By detecting and reporting this inconsistency,
the global table gets updated and the excess VLAN will get removed in
the process.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
=2D--
 net/batman-adv/translation-table.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4228b10..17822de 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2411,8 +2411,8 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
+	int i, orig_num_vlan;
 	u32 crc;
=2D	int i;
 
 	/* check if each received CRC matches the locally stored one */
 	for (i = 0; i < num_vlan; i++) {
@@ -2438,6 +2438,18 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 	}
 
+	/* check if any excess VLANs exist locally for the originator
+	 * which are not mentioned in the TVLV from the originator.
+	 */
+	rcu_read_lock();
+	orig_num_vlan = 0;
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list)
+		orig_num_vlan++;
+	rcu_read_unlock();
+
+	if (orig_num_vlan > num_vlan)
+		return false;
+
 	return true;
 }
 
=2D- 
2.6.2


=2D-nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0002-batman-adv-lock-crc-access-in-bridge-loop-avoidance.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-batman-adv-lock-crc-access-in-bridge-loop-avoidance.patch"

From=20651d2570b73d1e93a02467a457a6776089efb08b Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Sep 2015 18:04:13 +0200
Subject: [PATCH 2/4] batman-adv: lock crc access in bridge loop avoidance

We have found some networks in which nodes were constantly requesting
other nodes BLA claim tables to synchronize, just to ask for that again
once completed. The reason was that the crc checksum of the asked nodes
were out of sync due to missing locking and multiple writes to the same
crc checksum when adding/removing entries. Therefore the asked nodes
constantly reported the wrong crc, which caused repeating requests.

To avoid multiple functions changing a backbone gateways crc entry at
the same time, lock it using a spinlock.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Tested-by: Alfons Name <AlfonsName@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
=2D--
 net/batman-adv/bridge_loop_avoidance.c | 35 +++++++++++++++++++++++++++++-----
 net/batman-adv/types.h                 |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 191a702..99dcae3 100644
=2D-- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -260,7 +260,9 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 	}
 
 	/* all claims gone, initialize CRC */
+	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc = BATADV_BLA_CRC_INIT;
+	spin_unlock_bh(&backbone_gw->crc_lock);
 }
 
 /**
@@ -408,6 +410,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	entry->lasttime = jiffies;
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
+	spin_lock_init(&entry->crc_lock);
 	atomic_set(&entry->request_sent, 0);
 	atomic_set(&entry->wait_periods, 0);
 	ether_addr_copy(entry->orig, orig);
@@ -557,7 +560,9 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 	__be16 crc;
 
 	memcpy(mac, batadv_announce_mac, 4);
+	spin_lock_bh(&backbone_gw->crc_lock);
 	crc = htons(backbone_gw->crc);
+	spin_unlock_bh(&backbone_gw->crc_lock);
 	memcpy(&mac[4], &crc, 2);
 
 	batadv_bla_send_claim(bat_priv, mac, backbone_gw->vid,
@@ -618,14 +623,18 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
 			   mac, BATADV_PRINT_VID(vid));
 
+		spin_lock_bh(&claim->backbone_gw->crc_lock);
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		spin_unlock_bh(&claim->backbone_gw->crc_lock);
 		batadv_backbone_gw_free_ref(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
 	atomic_inc(&backbone_gw->refcount);
 	claim->backbone_gw = backbone_gw;
 
+	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&backbone_gw->crc_lock);
 	backbone_gw->lasttime = jiffies;
 
 claim_free_ref:
@@ -653,7 +662,9 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 			   batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
+	spin_lock_bh(&claim->backbone_gw->crc_lock);
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&claim->backbone_gw->crc_lock);
 
 	/* don't need the reference from hash_find() anymore */
 	batadv_claim_free_ref(claim);
@@ -664,7 +675,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 				  u8 *backbone_addr, unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
=2D	u16 crc;
+	u16 backbone_crc, crc;
 
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
 		return 0;
@@ -683,12 +694,16 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		   "handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
 		   BATADV_PRINT_VID(vid), backbone_gw->orig, crc);
 
=2D	if (backbone_gw->crc != crc) {
+	spin_lock_bh(&backbone_gw->crc_lock);
+	backbone_crc = backbone_gw->crc;
+	spin_unlock_bh(&backbone_gw->crc_lock);
+
+	if (backbone_crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "handle_announce(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
 			   backbone_gw->orig,
 			   BATADV_PRINT_VID(backbone_gw->vid),
=2D			   backbone_gw->crc, crc);
+			   backbone_crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
 	} else {
@@ -1647,6 +1662,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
+	u16 backbone_crc;
 	u32 i;
 	bool is_own;
 	u8 *primary_addr;
@@ -1669,11 +1685,15 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
 			is_own = batadv_compare_eth(claim->backbone_gw->orig,
 						    primary_addr);
+
+			spin_lock_bh(&claim->backbone_gw->crc_lock);
+			backbone_crc = claim->backbone_gw->crc;
+			spin_unlock_bh(&claim->backbone_gw->crc_lock);
 			seq_printf(seq, " * %pM on %5d by %pM [%c] (%#.4x)\n",
 				   claim->addr, BATADV_PRINT_VID(claim->vid),
 				   claim->backbone_gw->orig,
 				   (is_own ? 'x' : ' '),
=2D				   claim->backbone_gw->crc);
+				   backbone_crc);
 		}
 		rcu_read_unlock();
 	}
@@ -1692,6 +1712,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	int secs, msecs;
+	u16 backbone_crc;
 	u32 i;
 	bool is_own;
 	u8 *primary_addr;
@@ -1722,10 +1743,14 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 			if (is_own)
 				continue;
 
+			spin_lock_bh(&backbone_gw->crc_lock);
+			backbone_crc = backbone_gw->crc;
+			spin_unlock_bh(&backbone_gw->crc_lock);
+
 			seq_printf(seq, " * %pM on %5d %4i.%03is (%#.4x)\n",
 				   backbone_gw->orig,
 				   BATADV_PRINT_VID(backbone_gw->vid), secs,
=2D				   msecs, backbone_gw->crc);
+				   msecs, backbone_crc);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d260efd..1170962 100644
=2D-- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -884,6 +884,7 @@ struct batadv_socket_packet {
  *  backbone gateway - no bcast traffic is formwared until the situation was
  *  resolved
  * @crc: crc16 checksum over all claims
+ * @crc_lock: lock protecting crc
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
@@ -897,6 +898,7 @@ struct batadv_bla_backbone_gw {
 	atomic_t wait_periods;
 	atomic_t request_sent;
 	u16 crc;
+	spinlock_t crc_lock; /* protects crc */
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
=2D- 
2.6.2


=2D-nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0003-batman-adv-fix-speedy-join-for-DAT-cache-replies.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-batman-adv-fix-speedy-join-for-DAT-cache-replies.patch"

From=206e1c1c4adc7769bf4b635c4eb93863d354a19030 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 2 Sep 2015 20:09:54 +0200
Subject: [PATCH 3/4] batman-adv: fix speedy join for DAT cache replies

DAT Cache replies are answered on behalf of other clients which are not
connected to the answering originator. Therefore, we shouldn't add these
clients to the answering originators TT table through speed join to
avoid bogus entries.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
=2D--
 net/batman-adv/routing.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 8d990b0..3207667 100644
=2D-- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -836,6 +836,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	u8 *orig_addr;
 	struct batadv_orig_node *orig_node = NULL;
 	int check, hdr_size = sizeof(*unicast_packet);
+	enum batadv_subtype subtype;
 	bool is4addr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
@@ -863,10 +864,20 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		if (is4addr) {
=2D			batadv_dat_inc_counter(bat_priv,
=2D					       unicast_4addr_packet->subtype);
=2D			orig_addr = unicast_4addr_packet->src;
=2D			orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+			subtype = unicast_4addr_packet->subtype;
+			batadv_dat_inc_counter(bat_priv, subtype);
+
+			/* Only payload data should be considered for speedy
+			 * join. For example, DAT also uses unicast 4addr
+			 * types, but those packets should not be considered
+			 * for speedy join, since the clients do not actually
+			 * reside at the sending originator.
+			 */
+			if (subtype == BATADV_P_DATA) {
+				orig_addr = unicast_4addr_packet->src;
+				orig_node = batadv_orig_hash_find(bat_priv,
+								  orig_addr);
+			}
 		}
 
 		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
=2D- 
2.6.2


=2D-nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0004-batman-adv-avoid-keeping-false-temporary-entry.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0004-batman-adv-avoid-keeping-false-temporary-entry.patch"

From=207e7cbace13b8ea095ca9a40a51f0d2c2912592fe Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 2 Sep 2015 20:09:55 +0200
Subject: [PATCH 4/4] batman-adv: avoid keeping false temporary entry

In the case when a temporary entry is added first and a proper tt entry
is added after that, the temporary tt entry is kept in the orig list.
However the temporary flag is removed at this point, and therefore the
purge function can not find this temporary entry anymore.

Therefore, remove the previous temp entry before adding the new proper
one.

This case can happen if a client behind a given originator moves before
the TT announcement is sent out. Other than that, this case can also be
created by bogus or malicious payload frames for VLANs which are not
existent on the sending originator.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
=2D--
 net/batman-adv/translation-table.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 17822de..dc422be 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1427,9 +1427,15 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		}
 
 		/* if the client was temporary added before receiving the first
=2D		 * OGM announcing it, we have to clear the TEMP flag
+		 * OGM announcing it, we have to clear the TEMP flag. Also,
+		 * remove the previous temporary orig node and re-add it
+		 * if required. If the orig entry changed, the new one which
+		 * is a non-temporary entry is preferred.
 		 */
=2D		common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+			batadv_tt_global_del_orig_list(tt_global_entry);
+			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		}
 
 		/* the change can carry possible "attribute" flags like the
 		 * TT_CLIENT_WIFI, therefore they have to be copied in the
=2D- 
2.6.2


=2D-nextPart65742485.gvcUmVIpm8--
This is a multi-part message in MIME format.

--nextPart65742485.gvcUmVIpm8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

there are some patches waiting in batman-adv's next branch which are currently 
missing in davem's net-next. The diff from the daily build_test is stable 
since 1 1/2 months [1]:

     net/batman-adv/bridge_loop_avoidance.c |   35 +++---------------------
     net/batman-adv/routing.c               |   19 ++-----------
     net/batman-adv/translation-table.c     |   24 ++--------------
     net/batman-adv/types.h                 |    2 -
     4 files changed, 12 insertions(+), 68 deletions(-)

The patches which are currently missing in net-next are:

2decb5f1fef1484f1b7319aaf2f36b5492d8d943
4a73d7438dfb60c7ac82758875292bc14f363b45
2dd1d9f06ac1208b1921aa90d479c3940bc70b4f
b307e72d119f0ca5cf3c00d05d62320975261ef4

All of them are from maint and thus have conflicts with patches that are 
already in net-next. The rebased/squashed patches can be found in the 
attachments.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/linux-merge/2015-September/002582.html

--nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0001-batman-adv-detect-local-excess-vlans-in-TT-request.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-detect-local-excess-vlans-in-TT-request.patch"

From cf709aace56d480affa9a39ad62d1d9d8ab73cd6 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 2 Sep 2015 20:09:56 +0200
Subject: [PATCH 1/4] batman-adv: detect local excess vlans in TT request

If the local representation of the global TT table of one originator has
more VLAN entries than the respective TT update, there is some
inconsistency present. By detecting and reporting this inconsistency,
the global table gets updated and the excess VLAN will get removed in
the process.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/translation-table.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4228b10..17822de 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2411,8 +2411,8 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
+	int i, orig_num_vlan;
 	u32 crc;
-	int i;
 
 	/* check if each received CRC matches the locally stored one */
 	for (i = 0; i < num_vlan; i++) {
@@ -2438,6 +2438,18 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 			return false;
 	}
 
+	/* check if any excess VLANs exist locally for the originator
+	 * which are not mentioned in the TVLV from the originator.
+	 */
+	rcu_read_lock();
+	orig_num_vlan = 0;
+	hlist_for_each_entry_rcu(vlan, &orig_node->vlan_list, list)
+		orig_num_vlan++;
+	rcu_read_unlock();
+
+	if (orig_num_vlan > num_vlan)
+		return false;
+
 	return true;
 }
 
-- 
2.6.2


--nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0002-batman-adv-lock-crc-access-in-bridge-loop-avoidance.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-batman-adv-lock-crc-access-in-bridge-loop-avoidance.patch"

From 651d2570b73d1e93a02467a457a6776089efb08b Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Sep 2015 18:04:13 +0200
Subject: [PATCH 2/4] batman-adv: lock crc access in bridge loop avoidance

We have found some networks in which nodes were constantly requesting
other nodes BLA claim tables to synchronize, just to ask for that again
once completed. The reason was that the crc checksum of the asked nodes
were out of sync due to missing locking and multiple writes to the same
crc checksum when adding/removing entries. Therefore the asked nodes
constantly reported the wrong crc, which caused repeating requests.

To avoid multiple functions changing a backbone gateways crc entry at
the same time, lock it using a spinlock.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Tested-by: Alfons Name <AlfonsName@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bridge_loop_avoidance.c | 35 +++++++++++++++++++++++++++++-----
 net/batman-adv/types.h                 |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 191a702..99dcae3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -260,7 +260,9 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 	}
 
 	/* all claims gone, initialize CRC */
+	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc = BATADV_BLA_CRC_INIT;
+	spin_unlock_bh(&backbone_gw->crc_lock);
 }
 
 /**
@@ -408,6 +410,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	entry->lasttime = jiffies;
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
+	spin_lock_init(&entry->crc_lock);
 	atomic_set(&entry->request_sent, 0);
 	atomic_set(&entry->wait_periods, 0);
 	ether_addr_copy(entry->orig, orig);
@@ -557,7 +560,9 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 	__be16 crc;
 
 	memcpy(mac, batadv_announce_mac, 4);
+	spin_lock_bh(&backbone_gw->crc_lock);
 	crc = htons(backbone_gw->crc);
+	spin_unlock_bh(&backbone_gw->crc_lock);
 	memcpy(&mac[4], &crc, 2);
 
 	batadv_bla_send_claim(bat_priv, mac, backbone_gw->vid,
@@ -618,14 +623,18 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): changing ownership for %pM, vid %d\n",
 			   mac, BATADV_PRINT_VID(vid));
 
+		spin_lock_bh(&claim->backbone_gw->crc_lock);
 		claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		spin_unlock_bh(&claim->backbone_gw->crc_lock);
 		batadv_backbone_gw_free_ref(claim->backbone_gw);
 	}
 	/* set (new) backbone gw */
 	atomic_inc(&backbone_gw->refcount);
 	claim->backbone_gw = backbone_gw;
 
+	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&backbone_gw->crc_lock);
 	backbone_gw->lasttime = jiffies;
 
 claim_free_ref:
@@ -653,7 +662,9 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 			   batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
+	spin_lock_bh(&claim->backbone_gw->crc_lock);
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+	spin_unlock_bh(&claim->backbone_gw->crc_lock);
 
 	/* don't need the reference from hash_find() anymore */
 	batadv_claim_free_ref(claim);
@@ -664,7 +675,7 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 				  u8 *backbone_addr, unsigned short vid)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
-	u16 crc;
+	u16 backbone_crc, crc;
 
 	if (memcmp(an_addr, batadv_announce_mac, 4) != 0)
 		return 0;
@@ -683,12 +694,16 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		   "handle_announce(): ANNOUNCE vid %d (sent by %pM)... CRC = %#.4x\n",
 		   BATADV_PRINT_VID(vid), backbone_gw->orig, crc);
 
-	if (backbone_gw->crc != crc) {
+	spin_lock_bh(&backbone_gw->crc_lock);
+	backbone_crc = backbone_gw->crc;
+	spin_unlock_bh(&backbone_gw->crc_lock);
+
+	if (backbone_crc != crc) {
 		batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
 			   "handle_announce(): CRC FAILED for %pM/%d (my = %#.4x, sent = %#.4x)\n",
 			   backbone_gw->orig,
 			   BATADV_PRINT_VID(backbone_gw->vid),
-			   backbone_gw->crc, crc);
+			   backbone_crc, crc);
 
 		batadv_bla_send_request(backbone_gw);
 	} else {
@@ -1647,6 +1662,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
+	u16 backbone_crc;
 	u32 i;
 	bool is_own;
 	u8 *primary_addr;
@@ -1669,11 +1685,15 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
 			is_own = batadv_compare_eth(claim->backbone_gw->orig,
 						    primary_addr);
+
+			spin_lock_bh(&claim->backbone_gw->crc_lock);
+			backbone_crc = claim->backbone_gw->crc;
+			spin_unlock_bh(&claim->backbone_gw->crc_lock);
 			seq_printf(seq, " * %pM on %5d by %pM [%c] (%#.4x)\n",
 				   claim->addr, BATADV_PRINT_VID(claim->vid),
 				   claim->backbone_gw->orig,
 				   (is_own ? 'x' : ' '),
-				   claim->backbone_gw->crc);
+				   backbone_crc);
 		}
 		rcu_read_unlock();
 	}
@@ -1692,6 +1712,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	int secs, msecs;
+	u16 backbone_crc;
 	u32 i;
 	bool is_own;
 	u8 *primary_addr;
@@ -1722,10 +1743,14 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 			if (is_own)
 				continue;
 
+			spin_lock_bh(&backbone_gw->crc_lock);
+			backbone_crc = backbone_gw->crc;
+			spin_unlock_bh(&backbone_gw->crc_lock);
+
 			seq_printf(seq, " * %pM on %5d %4i.%03is (%#.4x)\n",
 				   backbone_gw->orig,
 				   BATADV_PRINT_VID(backbone_gw->vid), secs,
-				   msecs, backbone_gw->crc);
+				   msecs, backbone_crc);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d260efd..1170962 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -884,6 +884,7 @@ struct batadv_socket_packet {
  *  backbone gateway - no bcast traffic is formwared until the situation was
  *  resolved
  * @crc: crc16 checksum over all claims
+ * @crc_lock: lock protecting crc
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
@@ -897,6 +898,7 @@ struct batadv_bla_backbone_gw {
 	atomic_t wait_periods;
 	atomic_t request_sent;
 	u16 crc;
+	spinlock_t crc_lock; /* protects crc */
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
-- 
2.6.2


--nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0003-batman-adv-fix-speedy-join-for-DAT-cache-replies.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-batman-adv-fix-speedy-join-for-DAT-cache-replies.patch"

From 6e1c1c4adc7769bf4b635c4eb93863d354a19030 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 2 Sep 2015 20:09:54 +0200
Subject: [PATCH 3/4] batman-adv: fix speedy join for DAT cache replies

DAT Cache replies are answered on behalf of other clients which are not
connected to the answering originator. Therefore, we shouldn't add these
clients to the answering originators TT table through speed join to
avoid bogus entries.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/routing.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 8d990b0..3207667 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -836,6 +836,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	u8 *orig_addr;
 	struct batadv_orig_node *orig_node = NULL;
 	int check, hdr_size = sizeof(*unicast_packet);
+	enum batadv_subtype subtype;
 	bool is4addr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
@@ -863,10 +864,20 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		if (is4addr) {
-			batadv_dat_inc_counter(bat_priv,
-					       unicast_4addr_packet->subtype);
-			orig_addr = unicast_4addr_packet->src;
-			orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+			subtype = unicast_4addr_packet->subtype;
+			batadv_dat_inc_counter(bat_priv, subtype);
+
+			/* Only payload data should be considered for speedy
+			 * join. For example, DAT also uses unicast 4addr
+			 * types, but those packets should not be considered
+			 * for speedy join, since the clients do not actually
+			 * reside at the sending originator.
+			 */
+			if (subtype == BATADV_P_DATA) {
+				orig_addr = unicast_4addr_packet->src;
+				orig_node = batadv_orig_hash_find(bat_priv,
+								  orig_addr);
+			}
 		}
 
 		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
-- 
2.6.2


--nextPart65742485.gvcUmVIpm8
Content-Disposition: attachment; filename="0004-batman-adv-avoid-keeping-false-temporary-entry.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0004-batman-adv-avoid-keeping-false-temporary-entry.patch"

From 7e7cbace13b8ea095ca9a40a51f0d2c2912592fe Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 2 Sep 2015 20:09:55 +0200
Subject: [PATCH 4/4] batman-adv: avoid keeping false temporary entry

In the case when a temporary entry is added first and a proper tt entry
is added after that, the temporary tt entry is kept in the orig list.
However the temporary flag is removed at this point, and therefore the
purge function can not find this temporary entry anymore.

Therefore, remove the previous temp entry before adding the new proper
one.

This case can happen if a client behind a given originator moves before
the TT announcement is sent out. Other than that, this case can also be
created by bogus or malicious payload frames for VLANs which are not
existent on the sending originator.

Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/translation-table.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 17822de..dc422be 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1427,9 +1427,15 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		}
 
 		/* if the client was temporary added before receiving the first
-		 * OGM announcing it, we have to clear the TEMP flag
+		 * OGM announcing it, we have to clear the TEMP flag. Also,
+		 * remove the previous temporary orig node and re-add it
+		 * if required. If the orig entry changed, the new one which
+		 * is a non-temporary entry is preferred.
 		 */
-		common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+			batadv_tt_global_del_orig_list(tt_global_entry);
+			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		}
 
 		/* the change can carry possible "attribute" flags like the
 		 * TT_CLIENT_WIFI, therefore they have to be copied in the
-- 
2.6.2


--nextPart65742485.gvcUmVIpm8--

--nextPart3453667.cQFfaUo3dp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWNK4KAAoJEF2HCgfBJntGGcIQAMN+KjgpNYEp9HgysDpfKOQQ
khB7jx4NCa9F048o3t/lJtJPu0/jPzWabv2U3rxiO6DZuI1EPgZJhKs923EKvVKL
VjBbu/P0vXdGdHFXbzUV7ckhdEiEbjQtjFsK4OO2Y5Rh4+PIceDDSgLNlS1z3OHk
U70GvtDRk/cIapwcK2l7hQCkk46A0t+ivsb7SLvdKx6mylXXNHfNXNjBRqz95Oj6
2BZOX1O/Z0Jcw3CdrhjBzKCusT8MiRIEBC3o6pdG6gZmV+BK6brGNSqK/GEmsRYt
E1JdH22LHSka5acQdgkmMSRYXfigVuO50q9IxBBhYdCx+jb4UdfrVJrp3AHqB43+
8BteaKLPvmFC8azpg0DuRMK47KnOs792wlBIn1UxDZHnOi5OiQ8RCah8Mj6v6olm
VWm0rO35NpH304QOaJo2N7XdJilYVrmIVMmZZHG+6sVnwFoRaWoWUW88QVFieyPg
b8ybuUUcLqfjY6DNAWiM87f98wIbA6MyyIDB/rvTnKkfelASKdtP5tHyDY9/cr47
l7p9cVF4VOcCXRUyI7JyUiuP0oZi0aL87iTfe2BzV3IQ1ANW92E/vRHiDWHak9fY
Vz1NEUvN3cDkJCmbyQYPYYTZmWLJNFZE8rYyJokrRo0k1CzQXpWPiV2T2eUa8KAy
Rc/LqE6OtGTaxdXF3xPV
=h16K
-----END PGP SIGNATURE-----

--nextPart3453667.cQFfaUo3dp--

