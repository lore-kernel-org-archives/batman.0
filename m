Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 18 Apr 2012 17:16:39 +0800
Message-Id: <1334740599-7912-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: ignore trailing CR when
	comparing protocol names
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
 main.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/main.c b/main.c
index 1d338a3..fa29234 100644
--- a/main.c
+++ b/main.c
@@ -378,14 +378,19 @@ int bat_algo_seq_print_text(struct seq_file *seq, void *offset)
 static int param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct bat_algo_ops *bat_algo_ops;
+	char *algo_name = (char *)val;
+	size_t name_len = strlen(algo_name);
 
-	bat_algo_ops = bat_algo_get((char *)val);
+	if (algo_name[name_len - 1] == '\n')
+		algo_name[name_len - 1] = '\0';
+
+	bat_algo_ops = bat_algo_get(algo_name);
 	if (!bat_algo_ops) {
-		pr_err("Routing algorithm '%s' is not supported\n", val);
+		pr_err("Routing algorithm '%s' is not supported\n", algo_name);
 		return -EINVAL;
 	}
 
-	return param_set_copystring(val, kp);
+	return param_set_copystring(algo_name, kp);
 }
 
 static const struct kernel_param_ops param_ops_ra = {
-- 
1.7.9.1

