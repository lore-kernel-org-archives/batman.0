Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  8 Jul 2011 23:38:54 +0200
Message-Id: <1310161134-18515-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: keep local table consistency for
	further TT_RESPONSE
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>

To keep transtable consistency among all the nodes, an originator must
not send not yet announced clients within a full table TT_RESPONSE.
Instead, deleted client have to be kept in the table in order to be sent
within an immediate TT_RESPONSE. In this way all the nodes in the
network will always provide the same response for the same request.

All the modification are committed at the next ttvn increment event.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 packet.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/packet.h b/packet.h
index 590e4a6..b76b4be 100644
--- a/packet.h
+++ b/packet.h
@@ -84,7 +84,9 @@ enum tt_query_flags {
 enum tt_client_flags {
 	TT_CLIENT_DEL     = 1 << 0,
 	TT_CLIENT_ROAM    = 1 << 1,
-	TT_CLIENT_NOPURGE = 1 << 8
+	TT_CLIENT_NOPURGE = 1 << 8,
+	TT_CLIENT_NEW     = 1 << 9,
+	TT_CLIENT_PENDING = 1 << 10
 };
 
 struct batman_packet {
-- 
1.7.3.4

