Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Dec 2011 01:15:56 +0800
Message-Id: <1323537357-9116-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1323537357-9116-1-git-send-email-lindner_marek@yahoo.de>
References: <1323537357-9116-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: allowing changing the
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 compat.h |   28 ++++++++++++++++++++++++++++
 main.c   |   24 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/compat.h b/compat.h
index 194e70e..3733f68 100644
--- a/compat.h
+++ b/compat.h
@@ -61,6 +61,34 @@
 #define __rcu
 #define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
 
+struct kernel_param_ops {
+	/* Returns 0, or -errno.  arg is in kp->arg. */
+	int (*set)(const char *val, const struct kernel_param *kp);
+	/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
+	int (*get)(char *buffer, struct kernel_param *kp);
+	/* Optional function to free kp->arg when module unloaded. */
+	void (*free)(void *arg);
+};
+
+#define module_param_cb(name, ops, arg, perm)				\
+	static int __compat_set_param_##name(const char *val,		\
+					     struct kernel_param *kp)	\
+				{ return (ops)->set(val, kp); }		\
+	static int __compat_get_param_##name(char *buffer,		\
+					     struct kernel_param *kp)	\
+				{ return (ops)->get(buffer, kp); }	\
+	__module_param_call(MODULE_PARAM_PREFIX, name,			\
+			    __compat_set_param_##name,			\
+			    __compat_get_param_##name, arg,		\
+			    __same_type((arg), bool *), perm)
+
+static inline int __param_set_copystring(const char *val,
+					 const struct kernel_param *kp)
+{
+	return param_set_copystring(val, (struct kernel_param *)kp);
+}
+#define param_set_copystring __param_set_copystring
+
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
diff --git a/main.c b/main.c
index bcc2bdd..8ae497b 100644
--- a/main.c
+++ b/main.c
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
1.7.5.4

