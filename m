Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:14 +0200
Message-Id: <1380628934-22220-7-git-send-email-sven@open-mesh.com>
In-Reply-To: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
References: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] alfred: Remove unused check for device
	MTU
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

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 netsock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/netsock.c b/netsock.c
index bed62e9..dc57b3c 100644
--- a/netsock.c
+++ b/netsock.c
@@ -80,11 +80,6 @@ int netsock_open(struct globals *globals)
 	memcpy(&globals->hwaddr, &ifr.ifr_hwaddr.sa_data, 6);
 	mac_to_ipv6(&globals->hwaddr, &globals->address);
 
-	if (ioctl(sock, SIOCGIFMTU, &ifr) == -1) {
-		fprintf(stderr, "can't get MTU: %s\n", strerror(errno));
-		goto err;
-	}
-
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
 		fprintf(stderr, "can't bind\n");
 		goto err;
-- 
1.8.4.rc3

