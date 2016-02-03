Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  3 Feb 2016 10:18:33 +0800
Message-Id: <1454465917-13332-13-git-send-email-a@unstable.cc>
In-Reply-To: <1454465917-13332-1-git-send-email-a@unstable.cc>
References: <1454465917-13332-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 12/16] batman-adv: add kernel doc for AP
	isolation attributes in bat_priv
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7f7a0f1eaf75..5e8c8df4c4ac 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -772,6 +772,9 @@ struct batadv_softif_vlan {
  * @orig_interval: OGM broadcast interval in milliseconds
  * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
  * @log_level: configured log level (see batadv_dbg_level)
+ * @isolation_mark: the skb->mark value used to match packets for AP isolation
+ * @isolation_mark_mask: bitmask identifying the bits in skb->mark to be used
+ *  for the isolation mark
  * @bcast_seqno: last sent broadcast packet sequence number
  * @bcast_queue_left: number of remaining buffered broadcast packet slots
  * @batman_queue_left: number of remaining OGM packet slots
-- 
2.7.0

