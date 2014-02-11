Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:12 +0100
Message-Id: <1392122903-805-13-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 12/23] batman-adv: add base throughput attribute
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

when batman-adv is asked to estimate/compute the throughput
of an interface, but it fails for whatever reason, then the
value in this attribute is used

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c | 3 +++
 main.h  | 7 +++++++
 sysfs.c | 7 +++++++
 types.h | 1 +
 4 files changed, 18 insertions(+)

diff --git a/bat_v.c b/bat_v.c
index d5457b3..3aa42ec 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -75,6 +75,9 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 
 int batadv_v_mesh_init(struct batadv_priv *bat_priv)
 {
+	atomic_set(&bat_priv->bat_v.base_throughput,
+		   BATADV_DEFAULT_BASE_THROUGHPUT);
+
 	return batadv_v_ogm_init(bat_priv);
 }
 
diff --git a/main.h b/main.h
index 47fb9ed..5699c9f 100644
--- a/main.h
+++ b/main.h
@@ -33,6 +33,13 @@
 #define BATADV_MAX_METRIC 0xFFFFFFFF
 #define BATADV_JITTER 20
 
+/**
+ * BATADV_DEFAULT_BASE_THROUGHPUT - default value used as throughput for
+ * hard_ifaces for which it is not possible to measure/estimate the real one.
+ * Value is expressed in Mbps/10
+ */
+#define BATADV_DEFAULT_BASE_THROUGHPUT 10
+
 /* Time To Live of broadcast messages */
 #define BATADV_TTL 50
 
diff --git a/sysfs.c b/sysfs.c
index 8bbbdfa..a670eeb 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -606,6 +606,10 @@ BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR,
 #endif
 static BATADV_ATTR(isolation_mark, S_IRUGO | S_IWUSR,
 		   batadv_show_isolation_mark, batadv_store_isolation_mark);
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+BATADV_ATTR_SIF_UINT2(base_throughput, bat_v.base_throughput, S_IRUGO | S_IWUSR,
+		      1, UINT_MAX, NULL);
+#endif
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_aggregated_ogms,
@@ -630,6 +634,9 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_network_coding,
 #endif
 	&batadv_attr_isolation_mark,
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	&batadv_attr_base_throughput,
+#endif
 	NULL,
 };
 
diff --git a/types.h b/types.h
index 64316b9..22d621e 100644
--- a/types.h
+++ b/types.h
@@ -741,6 +741,7 @@ struct batadv_priv_bat_v {
 	int ogm_buff_len;
 	struct delayed_work ogm_wq;
 	atomic_t ogm_seqno;
+	atomic_t base_throughput;
 };
 
 /**
-- 
1.8.5.3

