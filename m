Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Apr 2012 19:25:52 +0200
Message-Id: <1333387552-18723-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: put long strings on a dedicated
	line
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

Strings that make the line exceed 80 chars should be put on a dedicated line to
avoid making it even longer

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bridge_loop_avoidance.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 8a17a78..aaa4b9f 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -697,7 +697,8 @@ static int handle_unclaim(struct bat_priv *bat_priv,
 		return 1;
 
 	/* this must be an UNCLAIM frame */
-	bat_dbg(DBG_BLA, bat_priv, "handle_unclaim(): UNCLAIM %pM on vid %d (sent by %pM)...\n",
+	bat_dbg(DBG_BLA, bat_priv,
+		"handle_unclaim(): UNCLAIM %pM on vid %d (sent by %pM)...\n",
 		claim_addr, vid, backbone_gw->orig);
 
 	bla_del_claim(bat_priv, claim_addr, vid);
-- 
1.7.9.4

