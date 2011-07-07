Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  7 Jul 2011 11:30:27 +0200
Message-Id: <1310031027-7198-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: request the full table if tt_crc
	doesn't match
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

In case of tt_crc mismatching for a certain orig_node after applying the
changes, the node must request the full table immediately.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/routing.c b/routing.c
index 2cb98be..010ebb7 100644
--- a/routing.c
+++ b/routing.c
@@ -91,6 +91,11 @@ static void update_transtable(struct bat_priv *bat_priv,
 		 * to recompute it to spot any possible inconsistency
 		 * in the global table */
 		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
+
+		/* If something went wrong we must request the full table now */
+		if (orig_node->tt_crc != tt_crc)
+			goto request_table;
+
 		/* Roaming phase is over: tables are in sync again. I can
 		 * unset the flag */
 		orig_node->tt_poss_change = false;
-- 
1.7.3.4

