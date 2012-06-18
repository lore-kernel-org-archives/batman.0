Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 22:39:08 +0200
Message-Id: <1340051963-14836-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/19] batman-adv: convert bat_priv->tt_crc
	from atomic_t to uint16_t
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

In the code we neever need to atomically check and set the bat_priv->tt_crc
field value. It is simply set and read once in different pieces of the code.
Therefore this field can be safely be converted from atomic_t to uint16_t.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c |    3 +--
 net/batman-adv/send.c       |    2 +-
 net/batman-adv/types.h      |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index dc53798..ec35119 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -575,8 +575,7 @@ static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
 			htonl((uint32_t)atomic_read(&hard_iface->seqno));
 
 	batman_ogm_packet->ttvn = atomic_read(&bat_priv->ttvn);
-	batman_ogm_packet->tt_crc = htons((uint16_t)
-						atomic_read(&bat_priv->tt_crc));
+	batman_ogm_packet->tt_crc = htons(bat_priv->tt_crc);
 	if (tt_num_changes >= 0)
 		batman_ogm_packet->tt_num_changes = tt_num_changes;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index f47299f..f5ff364 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -111,7 +111,7 @@ static int prepare_packet_buffer(struct bat_priv *bat_priv,
 
 	realloc_packet_buffer(hard_iface, new_len);
 
-	atomic_set(&bat_priv->tt_crc, tt_local_crc(bat_priv));
+	bat_priv->tt_crc = tt_local_crc(bat_priv);
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 61308e8..547dc33 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -210,7 +210,7 @@ struct bat_priv {
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	atomic_t num_local_tt;
 	/* Checksum of the local table, recomputed before sending a new OGM */
-	atomic_t tt_crc;
+	uint16_t tt_crc;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff */
-- 
1.7.9.4

