Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 14 Apr 2016 17:29:58 +0800
Message-Id: <1460626198-31226-2-git-send-email-a@unstable.cc>
In-Reply-To: <1460626198-31226-1-git-send-email-a@unstable.cc>
References: <1460626198-31226-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: tcpdump - use proper format
	string when printing help message
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
Cc: Antonio Quartulli <a@unstable.cc>, Antonio Quartulli <antonio@open-mesh.com>

this patch fixes warning like this

tcpdump.c:86:18: warning: format ‘%d’ expects argument of type ‘int’, but
argument 3 has type ‘long unsigned int’ [-Wformat=]

when comiling with gcc-5.3

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 tcpdump.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 745f5d4..a036b93 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -83,16 +83,16 @@ static void tcpdump_usage(void)
 	fprintf(stderr, " \t -p dump specific packet type\n");
 	fprintf(stderr, " \t -x dump all packet types except specified\n");
 	fprintf(stderr, "packet types:\n");
-	fprintf(stderr, " \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
-	fprintf(stderr, " \t\t%3d - batman ogmv2 packets\n", DUMP_TYPE_BATOGM2);
-	fprintf(stderr, " \t\t%3d - batman elp packets\n", DUMP_TYPE_BATELP);
-	fprintf(stderr, " \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
-	fprintf(stderr, " \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
-	fprintf(stderr, " \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
-	fprintf(stderr, " \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
-	fprintf(stderr, " \t\t%3d - batman unicast tvlv packets\n", DUMP_TYPE_BATUTVLV);
-	fprintf(stderr, " \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
-	fprintf(stderr, " \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
+	fprintf(stderr, " \t\t%3lu - batman ogm packets\n", DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3lu - batman ogmv2 packets\n", DUMP_TYPE_BATOGM2);
+	fprintf(stderr, " \t\t%3lu - batman elp packets\n", DUMP_TYPE_BATELP);
+	fprintf(stderr, " \t\t%3lu - batman icmp packets\n", DUMP_TYPE_BATICMP);
+	fprintf(stderr, " \t\t%3lu - batman unicast packets\n", DUMP_TYPE_BATUCAST);
+	fprintf(stderr, " \t\t%3lu - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
+	fprintf(stderr, " \t\t%3lu - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
+	fprintf(stderr, " \t\t%3lu - batman unicast tvlv packets\n", DUMP_TYPE_BATUTVLV);
+	fprintf(stderr, " \t\t%3lu - non batman packets\n", DUMP_TYPE_NONBAT);
+	fprintf(stderr, " \t\t%3lu - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
 }
 
 static int print_time(void)
-- 
2.8.1

