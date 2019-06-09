Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/3] batctl: tcpdump: Add support for MCAST TVLV
Date: Sun,  9 Jun 2019 18:56:50 +0200
Message-Id: <20190609165652.12841-2-sven@narfation.org>
In-Reply-To: <20190609165652.12841-1-sven@narfation.org>
References: <20190609165652.12841-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

The multicast support in batman-adv was introduced in commit 77ec494490d6
("batman-adv: Announce new capability via multicast TVLV") but the tcpdump
parser was not updated to parse this TVLV container.

The parser requires support of parsing the current TVLV container (v2) and
the pre-bridging implementation (v1) to correctly show all TVLVs of OGMs
(and related packets).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Linus Lüssing <linus.luessing@c0d3.blue>

 tcpdump.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index 8106a64..9153fc4 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -196,6 +196,45 @@ static void batctl_tvlv_parse_roam_v1(void *buff, ssize_t buff_len)
 	       BATADV_PRINT_VID(ntohs(tvlv->vid)));
 }
 
+static void batctl_tvlv_parse_mcast_v1(void *buff __maybe_unused,
+				       ssize_t buff_len)
+{
+	struct batadv_tvlv_mcast_data *tvlv = buff;
+	uint8_t flags;
+
+	if (buff_len != sizeof(*tvlv)) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (%zu): %zu\n",
+			"TVLV MCASTv1", sizeof(*tvlv), buff_len);
+		return;
+	}
+
+	flags = tvlv->flags;
+
+	printf("\tTVLV MCASTv1: [%c%c%c]\n",
+	       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+	       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+	       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+}
+
+static void batctl_tvlv_parse_mcast_v2(void *buff, ssize_t buff_len)
+{
+	struct batadv_tvlv_mcast_data *tvlv = buff;
+	uint8_t flags;
+
+	if (buff_len != sizeof(*tvlv)) {
+		fprintf(stderr, "Warning - dropping received %s packet as it is not the correct size (%zu): %zu\n",
+			"TVLV MCASTv2", sizeof(*tvlv), buff_len);
+		return;
+	}
+
+	flags = tvlv->flags;
+
+	printf("\tTVLV MCASTv2: [%c%c%c]\n",
+	       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+	       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+	       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+}
+
 typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
 
 static batctl_tvlv_parser_t tvlv_parser_get(uint8_t type, uint8_t version)
@@ -241,6 +280,16 @@ static batctl_tvlv_parser_t tvlv_parser_get(uint8_t type, uint8_t version)
 			return NULL;
 		}
 
+	case BATADV_TVLV_MCAST:
+		switch (version) {
+		case 1:
+			return batctl_tvlv_parse_mcast_v1;
+		case 2:
+			return batctl_tvlv_parse_mcast_v2;
+		default:
+			return NULL;
+		}
+
 	default:
 		return NULL;
 	}
-- 
2.20.1

