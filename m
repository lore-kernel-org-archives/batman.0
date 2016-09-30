Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 15:21:01 +0200
Message-Id: <20160930132106.5798-2-sven.eckelmann@open-mesh.com>
In-Reply-To: <2666783.nl87Kib46y@bentobox>
References: <2666783.nl87Kib46y@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/7] batman-adv: Close two alignment holes
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v2:
 - new patch
---
 net/batman-adv/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3dd1a3..8eef6a3 100644
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
2.9.3

