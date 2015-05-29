Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 29 May 2015 11:05:18 +0200
Message-Id: <1432890328-8247-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
References: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 06/16] batman-adv: tvlv realloc,
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Markus Pargmann <mpa@pengutronix.de>

Instead of hiding the normal function flow inside an if block, we should
just put the error handling into the if block.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ca63d48..fd9333d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -819,15 +819,15 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
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
 
-	return false;
+	memcpy(new_buff, *packet_buff, min_packet_len);
+	kfree(*packet_buff);
+	*packet_buff = new_buff;
+	*packet_buff_len = min_packet_len + additional_packet_len;
+
+	return true;
 }
 
 /**
-- 
2.4.2

