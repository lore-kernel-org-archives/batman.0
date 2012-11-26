Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 26 Nov 2012 10:50:17 +0100
Message-Id: <1353923417-29900-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: use ETH_P_BATMAN
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

ETH_P_BATMAN is now defined in linux/if_ether.h. batctl does not need
to use the private BATADV_ETH_P_BATMAN define.
However, depending on the kernel-headers version installed on the
system, this new constant may not be available, therefore a redefinition
inside an ifndef check is needed.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h  | 2 --
 tcpdump.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/packet.h b/packet.h
index 1c5454d..cb6405b 100644
--- a/packet.h
+++ b/packet.h
@@ -20,8 +20,6 @@
 #ifndef _NET_BATMAN_ADV_PACKET_H_
 #define _NET_BATMAN_ADV_PACKET_H_
 
-#define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
-
 enum batadv_packettype {
 	BATADV_IV_OGM		= 0x01,
 	BATADV_ICMP		= 0x02,
diff --git a/tcpdump.c b/tcpdump.c
index 84abd74..4424dfd 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -43,6 +43,9 @@
 #include "bat-hosts.h"
 #include "functions.h"
 
+#ifndef ETH_P_BATMAN
+#define ETH_P_BATMAN	0x4305
+#endif /* ETH_P_BATMAN */
 
 #define LEN_CHECK(buff_len, check_len, desc) \
 if ((size_t)(buff_len) < (check_len)) { \
@@ -587,7 +590,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
 			dump_vlan(packet_buff, buff_len, read_opt, time_printed);
 		break;
-	case BATADV_ETH_P_BATMAN:
+	case ETH_P_BATMAN:
 		batman_ogm_packet = (struct batadv_ogm_packet *)(packet_buff + ETH_HLEN);
 
 		if ((read_opt & COMPAT_FILTER) &&
-- 
1.8.0

