Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 May 2012 09:17:34 +0200
Message-Id: <1336979858-13928-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1336979858-13928-1-git-send-email-ordex@autistici.org>
References: <1336979858-13928-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: refactor window_protected to
	avoid unnecessary return statement
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

From: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b1824bb..840e2c6 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -234,17 +234,14 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 {
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE) ||
 	    (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
-		if (has_timed_out(*last_reset, RESET_PROTECTION_MS)) {
-
-			*last_reset = jiffies;
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"old packet received, start protection\n");
-
-			return 0;
-		} else {
+		if (!has_timed_out(*last_reset, RESET_PROTECTION_MS))
 			return 1;
-		}
+
+		*last_reset = jiffies;
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"old packet received, start protection\n");
 	}
+
 	return 0;
 }
 
-- 
1.7.9.4

