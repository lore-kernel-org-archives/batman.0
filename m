Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  8 May 2011 12:45:46 +0200
Message-Id: <1304851546-16549-2-git-send-email-sven@narfation.org>
In-Reply-To: <1304851546-16549-1-git-send-email-sven@narfation.org>
References: <1304851546-16549-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Remove multiline comments from
	line ending
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 packet.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/packet.h b/packet.h
index c225c3a..eda9965 100644
--- a/packet.h
+++ b/packet.h
@@ -128,8 +128,7 @@ struct vis_packet {
 	uint8_t  entries;	 /* number of entries behind this struct */
 	uint32_t seqno;		 /* sequence number */
 	uint8_t  ttl;		 /* TTL */
-	uint8_t  vis_orig[6];	 /* originator that informs about its
-				  * neighbors */
+	uint8_t  vis_orig[6];	 /* originator that announces its neighbors */
 	uint8_t  target_orig[6]; /* who should receive this packet */
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
 } __packed;
-- 
1.7.5.1

