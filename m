Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:11 +0200
Message-Id: <1400931855-7961-6-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/10] alfred-gpsd: Fix altitute verification
	check
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 gpsd/alfred-gpsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index ef20f28..089f2af 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -370,7 +370,7 @@ static void gpsd_parse_location(struct globals *globals,
 		exit(EXIT_FAILURE);
 	}
 
-	if ((alt < -1000) || (lon > 9000)) {
+	if ((alt < -1000) || (alt > 9000)) {
 		/* No support for aircraft or submarines! */
 		printf("Invalid altitude\n");
 		gpsd_usage();
-- 
2.0.0.rc2

