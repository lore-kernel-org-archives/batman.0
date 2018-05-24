Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:56 +0200
Message-Id: <20180524120300.15829-5-sw@simonwunderlich.de>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: Avoid bool in structures
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Using the bool type for structure member is considered inappropriate [1]
for the kernel. Its size is not well defined (but usually 1 byte but maybe
also 4 byte).

[1] https://lkml.org/lkml/2017/11/21/384

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0174f79e955a..3b3fc146b30d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1160,13 +1160,13 @@ struct batadv_priv_dat {
  */
 struct batadv_mcast_querier_state {
 	/** @exists: whether a querier exists in the mesh */
-	bool exists;
+	unsigned char exists:1;
 
 	/**
 	 * @shadowing: if a querier exists, whether it is potentially shadowing
 	 *  multicast listeners (i.e. querier is behind our own bridge segment)
 	 */
-	bool shadowing;
+	unsigned char shadowing:1;
 };
 
 /**
@@ -1207,10 +1207,10 @@ struct batadv_priv_mcast {
 	u8 flags;
 
 	/** @enabled: whether the multicast tvlv is currently enabled */
-	bool enabled;
+	unsigned char enabled:1;
 
 	/** @bridged: whether the soft interface has a bridge on top */
-	bool bridged;
+	unsigned char bridged:1;
 
 	/**
 	 * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP
@@ -1389,7 +1389,7 @@ struct batadv_tp_vars {
 	atomic_t dup_acks;
 
 	/** @fast_recovery: true if in Fast Recovery mode */
-	bool fast_recovery;
+	unsigned char fast_recovery:1;
 
 	/** @recover: last sent seqno when entering Fast Recovery */
 	u32 recover;
@@ -2046,10 +2046,10 @@ struct batadv_skb_cb {
 	 * @decoded: Marks a skb as decoded, which is checked when searching for
 	 *  coding opportunities in network-coding.c
 	 */
-	bool decoded;
+	unsigned char decoded:1;
 
 	/** @num_bcasts: Counter for broadcast packet retransmissions */
-	unsigned int num_bcasts;
+	unsigned char num_bcasts;
 };
 
 /**
-- 
2.11.0

