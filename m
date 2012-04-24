Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 24 Apr 2012 10:47:09 +0200
Message-Id: <1335257230-14871-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1335257230-14871-1-git-send-email-ordex@autistici.org>
References: <1335257230-14871-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: opening function bracket
	must be on a new line
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index db1694d..3108cd3 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -37,7 +37,8 @@
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 
 static void bat_dbg_arp(struct bat_priv *bat_priv, struct sk_buff *skb,
-			uint16_t type, int hdr_size, char *msg) {
+			uint16_t type, int hdr_size, char *msg)
+{
 	struct unicast_4addr_packet *unicast_4addr_packet;
 
 	if (msg)
-- 
1.7.9.4

