Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 11 May 2012 16:10:50 +0800
Message-Id: <1336723850-487-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: only store changed gw_bandwidth
	values
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 gateway_common.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gateway_common.c b/gateway_common.c
index ca57ac7..6e3b052 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -162,6 +162,9 @@ ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count)
 	 **/
 	gw_bandwidth_to_kbit((uint8_t)gw_bandwidth_tmp, &down, &up);
 
+	if (atomic_read(&bat_priv->gw_bandwidth) == gw_bandwidth_tmp)
+		return count;
+
 	gw_deselect(bat_priv);
 	bat_info(net_dev,
 		 "Changing gateway bandwidth from: '%i' to: '%ld' (propagating: %d%s/%d%s)\n",
-- 
1.7.9.1

