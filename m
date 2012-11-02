Return-Path: <shanwei88@gmail.com>
Message-ID: <5093EE7E.6040400@gmail.com>
Date: Sat, 03 Nov 2012 00:02:06 +0800
From: Shan Wei <shanwei88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH v2 9/9] net: batman-adv: use per_cpu_add
	helper
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
To: lindner_marek@yahoo.de, siwu@hrz.tu-chemnitz.de, ordex@autistici.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, NetDev <netdev@vger.kernel.org>, Kernel-Maillist <linux-kernel@vger.kernel.org>, Shan Wei <shanwei88@gmail.com>, Christoph Lameter <cl@linux.com>

From: Shan Wei <davidshan@tencent.com>


As Christoph Lameter said:

> In addition, following usage of per_cpu_ptr can be replaced by this_cpu_read.
>
> cpu=get_cpu()
> ....
> *per_cpu_ptr(p,cpu)
> ....
> ....
> put_cpu()

Right.

Signed-off-by: Shan Wei <davidshan@tencent.com>
---
 net/batman-adv/main.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 897ba6a..3aef5b2 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -263,9 +263,7 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
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
1.7.1

