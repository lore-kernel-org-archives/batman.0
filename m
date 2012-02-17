Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Feb 2012 15:18:29 +0800
Message-Id: <1329463110-856-10-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
References: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] batman-adv: allowing changing the
	routing algorithm via module parameter
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/main.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index bcc2bdd..8ae497b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -256,6 +256,30 @@ int bat_algo_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+static int param_set_ra(const char *val, const struct kernel_param *kp)
+{
+	struct bat_algo_ops *bat_algo_ops;
+
+	bat_algo_ops = bat_algo_get((char *)val);
+	if (!bat_algo_ops) {
+		pr_err("Routing algorithm '%s' is not supported\n", val);
+		return -EINVAL;
+	}
+
+	return param_set_copystring(val, kp);
+}
+
+static const struct kernel_param_ops param_ops_ra = {
+	.set = param_set_ra,
+	.get = param_get_string,
+};
+
+static struct kparam_string __param_string_ra = {
+	.maxlen = sizeof(bat_routing_algo),
+	.string = bat_routing_algo,
+};
+
+module_param_cb(routing_algo, &param_ops_ra, &__param_string_ra, 0644);
 module_init(batman_init);
 module_exit(batman_exit);
 
-- 
1.7.9

