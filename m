Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Jul 2015 10:03:42 +0200
Message-Id: <1437120223-11556-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: Fix conditional
	statements indentation
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

commit 29b9256e6631 ("batman-adv: consider outgoing interface in OGM
sending") incorrectly indented the interface check code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: Change commit message to new git commit description style

 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index df54118..5c12200 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -968,7 +968,7 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list, list) {
 		if (tmp_hard_iface->soft_iface != hard_iface->soft_iface)
-				continue;
+			continue;
 		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
 					*ogm_buff_len, hard_iface,
 					tmp_hard_iface, 1, send_time);
-- 
2.1.4

