Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Jul 2017 23:18:51 +0200
Message-Id: <20170724211852.14907-1-sven@narfation.org>
In-Reply-To: <13899415.9hl4lahuAs@sven-edge>
References: <13899415.9hl4lahuAs@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Use constant to define data type
 range
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

The maximum number of data types supported by alfred is limited by the
range of an uint8_t (0-255). alfred checks in the client mode whether data
type parameter is in the supported range by comparing it against
ALFRED_MAX_RESERVED_TYPE as lower bound and the magic number 255 as upper
bound.

Instead of using 255 in multiple places, define a named constant which can
be referenced. This makes it easier to understand these comparisons and to
reference this limit in a consistent way.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c   | 6 ++++--
 packet.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 446eecf..ad6d081 100644
--- a/main.c
+++ b/main.c
@@ -213,7 +213,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'r':
 			globals->clientmode = CLIENT_REQUEST_DATA;
 			i = atoi(optarg);
-			if (i < ALFRED_MAX_RESERVED_TYPE || i > 255) {
+			if (i < ALFRED_MAX_RESERVED_TYPE ||
+			    i >= ALFRED_NUM_TYPES) {
 				fprintf(stderr, "bad data type argument\n");
 				return NULL;
 			}
@@ -223,7 +224,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 's':
 			globals->clientmode = CLIENT_SET_DATA;
 			i = atoi(optarg);
-			if (i < ALFRED_MAX_RESERVED_TYPE || i > 255) {
+			if (i < ALFRED_MAX_RESERVED_TYPE ||
+			    i >= ALFRED_NUM_TYPES) {
 				fprintf(stderr, "bad data type argument\n");
 				return NULL;
 			}
diff --git a/packet.h b/packet.h
index afd3715..425459f 100644
--- a/packet.h
+++ b/packet.h
@@ -177,5 +177,6 @@ struct alfred_status_v0 {
 #define ALFRED_VERSION			0
 #define ALFRED_PORT			0x4242
 #define ALFRED_MAX_RESERVED_TYPE	64
+#define ALFRED_NUM_TYPES		256
 
 #endif
-- 
2.11.0

