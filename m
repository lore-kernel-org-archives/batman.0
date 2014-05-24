Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 15:56:17 +0200
Message-Id: <1400939778-12886-2-git-send-email-sven@narfation.org>
In-Reply-To: <1400939778-12886-1-git-send-email-sven@narfation.org>
References: <1400939778-12886-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Free hash iterator when breaking
	out of loop
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

The hash iterator is automatically allocated and freed by the hash_iterate
function. But when using break (or goto outside of loop) during the iteration
loop, the caller has to handle the free-operation of the hash_iterator to avoid
memory leaks.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index e9e7326..7105c78 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1304,8 +1304,10 @@ static void trace_seqnos(char *trace_orig, long long seqno_min, long long seqno_
 
 				res = seqno_trace_add(&trace_list, bat_node, seqno_event, print_trace);
 
-				if (res < 1)
+				if (res < 1) {
+					hash_iterate_free(hashit);
 					goto out;
+				}
 			}
 		}
 	}
-- 
2.0.0.rc2

