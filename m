Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Mar 2013 14:21:12 +0100
Message-Id: <1364476872-28775-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't check compat version twice
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Compatibility version is checked upon packet reception
before calling any handler. For this reason it does need to
be checked once more in the handler itself.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 6d62e29..38183dc 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1054,13 +1054,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	}
 	rcu_read_unlock();
 
-	if (batadv_ogm_packet->header.version != BATADV_COMPAT_VERSION) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: incompatible batman version (%i)\n",
-			   batadv_ogm_packet->header.version);
-		return;
-	}
-
 	if (is_my_addr) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: received my own broadcast (sender: %pM)\n",
-- 
1.8.1.5

