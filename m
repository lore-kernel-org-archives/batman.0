Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Nov 2014 18:58:26 +0100
Message-Id: <1415815109-17111-2-git-send-email-sven@narfation.org>
In-Reply-To: <1415815109-17111-1-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batctl: Parse only TVLV when header is
	available
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

The TVLV must only start parsing an header when at least one TVLV header is
available. Otherwise data behind the received data might be accessed.

This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
("batctl: tcpdump - parse TVLV containers").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 tcpdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index c3c847e..3e57544 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -256,7 +256,7 @@ static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 
 	ptr = (uint8_t *)(tvlv_packet + 1);
 
-	while (tvlv_len > 0) {
+	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
 		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
 		len = ntohs(tvlv_hdr->len);
 
@@ -685,7 +685,7 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 
 	ptr = (uint8_t *)(batman_ogm_packet + 1);
 
-	while (tvlv_len > 0) {
+	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
 		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
 		len = ntohs(tvlv_hdr->len);
 
-- 
2.1.3

