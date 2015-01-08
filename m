Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:06 +0100
Message-Id: <1420730120-9844-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 01/15] batman-adv: avoid useless return in
	void functions
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/debugfs.c   | 1 -
 net/batman-adv/multicast.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index a12e25e..1485091 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -233,7 +233,6 @@ static int batadv_debug_log_setup(struct batadv_priv *bat_priv)
 
 static void batadv_debug_log_cleanup(struct batadv_priv *bat_priv)
 {
-	return;
 }
 #endif
 
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 73b5d45..3a44ebd 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
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
2.2.1

