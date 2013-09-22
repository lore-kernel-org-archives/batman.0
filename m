Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 20:08:25 +0200
Message-Id: <1379873305-1292-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix usage and declaration
	of batadv_bandwidth_units
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Name in declaration does not reflect the one reporte din the kernel doc.
Moreover a variable storing an enum should be of type enum rather than
int (this helps the compiler to spott possible mistakes)

Introduced by 0853ec7fafe0a195754454832993c6b35e22b842
("batman-adv: tvlv - gateway download/upload bandwidth container")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 gateway_common.c | 3 ++-
 gateway_common.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gateway_common.c b/gateway_common.c
index ab9a5ac..b211b0f 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -34,9 +34,10 @@
 static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 				      uint32_t *down, uint32_t *up)
 {
-	int ret, bw_unit_type = BATADV_BW_UNIT_KBIT;
+	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
 	char *slash_ptr, *tmp_ptr;
 	long ldown, lup;
+	int ret;
 
 	slash_ptr = strchr(buff, '/');
 	if (slash_ptr)
diff --git a/gateway_common.h b/gateway_common.h
index 368d50e..56384a4 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -31,7 +31,7 @@ enum batadv_gw_modes {
  * @BATADV_BW_UNIT_KBIT: unit type kbit
  * @BATADV_BW_UNIT_MBIT: unit type mbit
  */
-enum batadv_bandwidth_types {
+enum batadv_bandwidth_units {
 	BATADV_BW_UNIT_KBIT,
 	BATADV_BW_UNIT_MBIT,
 };
-- 
1.8.1.5

