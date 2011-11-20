Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Nov 2011 16:35:16 +0100
Message-Id: <1321803316-18872-1-git-send-email-sven@narfation.org>
In-Reply-To: <CAFevQmPcoR3O5FHfHvuUkv4yrJMYd1MtsEMNZ24uwjXaUtXxeQ@mail.gmail.com>
References: <CAFevQmPcoR3O5FHfHvuUkv4yrJMYd1MtsEMNZ24uwjXaUtXxeQ@mail.gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Return failure code when ping was
	not successful
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

The standard iputils-ping returns an error code when it could not receive a
single reply to a echo request. batctl ping behaved differently and made it
only possible to detect that the target is not reachable by parsing the text
output of batctl.

A new return code EXIT_NOSUCCESS (2) is introduced to distinguish a general
failure from the inability to reach another node.

Reported-by: Filippo Sallemi <tonyputi@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h |    2 ++
 ping.c |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/main.h b/main.h
index e5a3e01..fb7ca38 100644
--- a/main.h
+++ b/main.h
@@ -25,4 +25,6 @@
 
 #define SOCKET_PATH_FMT "%s/batman_adv/%s/socket"
 
+#define EXIT_NOSUCCESS 2
+
 #define __packed __attribute((packed))   /* linux kernel compat */
diff --git a/ping.c b/ping.c
index 91b733a..1b715f3 100644
--- a/ping.c
+++ b/ping.c
@@ -322,7 +322,10 @@ sleep:
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
 		min, avg, max, mdev);
 
-	ret = EXIT_SUCCESS;
+	if (packets_in)
+		ret = EXIT_SUCCESS;
+	else
+		ret = EXIT_NOSUCCESS;
 
 out:
 	bat_hosts_free();
-- 
1.7.7.3

