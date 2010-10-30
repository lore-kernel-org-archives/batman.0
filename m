Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 17:00:56 +0200
Message-Id: <1288450858-14753-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288450858-14753-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batctl: Initialise timeout before usage
	in error case
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
This patch is useless if we also add
"batctl: Readd ping interval after each loop"

 batctl/ping.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/batctl/ping.c b/batctl/ping.c
index 288bd01..1ed8fac 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -180,6 +180,9 @@ int ping(char *mesh_iface, int argc, char **argv)
 		packet_len, packet_len + 28);
 
 	while (!is_aborted) {
+		tv.tv_sec = timeout;
+		tv.tv_usec = 0;
+
 		if (loop_count == 0)
 			break;
 
@@ -195,9 +198,6 @@ int ping(char *mesh_iface, int argc, char **argv)
 
 		start_timer();
 
-		tv.tv_sec = timeout;
-		tv.tv_usec = 0;
-
 		FD_ZERO(&read_socket);
 		FD_SET(ping_fd, &read_socket);
 
-- 
1.7.2.3

