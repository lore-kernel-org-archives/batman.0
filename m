Return-Path: <rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/8] net: batman-adv: hard-interface.c: delete duplicated word + fix punctuation
Date: Sat, 22 Aug 2020 16:13:30 -0700
Message-Id: <20200822231335.31304-4-rdunlap@infradead.org>
In-Reply-To: <20200822231335.31304-1-rdunlap@infradead.org>
References: <20200822231335.31304-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>

Drop the repeated word "table".
End a sentence with a period.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 net/batman-adv/hard-interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200731.orig/net/batman-adv/hard-interface.c
+++ linux-next-20200731/net/batman-adv/hard-interface.c
@@ -599,7 +599,7 @@ out:
 	/* report to the other components the maximum amount of bytes that
 	 * batman-adv can send over the wire (without considering the payload
 	 * overhead). For example, this value is used by TT to compute the
-	 * maximum local table table size
+	 * maximum local table size.
 	 */
 	atomic_set(&bat_priv->packet_size_max, min_mtu);
 
