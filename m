Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 16 Jun 2015 17:10:22 +0200
Message-Id: <1434467426-4281-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 maint 1/5] batman-adv: Make DAT capability
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

Fixes: 2b1c07b918d2 ("batman-adv: tvlv - add distributed arp table container")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 distributed-arp-table.c |    4 ++--
 types.h                 |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 0d791dc..b2cc19b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -682,9 +682,9 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					   uint16_t tvlv_value_len)
 {
 	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_DAT;
+		clear_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
 	else
-		orig->capabilities |= BATADV_ORIG_CAPA_HAS_DAT;
+		set_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
 }
 
 /**
diff --git a/types.h b/types.h
index 28f2461..e33b5aa 100644
--- a/types.h
+++ b/types.h
@@ -256,7 +256,7 @@ struct batadv_orig_node {
 	struct hlist_node mcast_want_all_ipv4_node;
 	struct hlist_node mcast_want_all_ipv6_node;
 #endif
-	uint8_t capabilities;
+	unsigned long capabilities;
 	uint8_t capa_initialized;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
-- 
1.7.10.4

