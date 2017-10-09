Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  9 Oct 2017 17:33:07 +0200
Message-Id: <20171009153307.29245-2-sven@narfation.org>
In-Reply-To: <20171009153307.29245-1-sven@narfation.org>
References: <20171009153307.29245-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Only check for minimal length of
 fixed size packets
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

These fixed size packets could have some optional information in the
future. We should therefore not limit the size of these packets to the size
of the non-tlv header.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Any objections? Not sure if this is really necessary. But could be useful
in the future.
---
 recv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recv.c b/recv.c
index 12bb3f1..e897e3d 100644
--- a/recv.c
+++ b/recv.c
@@ -284,7 +284,7 @@ process_alfred_announce_master(struct globals *globals,
 	if (announce->header.version != ALFRED_VERSION)
 		return -1;
 
-	if (len != (sizeof(*announce) - sizeof(announce->header)))
+	if (len < (sizeof(*announce) - sizeof(announce->header)))
 		return -1;
 
 	server = hash_find(interface->server_hash, &mac);
@@ -320,7 +320,7 @@ static int process_alfred_request(struct globals *globals,
 	if (request->header.version != ALFRED_VERSION)
 		return -1;
 
-	if (len != (sizeof(*request) - sizeof(request->header)))
+	if (len < (sizeof(*request) - sizeof(request->header)))
 		return -1;
 
 	push_data(globals, interface, source, SOURCE_SYNCED,
@@ -343,7 +343,7 @@ static int process_alfred_status_txend(struct globals *globals,
 	if (request->header.version != ALFRED_VERSION)
 		return -1;
 
-	if (len != (sizeof(*request) - sizeof(request->header)))
+	if (len < (sizeof(*request) - sizeof(request->header)))
 		return -1;
 
 	if (globals->ipv4mode)
-- 
2.11.0

