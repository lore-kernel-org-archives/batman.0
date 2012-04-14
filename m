Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Apr 2012 13:15:26 +0200
Message-Id: <1334402127-5211-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1334402127-5211-1-git-send-email-ordex@autistici.org>
References: <1334402127-5211-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert bat_priv->tt_crc
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
To: b.a.t.m.a.n@lists.open-mesh.org

In the code we neever need to atomically check and set the bat_priv->tt_crc
field value. It is simply set and read once in different pieces of the code.
Therefore this field can be safely be converted from atomic_t to uint16_t.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c |    3 +--
 send.c       |    2 +-
 types.h      |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 994369d..ed743a4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -576,8 +576,7 @@ static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
 			htonl((uint32_t)atomic_read(&hard_iface->seqno));
 
 	batman_ogm_packet->ttvn = atomic_read(&bat_priv->ttvn);
-	batman_ogm_packet->tt_crc = htons((uint16_t)
-						atomic_read(&bat_priv->tt_crc));
+	batman_ogm_packet->tt_crc = htons(bat_priv->tt_crc);
 	if (tt_num_changes >= 0)
 		batman_ogm_packet->tt_num_changes = tt_num_changes;
 
diff --git a/send.c b/send.c
index 815cc9c..cebc14a 100644
--- a/send.c
+++ b/send.c
@@ -112,7 +112,7 @@ static int prepare_packet_buffer(struct bat_priv *bat_priv,
 
 	realloc_packet_buffer(hard_iface, new_len);
 
-	atomic_set(&bat_priv->tt_crc, tt_local_crc(bat_priv));
+	bat_priv->tt_crc = tt_local_crc(bat_priv);
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
diff --git a/types.h b/types.h
index 15f538a..995e910 100644
--- a/types.h
+++ b/types.h
@@ -224,7 +224,7 @@ struct bat_priv {
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

