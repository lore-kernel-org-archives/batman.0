Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 Jan 2013 09:41:06 +1000
Message-Id: <1358120480-25960-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1358120480-25960-1-git-send-email-ordex@autistici.org>
References: <1358120480-25960-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/15] batman-adv: use per_cpu_add helper
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Shan Wei <davidshan@tencent.com>, Marek Lindner <lindner_marek@yahoo.de>, Sven Eckelmann <sven@narfation.org>

From: Shan Wei <davidshan@tencent.com>

this_cpu_add is an atomic operation.
and be more faster than per_cpu_ptr operation.

Signed-off-by: Shan Wei <davidshan@tencent.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 2f85577..c4fe41f 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -276,9 +276,7 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
 static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 				      size_t count)
 {
-	int cpu = get_cpu();
-	per_cpu_ptr(bat_priv->bat_counters, cpu)[idx] += count;
-	put_cpu();
+	this_cpu_add(bat_priv->bat_counters[idx], count);
 }
 
 #define batadv_inc_counter(b, i) batadv_add_counter(b, i, 1)
-- 
1.8.0.2

