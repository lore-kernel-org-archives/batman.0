Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 28 Apr 2013 12:00:29 +0200
Message-Id: <1367143229-12043-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH master] batman-adv: remove white spaces at
	the beginning of the lines
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
Cc: Antonio Quartulli <ordex@autistici.org>

Intiroduced by: 3bcf1e15714b78e8581ccbf4724cda9e20ac4aa4
("batman-adv: reorder packet types")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packet.h b/packet.h
index 559c738..7d45890 100644
--- a/packet.h
+++ b/packet.h
@@ -34,7 +34,7 @@
  * @BATADV_ICMP: unicast packet like IP ICMP used for ping or traceroute
  * @BATADV_UNICAST_TVLV: unicast packet carrying TVLV containers
  */
- enum batadv_packettype {
+enum batadv_packettype {
 	/* 0x00 - 0x3f: local packets or special rules for handling */
 	BATADV_IV_OGM           = 0x00,
 	BATADV_BCAST            = 0x01,
@@ -80,7 +80,7 @@ enum batadv_iv_flags {
 	BATADV_NOT_BEST_NEXT_HOP   = BIT(0),
 	BATADV_PRIMARIES_FIRST_HOP = BIT(1),
 	BATADV_DIRECTLINK          = BIT(2),
- };
+};
 
 /* ICMP message types */
 enum batadv_icmp_packettype {
-- 
1.8.1.5

