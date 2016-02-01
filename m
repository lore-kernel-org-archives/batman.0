Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon,  1 Feb 2016 14:34:33 +0800
Message-Id: <1454308474-23211-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
References: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2 next 2/3] batman-adv: convert wifi driver
	throughput to multiples of 100kbps
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

The expected throughout returned by the cfg80211 API is expressed in kbps
while internally batman-adv stores multiples of 100kbps. Ensure the
conversion is performed properly.

Fixes: 5c324517 ("ELP - compute the metric based on the estimated throughput")

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 46c6a00..461a765 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -100,7 +100,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 				return 0;
 			}
 			if (!ret)
-				return sinfo.expected_throughput / 10;
+				return sinfo.expected_throughput / 100;
 		}
 
 		/* unsupported WiFi driver version */
-- 
2.7.0

