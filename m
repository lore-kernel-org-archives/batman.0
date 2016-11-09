Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  9 Nov 2016 23:25:52 +0100
Message-Id: <20161109222606.29039-4-sw@simonwunderlich.de>
In-Reply-To: <20161109222606.29039-1-sw@simonwunderlich.de>
References: <20161109222606.29039-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Close two alignment holes
	in batadv_hard_iface
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 673a22e..c9db184 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -123,8 +123,8 @@ struct batadv_hard_iface_bat_v {
  * @list: list node for batadv_hardif_list
  * @if_num: identificator of the interface
  * @if_status: status of the interface for batman-adv
- * @net_dev: pointer to the net_device
  * @num_bcasts: number of payload re-broadcasts on this interface (ARQ)
+ * @net_dev: pointer to the net_device
  * @hardif_obj: kobject of the per interface sysfs "mesh" directory
  * @refcount: number of contexts the object is used
  * @batman_adv_ptype: packet type describing packets that should be processed by
@@ -141,8 +141,8 @@ struct batadv_hard_iface {
 	struct list_head list;
 	s16 if_num;
 	char if_status;
-	struct net_device *net_dev;
 	u8 num_bcasts;
+	struct net_device *net_dev;
 	struct kobject *hardif_obj;
 	struct kref refcount;
 	struct packet_type batman_adv_ptype;
-- 
2.10.1

