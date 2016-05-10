Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 May 2016 22:31:59 +0800
Message-Id: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: init ELP tweaking options
	only once
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

The ELP interval and throughput override interface settings are initialized
with default settings on every time an interface is added to a mesh.
This patch prevents this behavior by moving the configuration init to the
interface detection routine which runs only once per interface.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v2:
   * update commit message

 net/batman-adv/bat_v.c          | 5 -----
 net/batman-adv/bat_v_elp.c      | 1 -
 net/batman-adv/hard-interface.c | 7 +++++++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c16cd44..3c5d251 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -70,11 +70,6 @@ static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 	if (ret < 0)
 		batadv_v_elp_iface_disable(hard_iface);
 
-	/* enable link throughput auto-detection by setting the throughput
-	 * override to zero
-	 */
-	atomic_set(&hard_iface->bat_v.throughput_override, 0);
-
 	return ret;
 }
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 8909d1e..cf0262b 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -344,7 +344,6 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
 	atomic_set(&hard_iface->bat_v.elp_seqno, random_seqno);
-	atomic_set(&hard_iface->bat_v.elp_interval, 500);
 
 	/* assume full-duplex by default */
 	hard_iface->bat_v.flags |= BATADV_FULL_DUPLEX;
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index db2009d..dd6a5a2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -683,6 +683,13 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (batadv_is_wifi_netdev(net_dev))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
+	/* enable link throughput auto-detection by setting the throughput
+	 * override to zero
+	 */
+	atomic_set(&hard_iface->bat_v.throughput_override, 0);
+
+	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+
 	/* extra reference for return */
 	kref_init(&hard_iface->refcount);
 	kref_get(&hard_iface->refcount);
-- 
2.8.0.rc3

