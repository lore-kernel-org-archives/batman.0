Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1496459579.22954.6.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sat, 03 Jun 2017 05:12:59 +0200
In-Reply-To: <2479408.89UKcKX64H@prime>
References: <1496077749.5980.2.camel@gmail.com> <2479408.89UKcKX64H@prime>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: suppress implicit-fallthrough
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
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

__attribute__ ((fallthrough)) tells the compiler to not complain about
an intended fallthrough.





diff --git a/tp_meter.c b/tp_meter.c
index 918fb79..592a9ed 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -501,6 +501,7 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
 	case BATADV_TP_REASON_CANCEL:
 		printf("CANCEL received: test aborted\n");
 		/* fall through and print the partial result */
+		__attribute__ ((fallthrough));
 	case BATADV_TP_REASON_COMPLETE:
 		if (result.test_time > 0) {
 			throughput = result.total_bytes * 1000;

