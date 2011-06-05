Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2011 23:50:01 +0200
Message-Id: <1307310601-22560-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Remove unused but set variable in
	roam and tt dump functions
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
 tcpdump.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 3e68844..85d461e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -253,12 +253,10 @@ static void dump_vlan(unsigned char *packet_buff, ssize_t buff_len, int read_opt
 
 static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct ether_header *ether_header;
 	struct tt_query_packet *tt_query_packet;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct tt_query_packet), "BAT TT");
 
-	ether_header = (struct ether_header *)packet_buff;
 	tt_query_packet = (struct tt_query_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
@@ -280,12 +278,10 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 
 static void dump_batman_roam(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
-	struct ether_header *ether_header;
 	struct roam_adv_packet *roam_adv_packet;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct roam_adv_packet), "BAT ROAM");
 
-	ether_header = (struct ether_header *)packet_buff;
 	roam_adv_packet = (struct roam_adv_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
-- 
1.7.5.3

