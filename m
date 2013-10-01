Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:09 +0200
Message-Id: <1380628934-22220-2-git-send-email-sven@open-mesh.com>
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] alfred: Close netsock when
	initialization failed
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

A failed initialization of the netsock is currently not cleaning up the socket.
This is not problematic at the moment because a failed initialization also
closes the server.

This can be a problem later when the netsock is reopened with a modified
configuration and a failed re-initialization is still accepted.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 netsock.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/netsock.c b/netsock.c
index 39281af..bed62e9 100644
--- a/netsock.c
+++ b/netsock.c
@@ -49,6 +49,8 @@ int netsock_open(struct globals *globals)
 	struct sockaddr_in6 sin6;
 	struct ifreq ifr;
 
+	globals->netsock = -1;
+
 	sock = socket(PF_INET6, SOCK_DGRAM, 0);
 	if (sock  < 0) {
 		fprintf(stderr, "can't open socket: %s\n", strerror(errno));
@@ -59,7 +61,7 @@ int netsock_open(struct globals *globals)
 	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
 		fprintf(stderr, "can't get interface: %s\n", strerror(errno));
-		return -1;
+		goto err;
 	}
 
 	globals->scope_id = ifr.ifr_ifindex;
@@ -72,7 +74,7 @@ int netsock_open(struct globals *globals)
 
 	if (ioctl(sock, SIOCGIFHWADDR, &ifr) == -1) {
 		fprintf(stderr, "can't get MAC address: %s\n", strerror(errno));
-		return -1;
+		goto err;
 	}
 
 	memcpy(&globals->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
@@ -80,16 +82,19 @@ int netsock_open(struct globals *globals)
 
 	if (ioctl(sock, SIOCGIFMTU, &ifr) == -1) {
 		fprintf(stderr, "can't get MTU: %s\n", strerror(errno));
-		return -1;
+		goto err;
 	}
 
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
 		fprintf(stderr, "can't bind\n");
-		return -1;
+		goto err;
 	}
 
 	fcntl(sock, F_SETFL, fcntl(sock, F_GETFL, 0) | O_NONBLOCK);
 	globals->netsock = sock;
 
 	return 0;
+err:
+	close(sock);
+	return -1;
 }
-- 
1.8.4.rc3

