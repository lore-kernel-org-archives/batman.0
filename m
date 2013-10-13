Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 02:50:19 +0200
Message-Id: <1381625420-4062-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: improve the TT component
	to support runtime flag changes
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Some flags (i.e. the WIFI flag) may change after that the
related client has already been announced. However it is
useful to informa the rest of the network about this change.

Add a runtime-flag-switch detection mechanism and
re-announce the related TT entry to advertise the new flag
value.

This mechanism can be easily exploited by future flags that
may need the same treatment.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h            |  6 ++++++
 translation-table.c | 25 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index f4bbb05..bf4c91f 100644
--- a/packet.h
+++ b/packet.h
@@ -123,6 +123,12 @@ enum batadv_tt_client_flags {
 };
 
 /**
+ * BATADV_TT_REMOTE_MASK - bitmask selecting the flags that are sent over the
+ *  wire only
+ */
+#define BATADV_TT_REMOTE_MASK	0x00FF
+
+/**
  * batadv_vlan_flags - flags for the four MSB of any vlan ID field
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
diff --git a/translation-table.c b/translation-table.c
index a0f31cf..4212e9a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -358,6 +358,13 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 			goto del;
 		if (del_op_requested && !del_op_entry)
 			goto del;
+
+		/* this is a second add in the same originator interval. It
+		 * means that flags have been changed: update them!
+		 */
+		if (!del_op_requested && !del_op_entry)
+			entry->change.flags = flags;
+
 		continue;
 del:
 		list_del(&entry->list);
@@ -482,6 +489,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
 	bool ret = false, roamed_back = false;
+	uint8_t remote_flags;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
 		in_dev = dev_get_by_index(&init_net, ifindex);
@@ -596,8 +604,23 @@ check_roaming:
 		}
 	}
 
-	ret = true;
+	/* store the current remote flags before altering them. This helps
+	 * understanding is flags are changing or not
+	 */
+	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
+
+	if (batadv_is_wifi_netdev(in_dev))
+		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+	else
+		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
 
+	/* if any "dynamic" flag has been modified, resend an ADD event for this
+	 * entry so that all the nodes can get the new flags
+	 */
+	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+
+	ret = true;
 out:
 	if (in_dev)
 		dev_put(in_dev);
-- 
1.8.3.2

