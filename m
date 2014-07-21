Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 21 Jul 2014 10:03:59 +0200
Message-Id: <1405929839-1939-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid useless return in void
	functions
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/multicast.h b/multicast.h
index 73b5d45..3a44ebd 100644
--- a/multicast.h
+++ b/multicast.h
@@ -50,7 +50,6 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 
 static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 {
-	return;
 }
 
 static inline enum batadv_forw_mode
@@ -67,12 +66,10 @@ static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 
 static inline void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	return;
 }
 
 static inline void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
 {
-	return;
 }
 
 #endif /* CONFIG_BATMAN_ADV_MCAST */
-- 
1.8.5.5

