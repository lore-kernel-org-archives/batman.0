Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 29 Jul 2014 14:06:53 +0200
Message-Id: <1406635614-28176-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Print libc errors with perror
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debugfs.c          |  4 +---
 gpsd/alfred-gpsd.c |  9 +++------
 netsock.c          | 12 ++++++------
 recv.c             |  3 +--
 server.c           | 11 ++++-------
 unix_sock.c        | 21 +++++++--------------
 vis/vis.c          | 10 ++++------
 7 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 4b8801a..fbf992e 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -89,9 +89,7 @@ static const char *debugfs_find_mountpoint(void)
 	/* give up and parse /proc/mounts */
 	fp = fopen("/proc/mounts", "r");
 	if (fp == NULL) {
-		fprintf(stderr,
-			"Error - can't open /proc/mounts for read: %s\n",
-			strerror(errno));
+		perror("Error - can't open /proc/mounts for read");
 		return NULL;
 	}
 
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 06c0680..6e88dc7 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -29,8 +29,7 @@ static int alfred_open_sock(struct globals *globals)
 
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
-		fprintf(stderr, "can't create unix socket: %s\n",
-			strerror(errno));
+		perror("can't create unix socket");
 		return -1;
 	}
 
@@ -41,8 +40,7 @@ static int alfred_open_sock(struct globals *globals)
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
-		fprintf(stderr, "can't connect to unix socket: %s\n",
-			strerror(errno));
+		perror("can't connect to unix socket");
 		return -1;
 	}
 
@@ -514,8 +512,7 @@ static int gpsd_server(struct globals *globals)
 			errno = 0;
 			ret = select(max_fd, &fds, NULL, NULL, &tv);
 			if (ret == -1 && errno != EINTR)
-				printf("select error %s(%d)\n",
-				       strerror(errno), errno);
+				perror("select error");
 
 			if (ret == 1)
 				gpsd_read_gpsd(globals);
diff --git a/netsock.c b/netsock.c
index 305983f..a1a97e4 100644
--- a/netsock.c
+++ b/netsock.c
@@ -54,7 +54,7 @@ int netsock_open(struct globals *globals)
 
 	sock = socket(PF_INET6, SOCK_DGRAM, 0);
 	if (sock  < 0) {
-		fprintf(stderr, "can't open socket: %s\n", strerror(errno));
+		perror("can't open socket");
 		return -1;
 	}
 
@@ -62,7 +62,7 @@ int netsock_open(struct globals *globals)
 	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
-		fprintf(stderr, "can't get interface: %s\n", strerror(errno));
+		perror("can't get interface");
 		goto err;
 	}
 
@@ -75,7 +75,7 @@ int netsock_open(struct globals *globals)
 	sin6.sin6_scope_id = ifr.ifr_ifindex;
 
 	if (ioctl(sock, SIOCGIFHWADDR, &ifr) == -1) {
-		fprintf(stderr, "can't get MAC address: %s\n", strerror(errno));
+		perror("can't get MAC address");
 		goto err;
 	}
 
@@ -83,19 +83,19 @@ int netsock_open(struct globals *globals)
 	mac_to_ipv6(&globals->hwaddr, &globals->address);
 
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
-		fprintf(stderr, "can't bind\n");
+		perror("can't bind");
 		goto err;
 	}
 
 	ret = fcntl(sock, F_GETFL, 0);
 	if (ret < 0) {
-		fprintf(stderr, "failed to get file status flags\n");
+		perror("failed to get file status flags");
 		goto err;
 	}
 
 	ret = fcntl(sock, F_SETFL, ret | O_NONBLOCK);
 	if (ret < 0) {
-		fprintf(stderr, "failed to set file status flags\n");
+		perror("failed to set file status flags");
 		goto err;
 	}
 
diff --git a/recv.c b/recv.c
index 724c551..2948547 100644
--- a/recv.c
+++ b/recv.c
@@ -385,8 +385,7 @@ int recv_alfred_packet(struct globals *globals)
 	length = recvfrom(globals->netsock, buf, sizeof(buf), 0,
 			  (struct sockaddr *)&source, &sourcelen);
 	if (length <= 0) {
-		fprintf(stderr, "read from network socket failed: %s\n",
-			strerror(errno));
+		perror("read from network socket failed");
 		return -1;
 	}
 
diff --git a/server.c b/server.c
index b060d55..94e6145 100644
--- a/server.c
+++ b/server.c
@@ -236,7 +236,7 @@ static void check_if_socket(struct globals *globals)
 
 	sock = socket(PF_INET6, SOCK_DGRAM, 0);
 	if (sock < 0) {
-		fprintf(stderr, "can't open socket: %s\n", strerror(errno));
+		perror("can't open socket");
 		return;
 	}
 
@@ -244,8 +244,7 @@ static void check_if_socket(struct globals *globals)
 	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
-		fprintf(stderr, "can't get interface: %s, closing netsock\n",
-			strerror(errno));
+		perror("can't get interface, closing netsock");
 		goto close;
 	}
 
@@ -257,8 +256,7 @@ static void check_if_socket(struct globals *globals)
 	}
 
 	if (ioctl(sock, SIOCGIFHWADDR, &ifr) == -1) {
-		fprintf(stderr, "can't get MAC address: %s, closing netsock\n",
-			strerror(errno));
+		perror("can't get MAC address, closing netsock");
 		goto close;
 	}
 
@@ -330,8 +328,7 @@ int alfred_server(struct globals *globals)
 		ret = pselect(maxsock + 1, &fds, NULL, &errfds, &tv, NULL);
 
 		if (ret == -1) {
-			fprintf(stderr, "main loop select failed ...: %s\n",
-				strerror(errno));
+			perror("main loop select failed ...");
 		} else if (ret) {
 			if (globals->netsock >= 0 &&
 			    FD_ISSET(globals->netsock, &errfds)) {
diff --git a/unix_sock.c b/unix_sock.c
index fb7e391..cc0d25c 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -43,8 +43,7 @@ int unix_sock_open_daemon(struct globals *globals)
 
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
-		fprintf(stderr, "can't create unix socket: %s\n",
-			strerror(errno));
+		perror("can't create unix socket");
 		return -1;
 	}
 
@@ -55,14 +54,12 @@ int unix_sock_open_daemon(struct globals *globals)
 
 	if (bind(globals->unix_sock, (struct sockaddr *)&addr,
 		 sizeof(addr)) < 0) {
-		fprintf(stderr, "can't bind unix socket: %s\n",
-			strerror(errno));
+		perror("can't bind unix socket");
 		return -1;
 	}
 
 	if (listen(globals->unix_sock, 10) < 0) {
-		fprintf(stderr, "can't listen on unix socket: %s\n",
-			strerror(errno));
+		perror("can't listen on unix socket");
 		return -1;
 	}
 
@@ -75,8 +72,7 @@ int unix_sock_open_client(struct globals *globals)
 
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
-		fprintf(stderr, "can't create unix socket: %s\n",
-			strerror(errno));
+		perror("can't create unix socket");
 		return -1;
 	}
 
@@ -87,8 +83,7 @@ int unix_sock_open_client(struct globals *globals)
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
-		fprintf(stderr, "can't connect to unix socket: %s\n",
-			strerror(errno));
+		perror("can't connect to unix socket");
 		return -1;
 	}
 
@@ -315,16 +310,14 @@ int unix_sock_read(struct globals *globals)
 	client_sock = accept(globals->unix_sock, (struct sockaddr *)&sun_addr,
 			     &sun_size);
 	if (client_sock < 0) {
-		fprintf(stderr, "can't accept unix connection: %s\n",
-			strerror(errno));
+		perror("can't accept unix connection");
 		return -1;
 	}
 
 	/* we assume that we can instantly read here. */
 	length = read(client_sock, buf, sizeof(buf));
 	if (length <= 0) {
-		fprintf(stderr, "read from unix socket failed: %s\n",
-			strerror(errno));
+		perror("read from unix socket failed");
 		goto err;
 	}
 
diff --git a/vis/vis.c b/vis/vis.c
index 0cc4981..6cc4034 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -108,7 +108,7 @@ static int get_if_mac(char *ifname, uint8_t *mac)
 	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 
 	if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
-		fprintf(stderr, "can't get interface: %s\n", strerror(errno));
+		perror("can't get interface");
 		return -1;
 	}
 
@@ -117,7 +117,7 @@ static int get_if_mac(char *ifname, uint8_t *mac)
 	close(sock);
 
 	if (ret == -1) {
-		fprintf(stderr, "can't get MAC address: %s\n", strerror(errno));
+		perror("can't get MAC address");
 		return -1;
 	}
 
@@ -162,8 +162,7 @@ static int alfred_open_sock(struct globals *globals)
 
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
-		fprintf(stderr, "can't create unix socket: %s\n",
-			strerror(errno));
+		perror("can't create unix socket");
 		return -1;
 	}
 
@@ -174,8 +173,7 @@ static int alfred_open_sock(struct globals *globals)
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
-		fprintf(stderr, "can't connect to unix socket: %s\n",
-			strerror(errno));
+		perror("can't connect to unix socket");
 		return -1;
 	}
 
-- 
2.0.1

