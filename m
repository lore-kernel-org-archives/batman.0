Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Nov 2012 14:21:11 +0100
Message-Id: <1352380871-13610-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352379248-31144-1-git-send-email-ordex@autistici.org>
References: <1352379248-31144-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: correctly pass the client flag
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

When a TT response with the full table is sent, the client flags
should be sent as well. This patch fix the flags assignment when
populating the tt_response to send back

This was introduced by ("batman-adv: detect not yet announced clients")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
v2:
 - added missing BATADV_
v3:
 - instead of passing the WIFI flag only, we now pass all the flags

 translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 64c0012..fec1a00 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1502,7 +1502,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 
 			memcpy(tt_change->addr, tt_common_entry->addr,
 			       ETH_ALEN);
-			tt_change->flags = BATADV_NO_FLAGS;
+			tt_change->flags = tt_common_entry->flags;
 
 			tt_count++;
 			tt_change++;
-- 
1.8.0

