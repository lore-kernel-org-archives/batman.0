Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 17 Apr 2012 12:24:54 +0200
Message-Id: <1334658294-2413-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1334658294-2413-1-git-send-email-ordex@autistici.org>
References: <1334658294-2413-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: use static inline functions
	instead of bla(...)
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

When the DAT component is not built, instead of having fake function like
foo(...) we must use a static inline function in order to allow the compiler to
check the number of the type of the passed arguments

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.h |   51 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 0e93c75..d87f26c 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -88,13 +88,50 @@ static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
 
 #else
 
-#define dat_snoop_outgoing_arp_request(...) (0)
-#define dat_snoop_incoming_arp_request(...) (0)
-#define dat_snoop_outgoing_arp_reply(...)
-#define dat_snoop_incoming_arp_reply(...) (0)
-#define dat_drop_broadcast_packet(...) (0)
-#define dat_init_orig_node_dht_addr(...)
-#define dat_init_own_dht_addr(...)
+static inline void dat_sysfs_change(struct net_device *soft_iface)
+{
+}
+
+static inline bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+						  struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+						  struct sk_buff *skb,
+						  int hdr_size)
+{
+	return false;
+}
+
+static inline bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+						struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+						struct sk_buff *skb,
+						int hdr_size)
+{
+	return false;
+}
+
+static inline bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+					     struct forw_packet *forw_packet)
+{
+	return false;
+}
+
+static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+{
+}
+
+static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
+					 struct hard_iface *primary_if)
+{
+}
 
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
-- 
1.7.9.4

