Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  6 Aug 2014 16:34:03 +0200
Message-Id: <1407335643-2124-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix backbone address in tcpdump for
	bla request frames
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

hw_src just contains another copy of the destination. The backbone
sending the request is setting its mac address into Ethernet source, so
print that instead.

For reference, see the documentation:
http://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-Protocol

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 tcpdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index e84617e..ada8938 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -148,7 +148,7 @@ static int dump_bla2_claim(struct ether_header *eth_hdr,
 		break;
 	case BATADV_CLAIM_TYPE_REQUEST:
 		printf("BLA REQUEST, src backbone %s, ",
-		       get_name_by_macaddr((struct ether_addr *)hw_src, read_opt));
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_shost, read_opt));
 		printf("dst backbone %s\n",
 		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_dhost, read_opt));
 		break;
-- 
1.9.1

