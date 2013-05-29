Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 02:59:32 +0200
Message-Id: <1369789186-3600-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1369789186-3600-1-git-send-email-ordex@autistici.org>
References: <1369789186-3600-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/21] batman-adv: don't check compat version
	twice
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Compatibility version is checked upon packet reception
before calling any handler. For this reason it does need to
be checked once more in the handler itself.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/bat_iv_ogm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6d62e29..38183dc 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
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

