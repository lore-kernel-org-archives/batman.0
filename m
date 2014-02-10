Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 10 Feb 2014 13:58:26 +0100
Message-Id: <1392037106-3299-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add kerneldoc for dst_hint
	argument
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Some helper functions used along the TX path have now a new
"dst_hint" argument but the kerneldoc was missing.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 send.c | 2 ++
 send.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/send.c b/send.c
index 31a8c19..63a46c3 100644
--- a/send.c
+++ b/send.c
@@ -311,6 +311,8 @@ out:
  * @packet_type: the batman unicast packet type to use
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
  *  4addr packets)
+ * @dst_hint: destination to send the packet to. If NULL then the addresses
+ *  contained in the Ethernet header are used for the destination lookup
  * @vid: the vid to be used to search the translation table
  *
  * Look up the recipient node for the destination address in the ethernet
diff --git a/send.h b/send.h
index aaddaa9..20e1668 100644
--- a/send.h
+++ b/send.h
@@ -47,6 +47,8 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * batadv_send_skb_via_tt - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
+ * @dst_hint: destination to send the packet to. If NULL then the addresses
+ *  contained in the Ethernet header are used for the destination lookup
  * @vid: the vid to be used to search the translation table
  *
  * Look up the recipient node for the destination address in the ethernet
@@ -68,6 +70,8 @@ static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @packet_subtype: the unicast 4addr packet subtype to use
+ * @dst_hint: destination to send the packet to. If NULL then the addresses
+ *  contained in the Ethernet header are used for the destination lookup
  * @vid: the vid to be used to search the translation table
  *
  * Look up the recipient node for the destination address in the ethernet
-- 
1.8.5.3

