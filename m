Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Mar 2014 09:56:07 +0100
Message-Id: <1395478576-10999-8-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
References: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 07/16] batman-adv: add kerneldoc for dst_hint
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

Some helper functions used along the TX path have now a new
"dst_hint" argument but the kerneldoc was missing.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/send.c | 1 +
 net/batman-adv/send.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 0e4831f..ce163d5 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -311,6 +311,7 @@ out:
  * @packet_type: the batman unicast packet type to use
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
  *  4addr packets)
+ * @dst_hint: can be used to override the destination contained in the skb
  * @vid: the vid to be used to search the translation table
  *
  * Look up the recipient node for the destination address in the ethernet
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index aaddaa9..31e8781 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -47,6 +47,7 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * batadv_send_skb_via_tt - send an skb via TT lookup
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
+ * @dst_hint: can be used to override the destination contained in the skb
  * @vid: the vid to be used to search the translation table
  *
  * Look up the recipient node for the destination address in the ethernet
@@ -68,6 +69,7 @@ static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @packet_subtype: the unicast 4addr packet subtype to use
+ * @dst_hint: can be used to override the destination contained in the skb
  * @vid: the vid to be used to search the translation table
  *
  * Look up the recipient node for the destination address in the ethernet
-- 
1.8.3.2

