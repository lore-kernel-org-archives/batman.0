Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 09:04:03 +0100
Message-Id: <1450598643-7185-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add lockdep assert for
	container_list_lock
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

The batadv_tvlv_container* functions state in their kernel-doc that they
require tvlv.container_list_lock. Add an assert to automatically detect
when this might have been ignored by the caller.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: remove this from the kref patchset and instead submit it as standalone patch
 net/batman-adv/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 19ad0bb..c9b8205 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -720,6 +720,8 @@ static struct batadv_tvlv_container
 {
 	struct batadv_tvlv_container *tvlv_tmp, *tvlv = NULL;
 
+	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
+
 	hlist_for_each_entry(tvlv_tmp, &bat_priv->tvlv.container_list, list) {
 		if (tvlv_tmp->tvlv_hdr.type != type)
 			continue;
@@ -752,6 +754,8 @@ static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 	struct batadv_tvlv_container *tvlv;
 	u16 tvlv_len = 0;
 
+	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
+
 	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
 		tvlv_len += sizeof(struct batadv_tvlv_hdr);
 		tvlv_len += ntohs(tvlv->tvlv_hdr.len);
-- 
2.6.4

