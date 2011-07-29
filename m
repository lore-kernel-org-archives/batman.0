Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 29 Jul 2011 18:32:45 +0200
Message-Id: <1311957165-16335-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: reuse tt_len() to calculate tt
	buffer length
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 aggregation.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/aggregation.h b/aggregation.h
index 216337b..df4a5a9 100644
--- a/aggregation.h
+++ b/aggregation.h
@@ -28,8 +28,7 @@
 static inline int aggregated_packet(int buff_pos, int packet_len,
 				    int tt_num_changes)
 {
-	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (tt_num_changes *
-						sizeof(struct tt_change));
+	int next_buff_pos = buff_pos + BAT_PACKET_LEN + tt_len(tt_num_changes);
 
 	return (next_buff_pos <= packet_len) &&
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
-- 
1.7.5.3

