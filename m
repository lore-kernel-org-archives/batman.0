Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri,  8 Jul 2011 00:35:46 +0200
Message-Id: <1310078146-29537-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1310078023-28958-1-git-send-email-lindner_marek@yahoo.de>
References: <1310078023-28958-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: request the full table if
	tt_crc doesn't match
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Antonio Quartulli <ordex@autistici.org>

In case of tt_crc mismatching for a certain orig_node after applying the
changes, the node must request the full table immediately.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/routing.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2cb98be..0f32c81 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -91,6 +91,18 @@ static void update_transtable(struct bat_priv *bat_priv,
 		 * to recompute it to spot any possible inconsistency
 		 * in the global table */
 		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
+
+		/* The ttvn alone is not enough to guarantee consistency
+		 * because a single value could repesent different states
+		 * (due to the wrap around). Thus a node has to check whether
+		 * the resulting table (after applying the changes) is still
+		 * consistent or not. E.g. a node could disconnect while its
+		 * ttvn is X and reconnect on ttvn = X + TTVN_MAX: in this case
+		 * checking the CRC value is mandatory to detect the
+		 * inconsistency */
+		if (orig_node->tt_crc != tt_crc)
+			goto request_table;
+
 		/* Roaming phase is over: tables are in sync again. I can
 		 * unset the flag */
 		orig_node->tt_poss_change = false;
-- 
1.7.5.3

