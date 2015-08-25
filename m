Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 25 Aug 2015 13:02:38 +0200
Message-Id: <1440500559-28368-15-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
References: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 14/15] batman-adv: Fix conditional statements
	indentation
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

commit 29b9256e6631 ("batman-adv: consider outgoing interface in OGM
sending") incorrectly indented the interface check code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
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
2.5.0

