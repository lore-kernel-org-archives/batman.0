Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  6 Jan 2015 12:10:01 +0100
Message-Id: <1420542605-28865-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
References: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: fix delayed foreign
	originator recognition
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Currently it can happen that the reception of an OGM from a new
originator is not being accepted. More precisely it can happen that
an originator struct gets allocated and initialized
(batadv_orig_node_new()), even the TQ gets calculated and set correctly
(batadv_iv_ogm_calc_tq()) but still the periodic orig_node purging
thread will decide to delete it if it has a chance to jump between
these two function calls.

This is because batadv_orig_node_new() initializes the last_seen value
to zero and its caller (batadv_iv_ogm_orig_get()) makes it visible to
other threads by adding it to the hash table already.
batadv_iv_ogm_calc_tq() will set the last_seen variable to the correct,
current time a few lines later but if the purging thread jumps in between
that it will think that the orig_node timed out and will wrongly
schedule it for deletion already.

If the purging interval is the same as the originator interval (which is
the default: 1 second), then this game can continue for several rounds
until the random OGM jitter added enough difference between these
two (in tests, two to about four rounds seemed common).

Fixing this by initializing the last_seen variable of an orig_node
to the current time before adding it to the hash table.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/originator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 6a48451..648bdba 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -678,6 +678,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	atomic_set(&orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
+	orig_node->last_seen = jiffies;
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 #ifdef CONFIG_BATMAN_ADV_MCAST
-- 
2.2.1

