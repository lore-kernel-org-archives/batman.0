Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 15 Jul 2014 04:23:27 +0200
Message-Id: <1405391008-5112-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: adding multicast debug level
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

This patch adds the multicast debug level to check for own
multicast flag changes for instance.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 README |    1 +
 sys.c  |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/README b/README
index b5fd259..c5e3575 100644
--- a/README
+++ b/README
@@ -389,6 +389,7 @@ $  batctl loglevel
 [ ] messages related to bridge loop avoidance (bla)
 [ ] messages related to arp snooping and distributed arp table (dat)
 [ ] messages related to network coding (nc)
+[ ] messages related to multicast (mcast)
 
 batctl nc_nodes
 ===============
diff --git a/sys.c b/sys.c
index 676bef1..4fa0e24 100644
--- a/sys.c
+++ b/sys.c
@@ -280,6 +280,7 @@ static void log_level_usage(void)
 	fprintf(stderr, " \t bla     Messages related to bridge loop avoidance\n");
 	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
 	fprintf(stderr, " \t nc      Messages related to network coding\n");
+	fprintf(stderr, " \t mcast   Messages related to multicast\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -325,6 +326,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= BIT(4);
 			else if (strcmp(argv[i], "nc") == 0)
 				log_level |= BIT(5);
+			else if (strcmp(argv[i], "mcast") == 0)
+				log_level |= BIT(6);
 			else {
 				log_level_usage();
 				goto out;
@@ -359,6 +362,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to arp snooping and distributed arp table", "dat");
 	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
 	       "messages related to network coding", "nc");
+	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
+	       "messages related to multicast", "mcast");
 
 out:
 	free(path_buff);
-- 
1.7.10.4

