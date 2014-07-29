Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 29 Jul 2014 14:06:54 +0200
Message-Id: <1406635614-28176-2-git-send-email-sven@narfation.org>
In-Reply-To: <1406635614-28176-1-git-send-email-sven@narfation.org>
References: <1406635614-28176-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Bind alfred to a specific device
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

It is necessary to bind the alfred process to a specific device to allow
multiple instances of it to run at the same time but on different network
interfaces. Just using the scope_id with IPv6 is not enough to bind only on
this specific network device. Also using a specific address+port would not work
because then the master announcements would not be received anymore.

The bind to device only works when the user has root privileges. Therefore,
alfred must now be started as root.

Reported-by: Tobias Hachmer <tobias@hachmer.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netsock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/netsock.c b/netsock.c
index a1a97e4..b59b7b7 100644
--- a/netsock.c
+++ b/netsock.c
@@ -52,7 +52,7 @@ int netsock_open(struct globals *globals)
 
 	globals->netsock = -1;
 
-	sock = socket(PF_INET6, SOCK_DGRAM, 0);
+	sock = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDP);
 	if (sock  < 0) {
 		perror("can't open socket");
 		return -1;
@@ -82,6 +82,12 @@ int netsock_open(struct globals *globals)
 	memcpy(&globals->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
 	mac_to_ipv6(&globals->hwaddr, &globals->address);
 
+	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE,
+		       globals->interface, strlen(globals->interface) + 1)) {
+		perror("can't bind to device");
+		goto err;
+	}
+
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
 		perror("can't bind");
 		goto err;
-- 
2.0.1

