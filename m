Return-Path: <joe@perches.com>
Message-ID: <1378075508.1953.27.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Sun, 01 Sep 2013 15:45:08 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] batman: Remove reference to
	compare_ether_addr
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
To: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <ordex@autistici.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>

This function is being removed, rename the reference.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 5e9aebb..7333cf8 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -253,7 +253,7 @@ static inline void batadv_dbg(int type __always_unused,
 
 /* returns 1 if they are the same ethernet addr
  *
- * note: can't use compare_ether_addr() as it requires aligned memory
+ * note: can't use ether_addr_equal() as it requires aligned memory
  */
 static inline int batadv_compare_eth(const void *data1, const void *data2)
 {


