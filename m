Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 16 Mar 2012 15:58:20 +0100
Message-Id: <1331909900-25173-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: improve unicast packet
	(re)routing
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

In case of a client X roaming from a generic node A to another node B, it is
possible that a third node C gets A's OGM but not B's. At this point in time, if
C wants to send data to X it will send a unicast packet destined to A. The
packet header will contain A's last ttvn (C got A's OGM and so it knows it).

The packet will travel towards A without being intercepted because the ttvn
contained in its header is the newest for A.

Once A will receive the packet, A's state will not report to be in a "roaming
phase" (because, after a roaming, once A sends out its OGM, all the changes are
committed and the node is considered not to be in the roaming state anymore)
and it will match the ttvn carried by the packet. Therefore there is no reason
for A to try to alter the packet's route, thus dropping the packet because the
destination client is not there anymore.

However, C is well aware that it's routing information towards the client X is
outdated as it received an OGM from A saying that the client roamed away.
Thanks to this detail, this patch introduces a small change in behaviour: as
long as C is in the state of not knowing the new location of client X it will
forward the traffic to its last known location using ttvn-1 of the destination.
By using an older ttvn node A will be forced to re-route the packet.
Intermediate nodes are also allowed to update the packet's destination as long
as they have the information about the client's new location.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c           |    6 ++++++
 translation-table.c |   18 ++++++++++++++++++
 translation-table.h |    2 ++
 unicast.c           |    8 ++++++++
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/routing.c b/routing.c
index 576ffb1..0950c53 100644
--- a/routing.c
+++ b/routing.c
@@ -922,6 +922,12 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 		ethhdr = (struct ethhdr *)(skb->data +
 			sizeof(struct unicast_packet));
+
+		/* we don't have an updated route for this client, so we should
+		 * not try to reroute the packet!! */
+		if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+			return 1;
+
 		orig_node = transtable_search(bat_priv, NULL, ethhdr->h_dest);
 
 		if (!orig_node) {
diff --git a/translation-table.c b/translation-table.c
index b4a070f..dccf442 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2113,3 +2113,21 @@ request_table:
 		}
 	}
 }
+
+/* returns true whether we know that the client has moved from its old
+ * originator to another one. This entry is kept is still kept for consistency
+ * purposes */
+bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr)
+{
+	struct tt_global_entry *tt_global_entry =
+		tt_global_hash_find(bat_priv, addr);
+	bool ret = false;
+
+	if (!tt_global_entry)
+		goto out;
+
+	ret = tt_global_entry->common.flags & TT_CLIENT_ROAM;
+	tt_global_entry_free_ref(tt_global_entry);
+out:
+	return ret;
+}
diff --git a/translation-table.h b/translation-table.h
index 593d1b3..c43374d 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -53,5 +53,7 @@ bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
 void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		    const unsigned char *tt_buff, uint8_t tt_num_changes,
 		    uint8_t ttvn, uint16_t tt_crc);
+bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr);
+
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/unicast.c b/unicast.c
index 2d61e54..63ab35b 100644
--- a/unicast.c
+++ b/unicast.c
@@ -392,6 +392,14 @@ find_router:
 	}
 
 	unicast_packet = (struct unicast_packet *)skb->data;
+
+	/* inform the destination ode that we are still missing a correct route
+	 * for this client. The destination will receive this packet and will
+	 * try to reroute it because the ttvn contained in the header is less
+	 * than the current one */
+	if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+		unicast_packet->ttvn = unicast_packet->ttvn - 1;
+
 	/* fragmentation mechanism only works for UNICAST (now) */
 	if (packet_type == BAT_UNICAST &&
 	    atomic_read(&bat_priv->fragmentation) &&
-- 
1.7.3.4

