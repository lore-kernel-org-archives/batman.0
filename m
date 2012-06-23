Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jun 2012 11:46:05 +0200
Message-Id: <1340444765-4959-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix counter summary length
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 main.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/main.h b/main.h
index e76f9c6..6dca9c4 100644
--- a/main.h
+++ b/main.h
@@ -267,9 +267,8 @@ static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
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
1.7.9.1

