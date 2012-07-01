Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 01:43:45 +0200
Message-Id: <1341186226-10549-16-git-send-email-ordex@autistici.org>
In-Reply-To: <1341186226-10549-1-git-send-email-ordex@autistici.org>
References: <1341186226-10549-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 15/16] batman-adv: fix counter summary length
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8193650..b8d4ac1 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -265,9 +265,8 @@ static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 static inline uint64_t batadv_sum_counter(struct batadv_priv *bat_priv,
 					  size_t idx)
 {
-	uint64_t *counters;
+	uint64_t *counters, sum = 0;
 	int cpu;
-	int sum = 0;
 
 	for_each_possible_cpu(cpu) {
 		counters = per_cpu_ptr(bat_priv->bat_counters, cpu);
-- 
1.7.9.4

