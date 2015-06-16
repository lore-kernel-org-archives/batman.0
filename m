Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 16 Jun 2015 17:10:24 +0200
Message-Id: <1434467426-4281-4-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 maint 3/5] batman-adv: Make TT capability
	changes atomic
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

Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
OGM handler might undo the set/clear of a specific bit from another
handler run in between.

Fix this by using the atomic set_bit()/clear_bit() functions.

Fixes: 5d2121af6d31 ("batman-adv: introduce capability initialization bitfield")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 translation-table.c |    4 ++--
 types.h             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index b098e53..e95a424 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1843,7 +1843,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 		}
 		spin_unlock_bh(list_lock);
 	}
-	orig_node->capa_initialized &= ~BATADV_ORIG_CAPA_HAS_TT;
+	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
@@ -2802,7 +2802,7 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				return;
 		}
 	}
-	orig_node->capa_initialized |= BATADV_ORIG_CAPA_HAS_TT;
+	set_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
diff --git a/types.h b/types.h
index e33b5aa..c6ec558 100644
--- a/types.h
+++ b/types.h
@@ -257,7 +257,7 @@ struct batadv_orig_node {
 	struct hlist_node mcast_want_all_ipv6_node;
 #endif
 	unsigned long capabilities;
-	uint8_t capa_initialized;
+	unsigned long capa_initialized;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
-- 
1.7.10.4

