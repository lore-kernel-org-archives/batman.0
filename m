Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Nov 2014 18:58:25 +0100
Message-Id: <1415815109-17111-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batctl: Fix crash when parsing unknown
	TVLVs
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

batctl tcpdump has an array with all known TVLVs and versions. The correct
parser for the TVLV is chosen by getting the pointer from the address
calculated by version and type. Unfortunately, the version and type was never
validated to ensure that not an unknown TVLV (like mcast) was received.

This missing validation makes it possible to crash batctl by injecting packets
with an unknown type and/or version. batctl will try to get the parser, fetch a
NULL pointer or random data and then try to dereferenced it. This is usually
handled by the operating system with a segfault. But this might be exploitable
in rare situations.

An approach to handle this problem is by combining the simple selection step
with the validation step. Only valid version+type will return a parser function
pointer and the requesting function will only call the parser function pointer
when it got one.

This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
("batctl: tcpdump - parse TVLV containers").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index ad5469b..c3c847e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -171,16 +171,53 @@ static void batctl_tvlv_parse_roam_v1(void *buff,
 
 typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
 
-/* location [i][j] contains the parsing function for TVLV of type 'i' and
- * version 'j + 1'
- */
-batctl_tvlv_parser_t tvlv_parsers[][1] = {
-	[BATADV_TVLV_GW][0] = batctl_tvlv_parse_gw_v1,
-	[BATADV_TVLV_DAT][0] = batctl_tvlv_parse_dat_v1,
-	[BATADV_TVLV_NC][0] = batctl_tvlv_parse_nc_v1,
-	[BATADV_TVLV_TT][0] = batctl_tvlv_parse_tt_v1,
-	[BATADV_TVLV_ROAM][0] = batctl_tvlv_parse_roam_v1,
-};
+static batctl_tvlv_parser_t tvlv_parser_get(uint8_t type, uint8_t version)
+{
+	switch (type) {
+	case BATADV_TVLV_GW:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_gw_v1;
+		default:
+			return NULL;
+		}
+
+	case BATADV_TVLV_DAT:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_dat_v1;
+		default:
+			return NULL;
+		}
+
+	case BATADV_TVLV_NC:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_nc_v1;
+		default:
+			return NULL;
+		}
+
+	case BATADV_TVLV_TT:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_tt_v1;
+		default:
+			return NULL;
+		}
+
+	case BATADV_TVLV_ROAM:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_roam_v1;
+		default:
+			return NULL;
+		}
+
+	default:
+		return NULL;
+	}
+}
 
 static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 				   int read_opt, int time_printed)
@@ -223,8 +260,9 @@ static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
 		len = ntohs(tvlv_hdr->len);
 
-		parser = tvlv_parsers[tvlv_hdr->type][tvlv_hdr->version - 1];
-		parser(tvlv_hdr + 1, len);
+		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
+		if (parser)
+			parser(tvlv_hdr + 1, len);
 
 		/* go to the next container */
 		ptr = (uint8_t *)(tvlv_hdr + 1) + len;
@@ -651,8 +689,9 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
 		len = ntohs(tvlv_hdr->len);
 
-		parser = tvlv_parsers[tvlv_hdr->type][tvlv_hdr->version - 1];
-		parser(tvlv_hdr + 1, len);
+		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
+		if (parser)
+			parser(tvlv_hdr + 1, len);
 
 		/* go to the next container */
 		ptr = (uint8_t *)(tvlv_hdr + 1) + len;
-- 
2.1.3

