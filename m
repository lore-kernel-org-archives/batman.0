Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 23 Aug 2016 03:13:16 +0200
Message-Id: <20160823011316.18602-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: fix batadv_forw_packet
	kerneldoc for list attribute
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

The forw_packet list node is wrongly attributed to the icmp socket code.

Reviewed-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Changes in v2:
* "Reviewed-by:" added
* detached from patchset

 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3dd1a3..97336ec 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1363,7 +1363,7 @@ struct batadv_skb_cb {
 
 /**
  * struct batadv_forw_packet - structure for bcast packets to be sent/forwarded
- * @list: list node for batadv_socket_client::queue_list
+ * @list: list node for batadv_priv::forw_{bat,bcast}_list
  * @send_time: execution time for delayed_work (packet sending)
  * @own: bool for locally generated packets (local OGMs are re-scheduled after
  *  sending)
-- 
2.1.4

