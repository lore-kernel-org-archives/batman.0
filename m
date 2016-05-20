Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2016 17:30:08 +0200
Message-Id: <1463758208-31645-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Fix format string for raw tp_meter
	output
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

The tp_meter output for raw bytes is not casting the values to float.
It must therefore use PRIu64 to print the results.

Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tp_meter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tp_meter.c b/tp_meter.c
index d980ebd..43c19da 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -524,8 +524,8 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
 				(float)throughput / (1<<10),
 				(float)throughput * 8 / 1000);
 		else
-			printf("%lu Bytes/s (%lu Bps)\n",
-				throughput, throughput * 8);
+			printf("%" PRIu64 " Bytes/s (%" PRIu64 " Bps)\n",
+			       throughput, throughput * 8);
 
 		ret = 0;
 		break;
-- 
2.8.1

