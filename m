Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 18:33:56 +0200
Message-Id: <1336840447-6580-7-git-send-email-sven@narfation.org>
In-Reply-To: <1336840447-6580-1-git-send-email-sven@narfation.org>
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/18] batman-adv: Prefix gateway_common
	local static functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateway_common.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gateway_common.c b/gateway_common.c
index 3700562..6edf37f 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -22,7 +22,7 @@
 #include "gateway_client.h"
 
 /* calculates the gateway class from kbit */
-static void kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
+static void batadv_kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
 {
 	int mdown = 0, tdown, tup, difference;
 	uint8_t sbit, part;
@@ -73,8 +73,8 @@ void batadv_gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 	*up = ((upart + 1) * (*down)) / 8;
 }
 
-static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
-			       int *up, int *down)
+static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
+				      int *up, int *down)
 {
 	int ret, multi = 1;
 	char *slash_ptr, *tmp_ptr;
@@ -142,7 +142,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 	int up = 0, down = 0;
 	bool ret;
 
-	ret = parse_gw_bandwidth(net_dev, buff, &up, &down);
+	ret = batadv_parse_gw_bandwidth(net_dev, buff, &up, &down);
 	if (!ret)
 		goto end;
 
@@ -152,7 +152,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 	if (!up)
 		up = down / 5;
 
-	kbit_to_gw_bandwidth(down, up, &gw_bandwidth_tmp);
+	batadv_kbit_to_gw_bandwidth(down, up, &gw_bandwidth_tmp);
 
 	/* the gw bandwidth we guessed above might not match the given
 	 * speeds, hence we need to calculate it back to show the number
-- 
1.7.10

