Return-Path: <philipp.psurek@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 13 Jun 2017 13:08:24 +0200
Message-Id: <20170613110824.27786-2-philipp.psurek@gmail.com>
In-Reply-To: <20170613110824.27786-1-philipp.psurek@gmail.com>
References: <20170613103916.27299-1-philipp.psurek@gmail.com>
 <20170613110824.27786-1-philipp.psurek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: suppress implicit-fallthrough
 compiler warning
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

GCC 7.1.0 complains about an intended fallthrough.
“__attribute__ ((fallthrough))” in this part of code would suppress this
warning. Because older GCC compiler don’t understand this statement attribute
and because there is already a comment in the source containing
“falls?[ \t-]*thr(ough|u)” we can suppress the warning with the
“-Wimplicit-fallthrough=2” warning option. Unintended fallthroughs without a
comment would trigger this warning again.

To avoid compiler recognition in the Makefile a simply change of the comment
is sufficient to suppress the warning. For some reason only stand alone
comments mentioned in [1] are recognized so the comment has to be split up into
two parts.

[1] https://gcc.gnu.org/onlinedocs/gcc-7.1.0/gcc/Warning-Options.html#index-Wimplicit-fallthrough_003d

Signed-off-by: Philipp Psurek <philipp.psurek@gmail.com>
---
 tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tp_meter.c b/tp_meter.c
index 918fb79..eb67ba1 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -500,7 +500,7 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
 		break;
 	case BATADV_TP_REASON_CANCEL:
 		printf("CANCEL received: test aborted\n");
-		/* fall through and print the partial result */
+		/* fall through *//* and print the partial result */
 	case BATADV_TP_REASON_COMPLETE:
 		if (result.test_time > 0) {
 			throughput = result.total_bytes * 1000;
-- 
2.13.0

