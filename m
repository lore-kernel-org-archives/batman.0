Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 10 Nov 2014 08:41:31 +0100
Message-Id: <1415605291-2060-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add missing break
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Reaported-by: Coverity Scan
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 tcpdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcpdump.c b/tcpdump.c
index ad5469b..71e2dd9 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -839,6 +839,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		case BATADV_UNICAST_4ADDR:
 			if (dump_level & DUMP_TYPE_BATUCAST)
 				dump_batman_4addr(packet_buff, buff_len, read_opt, time_printed);
+			break;
 		case BATADV_UNICAST_TVLV:
 			if ((dump_level & DUMP_TYPE_BATUCAST) ||
 			    (dump_level & DUMP_TYPE_BATUTVLV))
-- 
2.1.3

