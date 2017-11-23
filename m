Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:35 +0100
Message-Id: <20171123140444.17119-2-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 01/10] batctl: Print dummy value when
 localtime failed
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

localtime can return NULL when the local time could not be calculated.
Accessing this NULL pointer is not allowed.

Fixes: 05f27bfcd302 ("add arp packets , change output")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 tcpdump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 4ede76b..5eb99cf 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -104,7 +104,11 @@ static int print_time(void)
 	gettimeofday(&tv, NULL);
 	tm = localtime(&tv.tv_sec);
 
-	printf("%02d:%02d:%02d.%06ld ", tm->tm_hour, tm->tm_min, tm->tm_sec, tv.tv_usec);
+	if (tm)
+		printf("%02d:%02d:%02d.%06ld ", tm->tm_hour, tm->tm_min, tm->tm_sec, tv.tv_usec);
+	else
+		printf("00:00:00.000000 ");
+
 	return 1;
 }
 
-- 
2.11.0

