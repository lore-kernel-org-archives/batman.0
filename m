Return-Path: <mudongliangabcd@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Subject: [PATCH] net: batman-adv: fix warning in batadv_v_ogm_free
Date: Mon,  1 Nov 2021 12:01:02 +0800
Message-Id: <20211101040103.388646-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>, Antonio Quartulli <antonio@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

If batadv_v_ogm_init encounters a memory failure, the fields ogm_wq,
ogm_buff_mutex and etc. are not initialized. Then the control flow goes
to batadv_v_ogm_free due to the error handling code. As a result, the
API invocation "cancel_delayed_work_sync" and "mutex_lock" will cause
many issues. The crashing stack trace is as follows:

Call Trace:
 __cancel_work_timer+0x1c9/0x280 kernel/workqueue.c:3170
 batadv_v_ogm_free+0x1d/0x50 net/batman-adv/bat_v_ogm.c:1076
 batadv_mesh_free+0x35/0xa0 net/batman-adv/main.c:244
 batadv_mesh_init+0x22a/0x240 net/batman-adv/main.c:226
 batadv_softif_init_late+0x1ad/0x240 net/batman-adv/soft-interface.c:804
 register_netdevice+0x15d/0x810 net/core/dev.c:10229

Fixes: a8d23cbbf6c9 ("batman-adv: Avoid free/alloc race when handling OGM2 buffer")
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 net/batman-adv/bat_v_ogm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1d750f3cb2e4..2f3ecbcec58d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1044,6 +1044,13 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 	unsigned char *ogm_buff;
 	u32 random_seqno;
 
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&bat_priv->bat_v.ogm_seqno, random_seqno);
+	INIT_DELAYED_WORK(&bat_priv->bat_v.ogm_wq, batadv_v_ogm_send);
+
+	mutex_init(&bat_priv->bat_v.ogm_buff_mutex);
+
 	bat_priv->bat_v.ogm_buff_len = BATADV_OGM2_HLEN;
 	ogm_buff = kzalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
 	if (!ogm_buff)
@@ -1057,13 +1064,6 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 	ogm_packet->flags = BATADV_NO_FLAGS;
 	ogm_packet->throughput = htonl(BATADV_THROUGHPUT_MAX_VALUE);
 
-	/* randomize initial seqno to avoid collision */
-	get_random_bytes(&random_seqno, sizeof(random_seqno));
-	atomic_set(&bat_priv->bat_v.ogm_seqno, random_seqno);
-	INIT_DELAYED_WORK(&bat_priv->bat_v.ogm_wq, batadv_v_ogm_send);
-
-	mutex_init(&bat_priv->bat_v.ogm_buff_mutex);
-
 	return 0;
 }
 
-- 
2.25.1

