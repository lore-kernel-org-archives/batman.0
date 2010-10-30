Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 17:00:57 +0200
Message-Id: <1288450858-14753-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batctl: Readd ping interval after each
	loop
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
To: b.a.t.m.a.n@lists.open-mesh.org

The option -i for ping had no visible effect. We can simply change it
back to the old behaviour from battool times.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/ping.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/batctl/ping.c b/batctl/ping.c
index 1ed8fac..9963b24 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -292,9 +292,8 @@ int ping(char *mesh_iface, int argc, char **argv)
 		}
 
 sleep:
-		if ((tv.tv_sec != 0) || (tv.tv_usec != 0))
-			select(0, NULL, NULL, NULL, &tv);
-
+		if (loop_interval > 0)
+			sleep(loop_interval);
 	}
 
 	if (packets_out == 0)
-- 
1.7.2.3

