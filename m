Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 24 May 2017 12:32:08 +0200
Message-Id: <20170524103211.810-2-sven.eckelmann@openmesh.com>
In-Reply-To: <4690435.IOLn72U8Ez@bentobox>
References: <4690435.IOLn72U8Ez@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] alfred: Only query tq of remote master
	in slave mode
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The querying of the originator mac address and tq values of the orignator
address takes significant amount of time. It is therefore better to avoid
the TQ retrieval code when possible.

The TQ will not be used in master mode and it can therefore be skipped
together with the code which tries to find the new best server.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 recv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/recv.c b/recv.c
index 3fd964d..8aa512d 100644
--- a/recv.c
+++ b/recv.c
@@ -304,6 +304,13 @@ process_alfred_announce_master(struct globals *globals,
 	}
 
 	clock_gettime(CLOCK_MONOTONIC, &server->last_seen);
+
+	/* TQ is not used for master sync mode */
+	if (globals->opmode == OPMODE_MASTER) {
+		server->tq = 0;
+		return 0;
+	}
+
 	if (strcmp(globals->mesh_iface, "none") != 0) {
 		macaddr = translate_mac(globals->mesh_iface,
 					(struct ether_addr *)&server->hwaddr);
@@ -315,8 +322,7 @@ process_alfred_announce_master(struct globals *globals,
 		server->tq = 255;
 	}
 
-	if (globals->opmode == OPMODE_SLAVE)
-		set_best_server(globals);
+	set_best_server(globals);
 
 	return 0;
 }
-- 
2.11.0

