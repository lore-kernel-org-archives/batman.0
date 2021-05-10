Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: batctl: translocal: Simplify evaluation of last_seen
Date: Mon, 10 May 2021 15:29:53 +0200
Message-Id: <20210510132953.44348-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The BATADV_ATTR_LAST_SEEN_MSECS is send from the kernel whenever it is
relevant for the current local translation table entry. It is therefore not
necessary to only read this value when a specific flag is or is not present
in BATADV_ATTR_TT_FLAGS.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/translocal.c b/translocal.c
index a3ad3da57252b336399bdea8bf2ea21442c9cafe..bac6be9e9bd59c20550068495197d0d3c74564d5 100644
--- a/translocal.c
+++ b/translocal.c
@@ -89,15 +89,10 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 		w = 'W';
 	if (flags & BATADV_TT_CLIENT_ISOLA)
 		i = 'I';
-
-	if (flags & BATADV_TT_CLIENT_NOPURGE)  {
+	if (flags & BATADV_TT_CLIENT_NOPURGE)
 		p = 'P';
-	} else {
-		if (!attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
-			fputs("Received invalid data from kernel.\n", stderr);
-			exit(1);
-		}
 
+	if (attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
 		last_seen_msecs = nla_get_u32(
 			attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
 		last_seen_secs = last_seen_msecs / 1000;
