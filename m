Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 17 Mar 2012 15:28:33 +0800
Message-Id: <1331969315-27535-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331969315-27535-1-git-send-email-lindner_marek@yahoo.de>
References: <1331969315-27535-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: refactor window_protected to
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 routing.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/routing.c b/routing.c
index 962a315..73aa20e 100644
--- a/routing.c
+++ b/routing.c
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
1.7.9.1

