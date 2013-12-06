Return-Path: <joe@perches.com>
Message-ID: <1386369586.31845.42.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Fri, 06 Dec 2013 14:39:46 -0800
In-Reply-To: <1386368461.31845.38.camel@joe-AO722>
References: <1386317890.31845.26.camel@joe-AO722>
 <20131206.153944.1382127535160341376.davem@davemloft.net>
 <1386364621.31845.32.camel@joe-AO722>
 <20131206.163806.1555069105347405484.davem@davemloft.net>
 <1386368461.31845.38.camel@joe-AO722>
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
To: David Miller <davem@davemloft.net>
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, antonio@meshcoding.com

Use the newly added generic routine ether_addr_equal_unaligned
to test if possibly unaligned to u16 Ethernet addresses are equal.

This slightly improves comparison time for systems with
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index f94f287b..322dd73 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -266,7 +266,7 @@ static inline void batadv_dbg(int type __always_unused,
  */
 static inline int batadv_compare_eth(const void *data1, const void *data2)
 {
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+	return ether_addr_equal_unaligned(data1, data2);
 }
 
 /**


