Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 12 Apr 2016 10:51:27 +0200
Message-Id: <1460451087-18450-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - Add support for bla
	loopdetect
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Complex bridge loop detection was added to batman-adv. It uses so called
BLA LOOPDETECT ARP packets to find out if there is a loop. The bla2 claim
function of tcpdump extracts the same information which also
batadv_bla_send_claim uses for its debug output.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 packet.h  | 1 +
 tcpdump.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/packet.h b/packet.h
index 0796dfd..372128d 100644
--- a/packet.h
+++ b/packet.h
@@ -175,6 +175,7 @@ enum batadv_bla_claimframe {
 	BATADV_CLAIM_TYPE_UNCLAIM	= 0x01,
 	BATADV_CLAIM_TYPE_ANNOUNCE	= 0x02,
 	BATADV_CLAIM_TYPE_REQUEST	= 0x03,
+	BATADV_CLAIM_TYPE_LOOPDETECT	= 0x04,
 };
 
 /**
diff --git a/tcpdump.c b/tcpdump.c
index a30e34b..e969d7d 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -366,6 +366,12 @@ static int dump_bla2_claim(struct ether_header *eth_hdr,
 		printf("dst backbone %s\n",
 		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_dhost, read_opt));
 		break;
+	case BATADV_CLAIM_TYPE_LOOPDETECT:
+		printf("BLA LOOPDETECT, src backbone %s, ",
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_shost, read_opt));
+		printf("dst backbone %s\n",
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_dhost, read_opt));
+		break;
 	default:
 		printf("BLA UNKNOWN, type %hhu\n", bla_dst->type);
 		break;
-- 
2.8.0.rc3

