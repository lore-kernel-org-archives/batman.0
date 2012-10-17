Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 21:55:58 +0200
Message-Id: <1350503758-20685-4-git-send-email-sven@narfation.org>
In-Reply-To: <1350503758-20685-1-git-send-email-sven@narfation.org>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] alfred: Fix test for failed sendbuf
	allocation
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 recv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recv.c b/recv.c
index dce7e50..8ddf7ab 100644
--- a/recv.c
+++ b/recv.c
@@ -217,7 +217,7 @@ int send_alfred_packet(struct globals *globals, uint8_t *dest, void *buf,
 	char *sendbuf;
 
 	sendbuf = malloc(sizeof(*ethhdr) + length);
-	if (!buf)
+	if (!sendbuf)
 		return -1;
 
 	ethhdr = (struct ethhdr *)sendbuf;
-- 
1.7.10.4

