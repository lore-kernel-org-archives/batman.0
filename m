Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Nov 2014 18:58:27 +0100
Message-Id: <1415815109-17111-3-git-send-email-sven@narfation.org>
In-Reply-To: <1415815109-17111-1-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batctl: Only parse TVLV data when length
	is valid
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

The length in a TVLV field must be smaller or equal to the length of the
remaining read data. Otherwise the parser can read outside of the
valid data region.

This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
("batctl: tcpdump - parse TVLV containers").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 3e57544..443f671 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -258,15 +258,21 @@ static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 
 	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
 		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
+
+		/* data after TVLV header */
+		ptr = (uint8_t *)(tvlv_hdr + 1);
+		tvlv_len -= sizeof(*tvlv_hdr);
+
 		len = ntohs(tvlv_hdr->len);
+		LEN_CHECK(tvlv_len, (size_t)len, "BAT UCAST TVLV");
 
 		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
 		if (parser)
-			parser(tvlv_hdr + 1, len);
+			parser(ptr, len);
 
 		/* go to the next container */
-		ptr = (uint8_t *)(tvlv_hdr + 1) + len;
-		tvlv_len -= sizeof(*tvlv_hdr) + len;
+		ptr += len;
+		tvlv_len -= len;
 	}
 }
 
@@ -687,15 +693,21 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 
 	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
 		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
+
+		/* data after TVLV header */
+		ptr = (uint8_t *)(tvlv_hdr + 1);
+		tvlv_len -= sizeof(*tvlv_hdr);
+
 		len = ntohs(tvlv_hdr->len);
+		LEN_CHECK(tvlv_len, (size_t)len, "BAT IV OGM TVLV");
 
 		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
 		if (parser)
-			parser(tvlv_hdr + 1, len);
+			parser(ptr, len);
 
 		/* go to the next container */
-		ptr = (uint8_t *)(tvlv_hdr + 1) + len;
-		tvlv_len -= sizeof(*tvlv_hdr) + len;
+		ptr += len;
+		tvlv_len -= len;
 	}
 }
 
-- 
2.1.3

