Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Nov 2014 18:58:29 +0100
Message-Id: <1415815109-17111-5-git-send-email-sven@narfation.org>
In-Reply-To: <1415815109-17111-1-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batctl: Only parse big enough TVLV TTv1
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
Cc: Sven Eckelmann <sven@narfation.org>

A TTv1 has a constant header part and two variable parts. One is the defined by
the number of VLANs and the rest are the changes. The TVLV can only be parsed
when there is enough room for the constant header. Also the number of VLANs
must be validated. Otherwise the TVLV parser can read invalid data outside of
the buffer.

This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
("batctl: tcpdump - parse TVLV containers").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 361deb3..50ba010 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -142,13 +142,15 @@ static void batctl_tvlv_parse_nc_v1(void (*buff)__attribute__((unused)),
 	printf("\tTVLV NCv1: enabled\n");
 }
 
-static void batctl_tvlv_parse_tt_v1(void *buff,
-				    ssize_t (buff_len)__attribute__((unused)))
+static void batctl_tvlv_parse_tt_v1(void *buff, ssize_t buff_len)
 {
 	struct batadv_tvlv_tt_data *tvlv = buff;
 	struct batadv_tvlv_tt_vlan_data *vlan;
 	int i, num_vlan, num_entry;
 	const char *type;
+	size_t vlan_len;
+
+	LEN_CHECK(buff_len, sizeof(*tvlv), "TVLV TTv1")
 
 	if (tvlv->flags & BATADV_TT_OGM_DIFF)
 		type = "OGM DIFF";
@@ -160,7 +162,10 @@ static void batctl_tvlv_parse_tt_v1(void *buff,
 		type = "UNKNOWN";
 
 	num_vlan = ntohs(tvlv->num_vlan);
-	buff_len -= sizeof(*tvlv) + sizeof(*vlan) * num_vlan;
+	vlan_len = sizeof(*tvlv) + sizeof(*vlan) * num_vlan;
+	LEN_CHECK(buff_len, vlan_len, "TVLV TTv1 VLAN")
+
+	buff_len -= vlan_len;
 	num_entry = buff_len / sizeof(struct batadv_tvlv_tt_change);
 
 	printf("\tTVLV TTv1: %s [%c] ttvn=%hhu vlan_num=%hu entry_num=%hu\n",
-- 
2.1.3

