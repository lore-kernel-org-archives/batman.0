Return-Path: <joe@perches.com>
Message-ID: <1386317890.31845.26.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Fri, 06 Dec 2013 00:18:10 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH -next] batadv: Slight optimization of
	batadv_compare_eth
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Use CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to check if
this function can be optimized by using the generic
ether_addr_equal.

Remove the unnecessary ?: after the unoptimized memcmp.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/batman-adv/main.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index f94f287b..74a7a3f 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -266,7 +266,11 @@ static inline void batadv_dbg(int type __always_unused,
  */
 static inline int batadv_compare_eth(const void *data1, const void *data2)
 {
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+	return ether_addr_equal(data1, data2);
+#else
+	return memcmp(data1, data2, ETH_ALEN) == 0;
+#endif
 }
 
 /**


