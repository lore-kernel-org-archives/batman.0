Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Jun 2014 18:54:03 +0200
Message-Id: <1403628843-6936-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Calculate size of global buffer and
	not of a single char
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

The global buffer is 65536 bytes in size and not only 1 byte. This statement
evaluated to a negative value which was casted to an unsigned value (aka...
very large value).

This is a regression was introduced in 71dbc00fd879f1e592b07d8397f724fb3f69ac64
("alfred: Use strncpy instead of strcpy for string").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gpsd/alfred-gpsd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 84a0ded..d6cdfd6 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -301,7 +301,7 @@ static void gpsd_read_gpsd(struct globals *globals)
 	size_t cnt;
 	bool eol = false;
 	char buf[4096];
-	const size_t tpv_size = sizeof(*globals->buf) -
+	const size_t tpv_size = sizeof(globals->buf) -
 				sizeof(*globals->push) -
 				sizeof(struct alfred_data) -
 				sizeof(*globals->gpsd_data);
@@ -450,7 +450,7 @@ static int gpsd_server(struct globals *globals)
 	int max_fd, ret;
 	const size_t overhead = sizeof(*globals->push) +
 		sizeof(struct alfred_data);
-	const size_t tpv_size = sizeof(*globals->buf) -
+	const size_t tpv_size = sizeof(globals->buf) -
 				sizeof(*globals->push) -
 				sizeof(struct alfred_data) -
 				sizeof(*globals->gpsd_data);
-- 
2.0.0

