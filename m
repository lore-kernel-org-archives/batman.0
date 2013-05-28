Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 28 May 2013 14:06:06 +0200
Message-Id: <1369742766-3083-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix network order complaints in
	the TVLV code
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
Cc: Antonio Quartulli <ordex@autistici.org>

Intorduced by 1ab746a3f2441d3466592b86134fbc72a9fe0558
("batman-adv: properly align tvlv infrastructure")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/main.c b/main.c
index 9df71bc..1192e61 100644
--- a/main.c
+++ b/main.c
@@ -630,7 +630,7 @@ static uint16_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 
 	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
 		tvlv_len += sizeof(struct batadv_tvlv_hdr);
-		tvlv_len += tvlv->tvlv_hdr.len;
+		tvlv_len += ntohs(tvlv->tvlv_hdr.len);
 	}
 
 	return tvlv_len;
@@ -701,9 +701,9 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 
 	tvlv_new->tvlv_hdr.version = version;
 	tvlv_new->tvlv_hdr.type = type;
-	tvlv_new->tvlv_hdr.len = tvlv_value_len;
+	tvlv_new->tvlv_hdr.len = htons(tvlv_value_len);
 
-	memcpy(tvlv_new + 1, tvlv_value, tvlv_new->tvlv_hdr.len);
+	memcpy(tvlv_new + 1, tvlv_value, ntohs(tvlv_new->tvlv_hdr.len));
 	INIT_HLIST_NODE(&tvlv_new->list);
 	atomic_set(&tvlv_new->refcount, 1);
 
@@ -790,10 +790,10 @@ uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 		tvlv_hdr = tvlv_value;
 		tvlv_hdr->type = tvlv->tvlv_hdr.type;
 		tvlv_hdr->version = tvlv->tvlv_hdr.version;
-		tvlv_hdr->len = htons(tvlv->tvlv_hdr.len);
+		tvlv_hdr->len = tvlv->tvlv_hdr.len;
 		tvlv_value = tvlv_hdr + 1;
-		memcpy(tvlv_value, tvlv + 1, tvlv->tvlv_hdr.len);
-		tvlv_value = (uint8_t *)tvlv_value + tvlv->tvlv_hdr.len;
+		memcpy(tvlv_value, tvlv + 1, ntohs(tvlv->tvlv_hdr.len));
+		tvlv_value = (uint8_t *)tvlv_value + ntohs(tvlv->tvlv_hdr.len);
 	}
 
 end:
-- 
1.8.1.5

