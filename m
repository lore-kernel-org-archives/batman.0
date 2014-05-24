Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 14:16:43 +0200
Message-Id: <1400933804-9661-5-git-send-email-sven@narfation.org>
In-Reply-To: <1400933804-9661-1-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batctl: Initialize complete ping packet
	before write
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

The data structure for ping packets is not completely initialized by the
userspace because the kernel sets the originator address of the packet. This
is not only a bad practice but also irritate tools like valgrind.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ping.c       | 1 +
 traceroute.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ping.c b/ping.c
index 6642188..bdca222 100644
--- a/ping.c
+++ b/ping.c
@@ -176,6 +176,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 
 	packet_len = sizeof(struct batadv_icmp_packet);
 
+	memset(&icmp_packet_out, 0, sizeof(icmp_packet_out));
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.packet_type = BATADV_ICMP;
 	icmp_packet_out.version = BATADV_COMPAT_VERSION;
diff --git a/traceroute.c b/traceroute.c
index 22b90f2..4ebfec2 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -133,6 +133,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		goto out;
 	}
 
+	memset(&icmp_packet_out, 0, sizeof(icmp_packet_out));
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.version = BATADV_COMPAT_VERSION;
 	icmp_packet_out.packet_type = BATADV_ICMP;
-- 
2.0.0.rc2

