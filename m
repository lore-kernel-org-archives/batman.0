Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:14 +0200
Message-Id: <1400931855-7961-9-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] alfred: Handle fcntl error return codes
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

fcntl doesn't return non-error return values when starting a F_GETFL operation.
These have to be handled or otherwise a garbage value is given to fcntl for
the F_SETFL operation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 netsock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/netsock.c b/netsock.c
index 8712c11..305983f 100644
--- a/netsock.c
+++ b/netsock.c
@@ -48,6 +48,7 @@ int netsock_open(struct globals *globals)
 	int sock;
 	struct sockaddr_in6 sin6;
 	struct ifreq ifr;
+	int ret;
 
 	globals->netsock = -1;
 
@@ -86,7 +87,18 @@ int netsock_open(struct globals *globals)
 		goto err;
 	}
 
-	fcntl(sock, F_SETFL, fcntl(sock, F_GETFL, 0) | O_NONBLOCK);
+	ret = fcntl(sock, F_GETFL, 0);
+	if (ret < 0) {
+		fprintf(stderr, "failed to get file status flags\n");
+		goto err;
+	}
+
+	ret = fcntl(sock, F_SETFL, ret | O_NONBLOCK);
+	if (ret < 0) {
+		fprintf(stderr, "failed to set file status flags\n");
+		goto err;
+	}
+
 	globals->netsock = sock;
 
 	return 0;
-- 
2.0.0.rc2

