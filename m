Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  5 Jul 2017 17:15:10 +0200
Message-Id: <20170705151510.23366-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Fix error message when tcpdump
 packet sent failed
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

The strerror converts the positive error code into a string. tcpdump must
therefore convert the negative return code from icmp_interface_write into a
positive one before using it as parameter for strerror.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 traceroute.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/traceroute.c b/traceroute.c
index 124ce7c..79d3800 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -150,7 +150,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 					   (struct batadv_icmp_header *)&icmp_packet_out,
 					   sizeof(icmp_packet_out));
 			if (res < 0) {
-				fprintf(stderr, "Error - can't send icmp packet: %s\n", strerror(res));
+				fprintf(stderr, "Error - can't send icmp packet: %s\n", strerror(-res));
 				continue;
 			}
 
-- 
2.11.0

