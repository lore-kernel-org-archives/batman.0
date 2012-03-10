Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Mar 2012 06:44:50 +0800
Message-Id: <1331419491-21333-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331419491-21333-1-git-send-email-lindner_marek@yahoo.de>
References: <1331419491-21333-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Use {} braces consistent on
	the arms of a statement
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

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/routing.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 01b66d4..7f8e158 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -237,8 +237,9 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 				"old packet received, start protection\n");
 
 			return 0;
-		} else
+		} else {
 			return 1;
+		}
 	}
 	return 0;
 }
-- 
1.7.9.1

