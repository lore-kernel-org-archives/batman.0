Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Apr 2012 13:15:27 +0200
Message-Id: <1334402127-5211-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1334402127-5211-1-git-send-email-ordex@autistici.org>
References: <1334402127-5211-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: convert the tt_crc to
	network order
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

Before sending out a TT_Request packet we must convert the tt_crc field value
to network order (since it is 16bits long).

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 72dfbe1..88e4c8e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1341,7 +1341,7 @@ static int send_tt_request(struct bat_priv *bat_priv,
 	memcpy(tt_request->dst, dst_orig_node->orig, ETH_ALEN);
 	tt_request->header.ttl = TTL;
 	tt_request->ttvn = ttvn;
-	tt_request->tt_data = tt_crc;
+	tt_request->tt_data = htons(tt_crc);
 	tt_request->flags = TT_REQUEST;
 
 	if (full_table)
-- 
1.7.9.4

