Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jun 2014 21:56:01 +0200
Message-Id: <1403034964-6737-4-git-send-email-sven@narfation.org>
In-Reply-To: <1403034964-6737-1-git-send-email-sven@narfation.org>
References: <1403034964-6737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batmand: Free socket when setsockopt
	failed
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

client_to_gw_tun calls setsockopt which can fail. In this case it jumps to the
error handling and cleanup code but doesn't close the udp_sock. This has to be
done to avoid leaking of file descriptors.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 posix/tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/posix/tunnel.c b/posix/tunnel.c
index 08c56a2..8e7611b 100644
--- a/posix/tunnel.c
+++ b/posix/tunnel.c
@@ -201,7 +201,7 @@ void *client_to_gw_tun(void *arg)
 	sock_opts = 1;
         if (setsockopt(udp_sock, SOL_SOCKET, SO_REUSEADDR, &sock_opts, sizeof(sock_opts)) < 0) {
                debug_output(0, "Error - can't set options on udp socket: %s\n", strerror(errno));
-		goto out;
+		goto udp_out;
         }
 
 	if (bind(udp_sock, (struct sockaddr *)&my_addr, sizeof(struct sockaddr_in)) < 0) {
-- 
2.0.0

