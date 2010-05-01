Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  1 May 2010 15:46:16 +0200
Message-Id: <1272721576-9372-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005011533.41592.sven.eckelmann@gmx.de>
References: <201005011533.41592.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: send.c: Checkpatch
	cleanup
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

From: Andrea Gelmini <andrea.gelmini@gelma.net>

drivers/staging/batman-adv/send.c:137: CHECK: multiple assignments should be avoided

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/batman-adv/send.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 2a9fac8..ff7b1f1 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -134,7 +134,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	if (batman_if->if_active != IF_ACTIVE)
 		return;
 
-	packet_num = buff_pos = 0;
+	packet_num = 0;
+	buff_pos = 0;
 	batman_packet = (struct batman_packet *)
 		(forw_packet->packet_buff);
 
-- 
1.7.1

