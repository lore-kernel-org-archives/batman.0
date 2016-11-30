Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 30 Nov 2016 21:47:09 +0100
Message-Id: <20161130204709.16257-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Check for alloc errors
	when preparing TT local data
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
Cc: a@unstable.cc

batadv_tt_prepare_tvlv_local_data can fail to allocate the memory for the
new TVLV block. The caller is informed about this problem with the returned
length of 0. Not checking this value results in an invalid memory access
when either tt_data or tt_change is accessed.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
The very good report from Dan Carpenter can be found at
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016713.html

 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7f66309..0dc85eb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3282,7 +3282,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 							     &tvlv_tt_data,
 							     &tt_change,
 							     &tt_len);
-		if (!tt_len)
+		if (!tt_len || !tvlv_len)
 			goto unlock;
 
 		/* Copy the last orig_node's OGM buffer */
@@ -3300,7 +3300,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 							     &tvlv_tt_data,
 							     &tt_change,
 							     &tt_len);
-		if (!tt_len)
+		if (!tt_len || !tvlv_len)
 			goto out;
 
 		/* fill the rest of the tvlv with the real TT entries */
-- 
2.10.2

