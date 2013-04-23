Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 23:45:26 +0200
Message-Id: <1366753527-17171-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1366753527-17171-1-git-send-email-ordex@autistici.org>
References: <1366753527-17171-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: improve TT component to
	support runtime flag changes
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

The WIFI flag may change (in some rare cases) and get
switched after that the related local entry has been
already advertised.

Add runtime flag switch detection and re-announce the entry
to advertise the new flag values.

By adding this mechanism we allow future flag to be treated
the same way.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h            |  6 ++++++
 translation-table.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/packet.h b/packet.h
index 32ebfbe..02cba21 100644
--- a/packet.h
+++ b/packet.h
@@ -125,6 +125,12 @@ enum batadv_tt_client_flags {
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
index 0543b1a..9dc4207 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -269,6 +269,13 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
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
@@ -350,6 +357,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added;
+	uint8_t remote_flags;
 	bool roamed_back = false;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
@@ -454,6 +462,21 @@ check_roaming:
 		}
 	}
 
+	/* store the current remote flags before altering them. This helps
+	 * understanding is flags are changing or not
+	 */
+	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
+
+	if (batadv_is_wifi_netdev(in_dev))
+		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+	else
+		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
+
+	/* if any "dynamic" flag has been modified, resend an ADD event for this
+	 * entry so that all the nodes can get the new flags
+	 */
+	if (remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK))
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 out:
 	if (in_dev)
 		dev_put(in_dev);
-- 
1.8.1.5

