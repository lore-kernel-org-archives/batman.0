Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 12 Oct 2011 14:54:50 +0200
Message-Id: <1318424090-22862-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1318249725-19865-1-git-send-email-ordex@autistici.org>
References: <1318249725-19865-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use orig_hash_find() instead
	of get_orig_node() in TT code
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

get_orig_node() tries to retrieves an orig_node object and possibly creates it if
not present. This is not the wanted behaviours in the translation-table code,
instead we want to get the orig_node only if it really exists, without creating
it.

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 7de9960..6102cd2 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1170,11 +1170,11 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		(tt_request->flags & TT_FULL_TABLE ? 'F' : '.'));
 
 	/* Let's get the orig node of the REAL destination */
-	req_dst_orig_node = get_orig_node(bat_priv, tt_request->dst);
+	req_dst_orig_node = orig_hash_find(bat_priv, tt_request->dst);
 	if (!req_dst_orig_node)
 		goto out;
 
-	res_dst_orig_node = get_orig_node(bat_priv, tt_request->src);
+	res_dst_orig_node = orig_hash_find(bat_priv, tt_request->src);
 	if (!res_dst_orig_node)
 		goto out;
 
@@ -1300,7 +1300,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 	my_ttvn = (uint8_t)atomic_read(&bat_priv->ttvn);
 	req_ttvn = tt_request->ttvn;
 
-	orig_node = get_orig_node(bat_priv, tt_request->src);
+	orig_node = orig_hash_find(bat_priv, tt_request->src);
 	if (!orig_node)
 		goto out;
 
-- 
1.7.3.4

