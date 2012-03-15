Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 15 Mar 2012 17:48:35 +0100
Message-Id: <1331830115-16407-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add BAT_UNICAST_4ADDR handler in
	the packet-handlers array
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

Commit 1887248c268928ebb434edab611978f51e2a4b8f introduced the packet-handlers
array but it forgot to set a proper handler for the BAT_UNICAST_4ADDR packet
type. This patch fixes it.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/main.c b/main.c
index 75938fb..0757c2d 100644
--- a/main.c
+++ b/main.c
@@ -265,6 +265,8 @@ static void recv_handler_init(void)
 
 	/* batman icmp packet */
 	recv_packet_handler[BAT_ICMP] = recv_icmp_packet;
+	/* unicast with 4 addresses packet */
+	recv_packet_handler[BAT_UNICAST_4ADDR] = recv_unicast_packet;
 	/* unicast packet */
 	recv_packet_handler[BAT_UNICAST] = recv_unicast_packet;
 	/* fragmented unicast packet */
-- 
1.7.3.4

