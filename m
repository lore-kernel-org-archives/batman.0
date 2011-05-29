Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 29 May 2011 20:54:31 +0200
Message-Id: <1306695271-8749-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: send_*_tt_response() has to
	initialise the ttl field
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

send_*_tt_response() didn't properly initialise the ttl field of the
tt_response message.

This error was introduced with: cea194d90b11aff7fc289149e4c7f305fad3535a

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index f0d8857..f04ab9b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1132,6 +1132,7 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 
 	tt_response->packet_type = BAT_TT_QUERY;
 	tt_response->version = COMPAT_VERSION;
+	tt_response->ttl = TTL;
 	memcpy(tt_response->src, req_dst_orig_node->orig, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
 	tt_response->tt_data = htons(tt_tot);
@@ -1280,6 +1281,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 
 	tt_response->packet_type = BAT_TT_QUERY;
 	tt_response->version = COMPAT_VERSION;
+	tt_response->ttl = TTL;
 	memcpy(tt_response->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
 	tt_response->tt_data = htons(tt_tot);
-- 
1.7.3.4

