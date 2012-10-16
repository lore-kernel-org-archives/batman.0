Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Oct 2012 08:12:33 +0200
Message-Id: <1350367953-3503-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix ifdef for DAT in types.h
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

It is better to fully enclose the batadv_priv_dat struct in the #ifdef/endif
block instead of the enclosing only the field which would not compile while DAT
is off.

This was introduced with ("batman-adv: Distributed ARP Table - add compile
option")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/types.h b/types.h
index b1c261b..9a4de5d 100644
--- a/types.h
+++ b/types.h
@@ -249,6 +249,7 @@ struct batadv_priv_vis {
 	struct batadv_vis_info *my_info;
 };
 
+#ifdef CONFIG_BATMAN_ADV_DAT
 /**
  * struct batadv_priv_dat - per mesh interface DAT private data
  * @addr: node DAT address
@@ -256,12 +257,11 @@ struct batadv_priv_vis {
  * @work: work queue callback item for cache purging
  */
 struct batadv_priv_dat {
-#ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t addr;
-#endif
 	struct batadv_hashtable *hash;
 	struct delayed_work work;
 };
+#endif
 
 struct batadv_priv {
 	atomic_t mesh_state;
-- 
1.7.12.3

