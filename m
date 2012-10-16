Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Oct 2012 08:16:10 +0200
Message-Id: <1350368170-9571-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix kernel-doc for
	batadv_dat_entry
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

In the batadv_dat_entry structure last_update was lonely and was missing its own
kernel-doc. This patch adds it.

This was introduced with ("batman-adv: Distributed ARP Table - implement local
storage")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/types.h b/types.h
index 9a4de5d..a5a838c 100644
--- a/types.h
+++ b/types.h
@@ -484,6 +484,7 @@ struct batadv_algo_ops {
  * is used to stored ARP entries needed for the global DAT cache
  * @ip: the IPv4 corresponding to this DAT/ARP entry
  * @mac_addr: the MAC address associated to the stored IPv4
+ * @last_update: time in jiffies when this entry was refreshed last time
  * @hash_entry: hlist node for batadv_priv_dat::hash
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
-- 
1.7.12.3

