Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 17 May 2013 18:02:21 +0200
Message-Id: <1368806541-1713-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix typos in error messages
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bisect_iv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index f958511..0dbc2ef 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1525,13 +1525,13 @@ int bisect_iv(int argc, char **argv)
 	num_parsed_files = 0;
 
 	if ((rt_orig_ptr) && (trace_orig_ptr)) {
-		fprintf(stderr, "Error - the 'print routing table' option can't be used together with the the 'trace seqno' option\n");
+		fprintf(stderr, "Error - the 'print routing table' option can't be used together with the 'trace seqno' option\n");
 		goto err;
 	} else if ((loop_orig_ptr) && (trace_orig_ptr)) {
-		fprintf(stderr, "Error - the 'loop detection' option can't be used together with the the 'trace seqno' option\n");
+		fprintf(stderr, "Error - the 'loop detection' option can't be used together with the 'trace seqno' option\n");
 		goto err;
 	} else if ((loop_orig_ptr) && (rt_orig_ptr)) {
-		fprintf(stderr, "Error - the 'loop detection' option can't be used together with the the 'print routing table' option\n");
+		fprintf(stderr, "Error - the 'loop detection' option can't be used together with the 'print routing table' option\n");
 		goto err;
 	} else if (rt_orig_ptr) {
 		res = get_orig_addr(rt_orig_ptr, orig);
-- 
1.8.1.5

