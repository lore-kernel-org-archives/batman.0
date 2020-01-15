Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] alfred-gpsd: Fix build against gpsd ABI 9.0
Date: Wed, 15 Jan 2020 21:01:58 +0100
Message-Id: <20200115200158.2920-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?q?Steffen=20M=C3=B6ller?= <steffen_moeller@gmx.de>, Sven Eckelmann <sven@narfation.org>

libgpsd 3.20 removed the timestamp_t type and the function
unix_to_iso8601(). The same release introduced the timespec_t based
function timespec_to_iso8601().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 884bdbf..47d6a64 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -8,6 +8,8 @@
 
 #include "alfred-gpsd.h"
 
+#include <time.h>
+
 static struct globals gpsd_globals;
 
 static int alfred_open_sock(struct globals *globals)
@@ -64,19 +66,31 @@ static int gpsd_publish_data(struct globals *globals)
 	return 0;
 }
 
+static void gpsd_now_to_iso8601(char *tbuf, size_t len)
+{
+#if GPSD_API_MAJOR_VERSION >= 9
+	timespec_t now;
+
+	clock_gettime(CLOCK_REALTIME, &now);
+	timespec_to_iso8601(now, tbuf, len);
+#else
+	timestamp_t now = timestamp();
+	unix_to_iso8601(now, tbuf, len);
+#endif
+}
+
 static void gpsd_get_location(struct globals *globals)
 {
 	if (globals->source == SOURCE_CMDLINE) {
 		char tbuf[JSON_DATE_MAX+1];
-		timestamp_t now = timestamp();
 
+		gpsd_now_to_iso8601(tbuf, sizeof(tbuf));
 		sprintf(globals->gpsd_data->tpv,
 			"{\"class\":\"TPV\",\"device\":\"command line\","
 			"\"time\":\"%s\","
 			"\"lat\":%f,\"lon\":%f,\"alt\":%f,"
 			"\"mode\":3}",
-			unix_to_iso8601(now, tbuf, sizeof(tbuf)),
-			globals->lat, globals->lon, globals->alt);
+			tbuf, globals->lat, globals->lon, globals->alt);
 		globals->gpsd_data->tpv_len =
 			htonl(strlen(globals->gpsd_data->tpv) + 1);
 	}
-- 
2.20.1

