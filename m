Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Nov 2012 13:54:08 +0100
Message-Id: <1352379248-31144-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352328739-10667-1-git-send-email-ordex@autistici.org>
References: <1352328739-10667-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: correctly pass the WIFI flag
	on tt_response
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

When a TT response with the full table is sent, attribue flags should
be sent as well. This patch fix the flags assignment when populating
the tt_response to send back

This was introduced by ("batman-adv: detect not yet announced clients")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 64c0012..dde3724 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1469,6 +1469,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	ssize_t tt_query_size = sizeof(struct batadv_tt_query_packet);
 	uint32_t i;
 	size_t len;
+	uint8_t flags;
 
 	if (tt_query_size + tt_len > primary_if->soft_iface->mtu) {
 		tt_len = primary_if->soft_iface->mtu - tt_query_size;
@@ -1502,7 +1503,8 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 
 			memcpy(tt_change->addr, tt_common_entry->addr,
 			       ETH_ALEN);
-			tt_change->flags = BATADV_NO_FLAGS;
+			flags = tt_common_entry->flags | BATADV_TT_CLIENT_WIFI;
+			tt_change->flags = flags;
 
 			tt_count++;
 			tt_change++;
-- 
1.8.0

