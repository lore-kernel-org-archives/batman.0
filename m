Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:13 +0200
Message-Id: <1380628934-22220-6-git-send-email-sven@open-mesh.com>
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] alfred: Try to reinitialize invalid
	netsock
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Alfred needs to recover when the netsock became invalid. Otherwise it is
incapable of communicating with other alfred instances. This recovery can fail
until the used interface reappeared.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/server.c b/server.c
index bc3b551..ed04f70 100644
--- a/server.c
+++ b/server.c
@@ -246,6 +246,9 @@ int alfred_server(struct globals *globals)
 			tv.tv_nsec = 0;
 		}
 
+		if (globals->netsock < 0)
+			netsock_open(globals);
+
 		maxsock = -1;
 		if (globals->netsock > maxsock)
 			maxsock = globals->netsock;
-- 
1.8.4.rc3

