Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Nov 2014 18:58:28 +0100
Message-Id: <1415815109-17111-4-git-send-email-sven@narfation.org>
In-Reply-To: <1415815109-17111-1-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batctl: Parse non-variable TVLV only
	with correct length
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

The TVLV length has to be verified before the tvlv parser can start. Otherwise
the tvlv parser might access invalid data.

Doing the same for zero length TVLVs is just good practice and might help
finding problems easier.

This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
("batctl: tcpdump - parse TVLV containers").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 443f671..361deb3 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -100,12 +100,17 @@ static int print_time(void)
 	return 1;
 }
 
-static void batctl_tvlv_parse_gw_v1(void *buff,
-				    ssize_t (buff_len)__attribute__((unused)))
+static void batctl_tvlv_parse_gw_v1(void *buff, ssize_t buff_len)
 {
 	struct batadv_tvlv_gateway_data *tvlv = buff;
 	uint32_t down, up;
 
+	if (buff_len != sizeof(*tvlv)) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (%zu): %zu\n",
+			"TVLV GWv1", sizeof(*tvlv), buff_len);
+		return;
+	}
+
 	down = ntohl(tvlv->bandwidth_down);
 	up = ntohl(tvlv->bandwidth_up);
 
@@ -114,14 +119,26 @@ static void batctl_tvlv_parse_gw_v1(void *buff,
 }
 
 static void batctl_tvlv_parse_dat_v1(void (*buff)__attribute__((unused)),
-				     ssize_t (buff_len)__attribute__((unused)))
+				     ssize_t buff_len)
 {
+	if (buff_len != 0) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (0): %zu\n",
+			"TVLV DATv1", buff_len);
+		return;
+	}
+
 	printf("\tTVLV DATv1: enabled\n");
 }
 
 static void batctl_tvlv_parse_nc_v1(void (*buff)__attribute__((unused)),
-				    ssize_t (buff_len)__attribute__((unused)))
+				    ssize_t buff_len)
 {
+	if (buff_len != 0) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (0): %zu\n",
+			"TVLV NCv1", buff_len);
+		return;
+	}
+
 	printf("\tTVLV NCv1: enabled\n");
 }
 
@@ -159,11 +176,16 @@ static void batctl_tvlv_parse_tt_v1(void *buff,
 	}
 }
 
-static void batctl_tvlv_parse_roam_v1(void *buff,
-				      ssize_t (buff_len)__attribute__((unused)))
+static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len)
 {
 	struct batadv_tvlv_roam_adv *tvlv = buff;
 
+	if (buff_len != sizeof(*tvlv)) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (%zu): %zu\n",
+			"TVLV ROAMv1", sizeof(*tvlv), buff_len);
+		return;
+	}
+
 	printf("\tTVLV ROAMv1: client %s, VLAN ID %d\n",
 	       get_name_by_macaddr((struct ether_addr *)tvlv->client, NO_FLAGS),
 	       BATADV_PRINT_VID(ntohs(tvlv->vid)));
-- 
2.1.3

