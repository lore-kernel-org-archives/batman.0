Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:23 +0100
Message-Id: <1419594103-10928-7-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 06/26] batman-adv: tvlv realloc,
	move error handling into if block
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

Instead of hiding the normal function flow inside an if block, we should
just put the error handling into the if block.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/main.c b/main.c
index 65021ea567e8..00a1107109e8 100644
--- a/main.c
+++ b/main.c
@@ -838,15 +838,15 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
 	new_buff = kmalloc(min_packet_len + additional_packet_len, GFP_ATOMIC);
 
 	/* keep old buffer if kmalloc should fail */
-	if (new_buff) {
-		memcpy(new_buff, *packet_buff, min_packet_len);
-		kfree(*packet_buff);
-		*packet_buff = new_buff;
-		*packet_buff_len = min_packet_len + additional_packet_len;
-		return true;
-	}
+	if (!new_buff)
+		return false;
+
+	memcpy(new_buff, *packet_buff, min_packet_len);
+	kfree(*packet_buff);
+	*packet_buff = new_buff;
+	*packet_buff_len = min_packet_len + additional_packet_len;
 
-	return false;
+	return true;
 }
 
 /**
-- 
2.1.3

