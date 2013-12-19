Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 19 Dec 2013 01:15:28 +0100
Message-Id: <1387412132-889-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1387412132-889-1-git-send-email-antonio@meshcoding.com>
References: <1387412132-889-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: fix alignment for
	batadv_coded_packet
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

From: Simon Wunderlich <sw@simonwunderlich.de>

The compiler may decide to pad the structure, and then it does not
have the expected size of 46 byte. Fix this by moving it in the
pragma pack(2) part of the code.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/packet.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 207459b..10597a6 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -315,8 +315,6 @@ struct batadv_bcast_packet {
 	 */
 };
 
-#pragma pack()
-
 /**
  * struct batadv_coded_packet - network coded packet
  * @header: common batman packet header and ttl of first included packet
@@ -349,6 +347,8 @@ struct batadv_coded_packet {
 	__be16   coded_len;
 };
 
+#pragma pack()
+
 /**
  * struct batadv_unicast_tvlv - generic unicast packet with tvlv payload
  * @header: common batman packet header
-- 
1.8.5.1

