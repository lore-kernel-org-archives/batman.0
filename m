Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 11 May 2012 14:21:30 +0200
Message-Id: <1336738892-7401-14-git-send-email-ordex@autistici.org>
In-Reply-To: <1336738892-7401-1-git-send-email-ordex@autistici.org>
References: <1336738892-7401-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/15] batman-adv: fix checkpatch string
	complaint
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

Regression introduced by: f76d019194e0a88c57371df169ecc979690a04c2

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_iv_ogm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index bafb473..abd10c4 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1061,8 +1061,8 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 
 	if (batman_ogm_packet->flags & NOT_BEST_NEXT_HOP) {
 		bat_dbg(DBG_BATMAN, bat_priv,
-			"Drop packet: ignoring all packets not forwarded from "
-			"the best next hop (sender: %pM)\n", ethhdr->h_source);
+			"Drop packet: ignoring all packets not forwarded from the best next hop (sender: %pM)\n",
+			ethhdr->h_source);
 		return;
 	}
 
-- 
1.7.9.4

