Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 Dec 2015 10:39:05 +0100
Message-ID: <2074355.MrCHDIHgv1@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1613818.QmmG72Px1Z"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] Missing patches in net-next
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

This is a multi-part message in MIME format.

--nextPart1613818.QmmG72Px1Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

it seems a bunch of patches are missing in net-next from batman-adv next's
branch.

An incorrect lockdep_assert was fixed to refer to the correct lock. The
flag FIRST_HOP was dropped because it is not used anymore in the batman-adv
compat version 15. The bridge loop avoidance code will now cleanup its
internal state when it gets disabled. This is required to reset itself in
case it gets restarted again. Also the behavior when the user tries to
enable the already started bridge loop avoidance was modified to just
ignore this trigger. It was also tuned to better cope with networks
using very lossy links.

The rest are only contain minor cleanups of the code, updates of the
documentation and kerneldoc inside the batman-adv source code.

Kind regards,
	Sven


Antonio Quartulli (3):
      batman-adv: fix kerneldoc for DAT functions
      batman-adv: fix kerneldoc for TT functions
      batman-adv: add kernel doc for AP isolation attributes in bat_priv

Marek Lindner (2):
      batman-adv: remove leftovers of unused BATADV_PRIMARIES_FIRST_HOP flag
      batman-adv: kernel doc readability updates

Markus Elfring (4):
      batman-adv: Delete unnecessary checks before the function call "kfree_skb"
      batman-adv: Less checks in batadv_tvlv_unicast_send()
      batman-adv: Delete an unnecessary check before the function call "batadv_softif_vlan_free_ref"
      batman-adv: Split a condition check

Simon Wunderlich (5):
      batman-adv: Start new development cycle
      batman-adv: purge bridge loop avoidance when its disabled
      batman-adv: increase BLA wait periods to 6
      batman-adv: only call post function if something changed
      batman-adv: Update/repair bridge loop avoidance kerneldoc

Sven Eckelmann (14):
      batman-adv: Fix lockdep annotation of batadv_tlv_container_remove
      batman-adv: Add function to convert string to batadv throughput
      batman-adv: Change ifconfig examples to iproute2
      batman-adv: Fix kernel-doc parsing of main structs
      batman-adv: Fix kerneldoc member names in for main structs
      batman-adv: Remove kerneldoc for missing struct members
      batman-adv: Add kerneldoc for batadv_neigh_node::refcount
      batman-adv: Fix kerneldoc parsing of structs/enums
      batman-adv: Remove kerneldoc for missing parameters
      batman-adv: Fix names in kerneldoc of functions
      batman-adv: Drop invalid kerneldoc for variable batadv_vlan_attrs
      batman-adv: Fix kerneldoc parsing of return description
      batman-adv: Fix kerneldoc of main functions
      batman-adv: Fix kerneldoc of network-coding functions


 Documentation/networking/batman-adv.txt |   9 +-
 net/batman-adv/bat_iv_ogm.c             |  21 ++-
 net/batman-adv/bitarray.c               |  12 +-
 net/batman-adv/bitarray.h               |  12 +-
 net/batman-adv/bridge_loop_avoidance.c  | 247 ++++++++++++++++++++++++--------
 net/batman-adv/bridge_loop_avoidance.h  |   2 +
 net/batman-adv/debugfs.c                |   6 +
 net/batman-adv/distributed-arp-table.c  |  41 +++---
 net/batman-adv/fragmentation.c          |  18 +--
 net/batman-adv/fragmentation.h          |   2 +-
 net/batman-adv/gateway_client.c         |  14 +-
 net/batman-adv/gateway_common.c         | 119 +++++++--------
 net/batman-adv/hard-interface.c         |   7 +-
 net/batman-adv/hash.h                   |  22 +--
 net/batman-adv/main.c                   |  45 +++---
 net/batman-adv/main.h                   |  21 ++-
 net/batman-adv/multicast.c              |  35 +++--
 net/batman-adv/multicast.h              |   2 +-
 net/batman-adv/network-coding.c         |  59 ++++----
 net/batman-adv/originator.c             |  54 ++++---
 net/batman-adv/packet.h                 |  20 +--
 net/batman-adv/routing.c                |  36 +++--
 net/batman-adv/send.c                   |  32 +++--
 net/batman-adv/send.h                   |   4 +-
 net/batman-adv/soft-interface.c         |  18 +--
 net/batman-adv/sysfs.c                  |  31 ++--
 net/batman-adv/translation-table.c      | 125 +++++++++-------
 net/batman-adv/types.h                  |  60 ++++----
 28 files changed, 650 insertions(+), 424 deletions(-)
--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0001-batman-adv-Start-new-development-cycle.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-Start-new-development-cycle.patch"

From 02d6f307410077819425d367e9c4223600072c04 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Nov 2015 20:30:15 +0100
Subject: [PATCH 01/28] batman-adv: Start new development cycle

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index ebd8af0..da9f16c 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -24,7 +24,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2015.2"
+#define BATADV_SOURCE_VERSION "2016.0"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0002-batman-adv-Fix-lockdep-annotation-of-batadv_tlv_cont.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-batman-adv-Fix-lockdep-annotation-of-batadv_tlv_cont.patch"

From 397c355763cefc5237e23a598b25946c926a587d Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue, 3 Nov 2015 19:20:34 +0100
Subject: [PATCH 02/28] batman-adv: Fix lockdep annotation of
 batadv_tlv_container_remove

The function handles tlv containers and not tlv handlers. Thus the
lockdep_assert_held has to check for the container_list lock.

Fixes: 2c72d655b044 ("batman-adv: Annotate deleting functions with external lock via lockdep")
Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5dbcb2e..95fd418 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -747,7 +747,7 @@ static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 					 struct batadv_tvlv_container *tvlv)
 {
-	lockdep_assert_held(&bat_priv->tvlv.handler_list_lock);
+	lockdep_assert_held(&bat_priv->tvlv.container_list_lock);
 
 	if (!tvlv)
 		return;
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0003-batman-adv-remove-leftovers-of-unused-BATADV_PRIMARI.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-batman-adv-remove-leftovers-of-unused-BATADV_PRIMARI.patch"

From 31aad9f0958b4f5e72ee57476c19bc51162af961 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 9 Aug 2015 23:56:50 +0800
Subject: [PATCH 03/28] batman-adv: remove leftovers of unused
 BATADV_PRIMARIES_FIRST_HOP flag

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_iv_ogm.c | 3 ---
 net/batman-adv/packet.h     | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 5677169..2467024 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -361,7 +361,6 @@ batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	unsigned char *ogm_buff = hard_iface->bat_iv.ogm_buff;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)ogm_buff;
-	batadv_ogm_packet->flags = BATADV_PRIMARIES_FIRST_HOP;
 	batadv_ogm_packet->ttl = BATADV_TTL;
 }
 
@@ -842,8 +841,6 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 		   "Forwarding packet: tq: %i, ttl: %i\n",
 		   batadv_ogm_packet->tq, batadv_ogm_packet->ttl);
 
-	/* switch of primaries first hop flag when forwarding */
-	batadv_ogm_packet->flags &= ~BATADV_PRIMARIES_FIRST_HOP;
 	if (is_single_hop_neigh)
 		batadv_ogm_packet->flags |= BATADV_DIRECTLINK;
 	else
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 11f996b..0558e32 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -72,8 +72,7 @@ enum batadv_subtype {
  * enum batadv_iv_flags - flags used in B.A.T.M.A.N. IV OGM packets
  * @BATADV_NOT_BEST_NEXT_HOP: flag is set when ogm packet is forwarded and was
  *     previously received from someone else than the best neighbor.
- * @BATADV_PRIMARIES_FIRST_HOP: flag is set when the primary interface address
- *     is used, and the packet travels its first hop.
+ * @BATADV_PRIMARIES_FIRST_HOP: flag unused.
  * @BATADV_DIRECTLINK: flag is for the first hop or if rebroadcasted from a
  *     one hop neighbor on the interface where it was originally received.
  */
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0004-batman-adv-purge-bridge-loop-avoidance-when-its-disa.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0004-batman-adv-purge-bridge-loop-avoidance-when-its-disa.patch"

From a2ce217c78be06b60132a3e15ed4801720ed4326 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <simon@open-mesh.com>
Date: Mon, 9 Nov 2015 16:20:52 +0100
Subject: [PATCH 04/28] batman-adv: purge bridge loop avoidance when its
 disabled

When bridge loop avoidance is disabled through sysfs, the internal
datastructures are not disabled, but only BLA operations are disabled.
To be sure that they are removed, purge the data immediately. That is
especially useful if a firmwares network state is changed, and the BLA
wait periods should restart on the new network.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bridge_loop_avoidance.c | 20 ++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  2 ++
 net/batman-adv/sysfs.c                 |  4 +++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 99dcae3..d5d71ac 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1168,6 +1168,26 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_bla_status_update - purge bla interfaces if necessary
+ * @net_dev: the soft interface net device
+ */
+void batadv_bla_status_update(struct net_device *net_dev)
+{
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		return;
+
+	/* this function already purges everything when bla is disabled,
+	 * so just call that one.
+	 */
+	batadv_bla_update_orig_address(bat_priv, primary_if, primary_if);
+	batadv_hardif_free_ref(primary_if);
+}
+
 /* periodic work to do:
  *  * purge structures when they are too old
  *  * send announcements
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 025152b..7ea199b 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -22,6 +22,7 @@
 
 #include <linux/types.h>
 
+struct net_device;
 struct seq_file;
 struct sk_buff;
 
@@ -42,6 +43,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    struct batadv_hard_iface *oldif);
+void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 9de3c88..48e2aad 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -40,6 +40,7 @@
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
+#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "network-coding.h"
 #include "packet.h"
@@ -549,7 +550,8 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 BATADV_ATTR_SIF_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BATADV_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
-BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
+BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR,
+		     batadv_bla_status_update);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR,
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0006-batman-adv-only-call-post-function-if-something-chan.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0006-batman-adv-only-call-post-function-if-something-chan.patch"

From 2a12e5c33fa2e75df55eaea2e24bf02496b949a7 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <simon@open-mesh.com>
Date: Tue, 17 Nov 2015 14:11:26 +0100
Subject: [PATCH 06/28] batman-adv: only call post function if something
 changed

Currently, the post function is also called on errors or if there were
no changes, which is redundant for the functions currently using these
facilities.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/sysfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 48e2aad..fe87777 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -242,10 +242,13 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 
 static int batadv_store_bool_attr(char *buff, size_t count,
 				  struct net_device *net_dev,
-				  const char *attr_name, atomic_t *attr)
+				  const char *attr_name, atomic_t *attr,
+				  bool *changed)
 {
 	int enabled = -1;
 
+	*changed = false;
+
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
@@ -272,6 +275,8 @@ static int batadv_store_bool_attr(char *buff, size_t count,
 		    atomic_read(attr) == 1 ? "enabled" : "disabled",
 		    enabled == 1 ? "enabled" : "disabled");
 
+	*changed = true;
+
 	atomic_set(attr, (unsigned int)enabled);
 	return count;
 }
@@ -282,11 +287,12 @@ __batadv_store_bool_attr(char *buff, size_t count,
 			 struct attribute *attr,
 			 atomic_t *attr_store, struct net_device *net_dev)
 {
+	bool changed;
 	int ret;
 
 	ret = batadv_store_bool_attr(buff, count, net_dev, attr->name,
-				     attr_store);
-	if (post_func && ret)
+				     attr_store, &changed);
+	if (post_func && changed)
 		post_func(net_dev);
 
 	return ret;
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0005-batman-adv-increase-BLA-wait-periods-to-6.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0005-batman-adv-increase-BLA-wait-periods-to-6.patch"

From c4c61400609f5b6f8131434100337da4f71f1863 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <simon@open-mesh.com>
Date: Mon, 9 Nov 2015 16:20:53 +0100
Subject: [PATCH 05/28] batman-adv: increase BLA wait periods to 6

If networks take a long time to come up, e.g. due to lossy links, then
the bridge loop avoidance wait time to suppress broadcasts may not wait
long enough and detect a backbone before the mesh is brought up.
Increasing the wait period further to 60 seconds makes this scenario
less likely.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index da9f16c..9dbd910 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -109,7 +109,7 @@
 #define BATADV_MAX_AGGREGATION_MS 100
 
 #define BATADV_BLA_PERIOD_LENGTH	10000	/* 10 seconds */
-#define BATADV_BLA_BACKBONE_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 3)
+#define BATADV_BLA_BACKBONE_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 6)
 #define BATADV_BLA_CLAIM_TIMEOUT	(BATADV_BLA_PERIOD_LENGTH * 10)
 #define BATADV_BLA_WAIT_PERIODS		3
 
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0007-batman-adv-Add-function-to-convert-string-to-batadv-.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0007-batman-adv-Add-function-to-convert-string-to-batadv-.patch"

From 582ea8efd84dd87bb9bd0bdf07df1fc3477f3184 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Sep 2015 09:44:45 +0200
Subject: [PATCH 07/28] batman-adv: Add function to convert string to batadv
 throughput

The code to convert the throughput information from a string to the
batman-adv internal (100Kibit/s) representation is duplicated in
batadv_parse_gw_bandwidth. Move this functionality to its own function
batadv_parse_throughput to reduce the code complexity.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/gateway_common.c | 121 +++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 70 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 0cb5e6b..b51bfac 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -31,27 +31,23 @@
 #include "packet.h"
 
 /**
- * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
- *  and upload bandwidth information
+ * batadv_parse_throughput - parse supplied string buffer to extract throughput
+ *  information
  * @net_dev: the soft interface net device
  * @buff: string buffer to parse
- * @down: pointer holding the returned download bandwidth information
- * @up: pointer holding the returned upload bandwidth information
+ * @description: text shown when throughput string cannot be parsed
+ * @throughput: pointer holding the returned throughput information
  *
  * Returns false on parse error and true otherwise.
  */
-static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
-				      u32 *down, u32 *up)
+static bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
+				    const char *description, u32 *throughput)
 {
 	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
-	char *slash_ptr, *tmp_ptr;
-	u64 ldown, lup;
+	u64 lthroughput;
+	char *tmp_ptr;
 	int ret;
 
-	slash_ptr = strchr(buff, '/');
-	if (slash_ptr)
-		*slash_ptr = 0;
-
 	if (strlen(buff) > 4) {
 		tmp_ptr = buff + strlen(buff) - 4;
 
@@ -63,90 +59,75 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 			*tmp_ptr = '\0';
 	}
 
-	ret = kstrtou64(buff, 10, &ldown);
+	ret = kstrtou64(buff, 10, &lthroughput);
 	if (ret) {
 		batadv_err(net_dev,
-			   "Download speed of gateway mode invalid: %s\n",
-			   buff);
+			   "Invalid throughput speed for %s: %s\n",
+			   description, buff);
 		return false;
 	}
 
 	switch (bw_unit_type) {
 	case BATADV_BW_UNIT_MBIT:
 		/* prevent overflow */
-		if (U64_MAX / 10 < ldown) {
+		if (U64_MAX / 10 < lthroughput) {
 			batadv_err(net_dev,
-				   "Download speed of gateway mode too large: %s\n",
-				   buff);
+				   "Throughput speed for %s too large: %s\n",
+				   description, buff);
 			return false;
 		}
 
-		ldown *= 10;
+		lthroughput *= 10;
 		break;
 	case BATADV_BW_UNIT_KBIT:
 	default:
-		ldown = div_u64(ldown, 100);
+		lthroughput = div_u64(lthroughput, 100);
 		break;
 	}
 
-	if (U32_MAX < ldown) {
+	if (lthroughput > U32_MAX) {
 		batadv_err(net_dev,
-			   "Download speed of gateway mode too large: %s\n",
-			   buff);
+			   "Throughput speed for %s too large: %s\n",
+			   description, buff);
 		return false;
 	}
 
-	*down = ldown;
+	*throughput = lthroughput;
+
+	return true;
+}
+
+/**
+ * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
+ *  and upload bandwidth information
+ * @net_dev: the soft interface net device
+ * @buff: string buffer to parse
+ * @down: pointer holding the returned download bandwidth information
+ * @up: pointer holding the returned upload bandwidth information
+ *
+ * Return: false on parse error and true otherwise.
+ */
+static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
+				      u32 *down, u32 *up)
+{
+	char *slash_ptr;
+	bool ret;
+
+	slash_ptr = strchr(buff, '/');
+	if (slash_ptr)
+		*slash_ptr = 0;
+
+	ret = batadv_parse_throughput(net_dev, buff, "download gateway speed",
+				      down);
+	if (!ret)
+		return false;
 
 	/* we also got some upload info */
 	if (slash_ptr) {
-		bw_unit_type = BATADV_BW_UNIT_KBIT;
-
-		if (strlen(slash_ptr + 1) > 4) {
-			tmp_ptr = slash_ptr + 1 - 4 + strlen(slash_ptr + 1);
-
-			if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
-				bw_unit_type = BATADV_BW_UNIT_MBIT;
-
-			if ((strncasecmp(tmp_ptr, "kbit", 4) == 0) ||
-			    (bw_unit_type == BATADV_BW_UNIT_MBIT))
-				*tmp_ptr = '\0';
-		}
-
-		ret = kstrtou64(slash_ptr + 1, 10, &lup);
-		if (ret) {
-			batadv_err(net_dev,
-				   "Upload speed of gateway mode invalid: %s\n",
-				   slash_ptr + 1);
+		ret = batadv_parse_throughput(net_dev, slash_ptr + 1,
+					      "upload gateway speed", up);
+		if (!ret)
 			return false;
-		}
-
-		switch (bw_unit_type) {
-		case BATADV_BW_UNIT_MBIT:
-			/* prevent overflow */
-			if (U64_MAX / 10 < lup) {
-				batadv_err(net_dev,
-					   "Upload speed of gateway mode too large: %s\n",
-					   slash_ptr + 1);
-				return false;
-			}
-
-			lup *= 10;
-			break;
-		case BATADV_BW_UNIT_KBIT:
-		default:
-			lup = div_u64(lup, 100);
-			break;
-		}
-
-		if (U32_MAX < lup) {
-			batadv_err(net_dev,
-				   "Upload speed of gateway mode too large: %s\n",
-				   slash_ptr + 1);
-			return false;
-		}
-
-		*up = lup;
 	}
 
 	return true;
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0008-batman-adv-Delete-unnecessary-checks-before-the-func.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0008-batman-adv-Delete-unnecessary-checks-before-the-func.patch"

From 909e1ded2e7bdd27b69fd97643d251360cf9a4f2 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Nov 2015 08:04:43 +0100
Subject: [PATCH 08/28] batman-adv: Delete unnecessary checks before the
 function call "kfree_skb"

The kfree_skb() function tests whether its argument is NULL and then
returns immediately. Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c           | 2 +-
 net/batman-adv/network-coding.c | 4 +---
 net/batman-adv/send.c           | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 95fd418..5b678f3 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1184,7 +1184,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 		ret = true;
 
 out:
-	if (skb && !ret)
+	if (!ret)
 		kfree_skb(skb);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index f5276be..c98b0ab 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -244,9 +244,7 @@ static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
  */
 static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
 {
-	if (nc_packet->skb)
-		kfree_skb(nc_packet->skb);
-
+	kfree_skb(nc_packet->skb);
 	batadv_nc_path_free_ref(nc_packet->nc_path);
 	kfree(nc_packet);
 }
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index f664324..782fa33 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -407,8 +407,7 @@ void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 
 static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
-	if (forw_packet->skb)
-		kfree_skb(forw_packet->skb);
+	kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
 		batadv_hardif_free_ref(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0009-batman-adv-Less-checks-in-batadv_tvlv_unicast_send.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0009-batman-adv-Less-checks-in-batadv_tvlv_unicast_send.patch"

From 721fec837c175ce58fea0958aa1990ddedf5ad0e Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Nov 2015 09:00:42 +0100
Subject: [PATCH 09/28] batman-adv: Less checks in batadv_tvlv_unicast_send()

* Let us return directly if a call of the batadv_orig_hash_find() function
  returned a null pointer.

* Omit the initialisation for the variable "skb" at the beginning.

* Replace an assignment by a call of the kfree_skb() function
  and delete the affected variable "ret" then.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 5b678f3..4b5d61f 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1143,15 +1143,14 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	struct batadv_orig_node *orig_node;
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb;
 	unsigned char *tvlv_buff;
 	unsigned int tvlv_len;
 	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
-	bool ret = false;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (!orig_node)
-		goto out;
+		return;
 
 	tvlv_len = sizeof(*tvlv_hdr) + tvlv_value_len;
 
@@ -1180,14 +1179,10 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	tvlv_buff += sizeof(*tvlv_hdr);
 	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
 
-	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
-		ret = true;
-
-out:
-	if (!ret)
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL) == NET_XMIT_DROP)
 		kfree_skb(skb);
-	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
+out:
+	batadv_orig_node_free_ref(orig_node);
 }
 
 /**
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0011-batman-adv-Split-a-condition-check.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0011-batman-adv-Split-a-condition-check.patch"

From ff45083b1e24df045939c834604e56de9e055672 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Nov 2015 19:20:34 +0100
Subject: [PATCH 11/28] batman-adv: Split a condition check

Let us split a check for a condition at the beginning of the
batadv_is_ap_isolated() function so that a direct return can be performed
in this function if the variable "vlan" contained a null pointer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/translation-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5852fda..a22080c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3339,7 +3339,10 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	bool ret = false;
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (!vlan || !atomic_read(&vlan->ap_isolation))
+	if (!vlan)
+		return false;
+
+	if (!atomic_read(&vlan->ap_isolation))
 		goto out;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0010-batman-adv-Delete-an-unnecessary-check-before-the-fu.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0010-batman-adv-Delete-an-unnecessary-check-before-the-fu.patch"

From 1e170ab15609d59de7be1bd86249f43f634f59c8 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Nov 2015 19:20:34 +0100
Subject: [PATCH 10/28] batman-adv: Delete an unnecessary check before the
 function call "batadv_softif_vlan_free_ref"

The batadv_softif_vlan_free_ref() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/translation-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index ec67def..5852fda 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3356,8 +3356,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	ret = true;
 
 out:
-	if (vlan)
-		batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_free_ref(vlan);
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0012-batman-adv-Change-ifconfig-examples-to-iproute2.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0012-batman-adv-Change-ifconfig-examples-to-iproute2.patch"

From 463d7f0a8cd6c2e3cfe1c87ab644d65f73073425 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 28 Oct 2015 10:58:00 +0100
Subject: [PATCH 12/28] batman-adv: Change ifconfig examples to iproute2

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 Documentation/networking/batman-adv.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 58e4904..ff23b75 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -115,14 +115,17 @@ The "bat0" interface can be used like any  other  regular  inter-
 face.  It needs an IP address which can be either statically con-
 figured or dynamically (by using DHCP or similar services):
 
-# NodeA: ifconfig bat0 192.168.0.1
-# NodeB: ifconfig bat0 192.168.0.2
+# NodeA: ip link set up dev bat0
+# NodeA: ip addr add 192.168.0.1/24 dev bat0
+
+# NodeB: ip link set up dev bat0
+# NodeB: ip addr add 192.168.0.2/24 dev bat0
 # NodeB: ping 192.168.0.1
 
 Note:  In  order to avoid problems remove all IP addresses previ-
 ously assigned to interfaces now used by batman advanced, e.g.
 
-# ifconfig eth0 0.0.0.0
+# ip addr flush dev eth0
 
 
 LOGGING/DEBUGGING
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0013-batman-adv-Fix-kernel-doc-parsing-of-main-structs.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0013-batman-adv-Fix-kernel-doc-parsing-of-main-structs.patch"

From 01787e3fa1e2d6f50776e4b7bf9b5ae2747f3b7c Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:45 +0200
Subject: [PATCH 13/28] batman-adv: Fix kernel-doc parsing of main structs

kernel-doc is not able to skip an #ifdef between the kernel documentation
block and the start of the struct. Moving the #ifdef before the kernel doc
block avoids this problem

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7c386db..876ac33 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -423,13 +423,14 @@ struct batadv_neigh_ifinfo {
 	struct rcu_head rcu;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
  * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
  * @crc: crc32 checksum of broadcast payload
  * @entrytime: time when the broadcast packet was received
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bcast_duplist_entry {
 	u8 orig[ETH_ALEN];
 	__be32 crc;
@@ -571,6 +572,8 @@ struct batadv_priv_tt {
 	struct delayed_work work;
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
  * @num_requests; number of bla requests in flight
@@ -583,7 +586,6 @@ struct batadv_priv_tt {
  * @claim_dest: local claim data (e.g. claim group)
  * @work: work queue callback item for cleanups & bla announcements
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
 	struct batadv_hashtable *claim_hash;
@@ -597,6 +599,8 @@ struct batadv_priv_bla {
 };
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
 /**
  * struct batadv_priv_debug_log - debug logging data
  * @log_buff: buffer holding the logs (ring bufer)
@@ -605,7 +609,6 @@ struct batadv_priv_bla {
  * @lock: lock protecting log_buff, log_start & log_end
  * @queue_wait: log reader's wait queue
  */
-#ifdef CONFIG_BATMAN_ADV_DEBUG
 struct batadv_priv_debug_log {
 	char log_buff[BATADV_LOG_BUF_LEN];
 	unsigned long log_start;
@@ -647,13 +650,14 @@ struct batadv_priv_tvlv {
 	spinlock_t handler_list_lock; /* protects handler_list */
 };
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 /**
  * struct batadv_priv_dat - per mesh interface DAT private data
  * @addr: node DAT address
  * @hash: hashtable representing the local ARP cache
  * @work: work queue callback item for cache purging
  */
-#ifdef CONFIG_BATMAN_ADV_DAT
 struct batadv_priv_dat {
 	batadv_dat_addr_t addr;
 	struct batadv_hashtable *hash;
@@ -893,6 +897,8 @@ struct batadv_socket_packet {
 	u8 icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
 };
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+
 /**
  * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the LAN
  * @orig: originator address of backbone node (mac address of primary iface)
@@ -910,7 +916,6 @@ struct batadv_socket_packet {
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
-#ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_bla_backbone_gw {
 	u8 orig[ETH_ALEN];
 	unsigned short vid;
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0014-batman-adv-Fix-kerneldoc-member-names-in-for-main-st.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0014-batman-adv-Fix-kerneldoc-member-names-in-for-main-st.patch"

From 8fe39131d7dc02cd94bbb11bbf4edf6afb77e86d Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:46 +0200
Subject: [PATCH 14/28] batman-adv: Fix kerneldoc member names in for main
 structs

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 876ac33..d93501ed 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -223,12 +223,12 @@ struct batadv_orig_bat_iv {
  * @orig: originator ethernet address
  * @ifinfo_list: list for routers per outgoing interface
  * @last_bonding_candidate: pointer to last ifinfo of last used router
- * @batadv_dat_addr_t:  address of the orig node in the distributed hash
+ * @dat_addr: address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @mcast_handler_lock: synchronizes mcast-capability and -flag changes
  * @mcast_flags: multicast flags announced by the orig node
- * @mcast_want_all_unsnoop_node: a list node for the
+ * @mcast_want_all_unsnoopables_node: a list node for the
  *  mcast.want_all_unsnoopables list
  * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 list
  * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 list
@@ -427,7 +427,7 @@ struct batadv_neigh_ifinfo {
 
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
- * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
+ * @orig: mac address of orig node orginating the broadcast
  * @crc: crc32 checksum of broadcast payload
  * @entrytime: time when the broadcast packet was received
  */
@@ -576,7 +576,7 @@ struct batadv_priv_tt {
 
 /**
  * struct batadv_priv_bla - per mesh interface bridge loope avoidance data
- * @num_requests; number of bla requests in flight
+ * @num_requests: number of bla requests in flight
  * @claim_hash: hash table containing mesh nodes this host has claimed
  * @backbone_hash: hash table containing all detected backbone gateways
  * @bcast_duplist: recently received broadcast packets array (for broadcast
@@ -799,7 +799,7 @@ struct batadv_softif_vlan {
  * @dat: distributed arp table data
  * @mcast: multicast data
  * @network_coding: bool indicating whether network coding is enabled
- * @batadv_priv_nc: network coding data
+ * @nc: network coding data
  */
 struct batadv_priv {
 	atomic_t mesh_state;
@@ -934,7 +934,7 @@ struct batadv_bla_backbone_gw {
  * struct batadv_bla_claim - claimed non-mesh client structure
  * @addr: mac address of claimed non-mesh client
  * @vid: vlan id this client was detected on
- * @batadv_bla_backbone_gw: pointer to backbone gw claiming this client
+ * @backbone_gw: pointer to backbone gw claiming this client
  * @lasttime: last time we heard of claim (locals only)
  * @hash_entry: hlist node for batadv_priv_bla::claim_hash
  * @refcount: number of contexts the object is used
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0015-batman-adv-Remove-kerneldoc-for-missing-struct-membe.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0015-batman-adv-Remove-kerneldoc-for-missing-struct-membe.patch"

From 4603d13e283566eaf12875137dfe6e7e8e0e5666 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:47 +0200
Subject: [PATCH 15/28] batman-adv: Remove kerneldoc for missing struct members

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d93501ed..1a67a1a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -371,9 +371,7 @@ struct batadv_hardif_neigh_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
- * @last_ttl: last received ttl from this neigh node
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_neigh_node {
 	struct hlist_node list;
@@ -1257,8 +1255,6 @@ struct batadv_dat_candidate {
  * struct batadv_tvlv_container - container for tvlv appended to OGMs
  * @list: hlist node for batadv_priv_tvlv::container_list
  * @tvlv_hdr: tvlv header information needed to construct the tvlv
- * @value_len: length of the buffer following this struct which contains
- *  the actual tvlv payload
  * @refcount: number of contexts the object is used
  */
 struct batadv_tvlv_container {
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0016-batman-adv-Add-kerneldoc-for-batadv_neigh_node-refco.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0016-batman-adv-Add-kerneldoc-for-batadv_neigh_node-refco.patch"

From edad1a2334e91c389884f18e4e763c84c6bb34f3 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:48 +0200
Subject: [PATCH 16/28] batman-adv: Add kerneldoc for
 batadv_neigh_node::refcount

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 1a67a1a..3437b66 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -371,6 +371,7 @@ struct batadv_hardif_neigh_node {
  * @ifinfo_lock: lock protecting private ifinfo members and list
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
+ * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_neigh_node {
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0017-batman-adv-Fix-kerneldoc-parsing-of-structs-enums.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0017-batman-adv-Fix-kerneldoc-parsing-of-structs-enums.patch"

From a74fab3b9ce45e54fbde52e101b9122f0a72ab8b Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:49 +0200
Subject: [PATCH 17/28] batman-adv: Fix kerneldoc parsing of structs/enums

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/multicast.h | 2 +-
 net/batman-adv/packet.h    | 8 ++++----
 net/batman-adv/types.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 8f3cb04..685219f 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -23,7 +23,7 @@
 struct sk_buff;
 
 /**
- * batadv_forw_mode - the way a packet should be forwarded as
+ * enum batadv_forw_mode - the way a packet should be forwarded as
  * @BATADV_FORW_ALL: forward the packet to all nodes (currently via classic
  *  flooding)
  * @BATADV_FORW_SINGLE: forward the packet to a single node (currently via the
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 0558e32..e80a8fc 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -158,7 +158,7 @@ enum batadv_tt_client_flags {
 };
 
 /**
- * batadv_vlan_flags - flags for the four MSB of any vlan ID field
+ * enum batadv_vlan_flags - flags for the four MSB of any vlan ID field
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
 enum batadv_vlan_flags {
@@ -230,7 +230,7 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
- * batadv_icmp_header - common members among all the ICMP packets
+ * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -256,7 +256,7 @@ struct batadv_icmp_header {
 };
 
 /**
- * batadv_icmp_packet - ICMP packet
+ * struct batadv_icmp_packet - ICMP packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -282,7 +282,7 @@ struct batadv_icmp_packet {
 #define BATADV_RR_LEN 16
 
 /**
- * batadv_icmp_packet_rr - ICMP RouteRecord packet
+ * struct batadv_icmp_packet_rr - ICMP RouteRecord packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 3437b66..8c3dda3 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -346,7 +346,7 @@ struct batadv_gw_node {
 };
 
 /**
- * batadv_hardif_neigh_node - unique neighbor per hard interface
+ * struct batadv_hardif_neigh_node - unique neighbor per hard interface
  * @list: list node for batadv_hard_iface::neigh_list
  * @addr: the MAC address of the neighboring interface
  * @if_incoming: pointer to incoming hard interface
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0018-batman-adv-Remove-kerneldoc-for-missing-parameters.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0018-batman-adv-Remove-kerneldoc-for-missing-parameters.patch"

From 1bdc1436f87fd4237ab53257a4923c414b813d71 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:50 +0200
Subject: [PATCH 18/28] batman-adv: Remove kerneldoc for missing parameters

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/fragmentation.c     | 1 -
 net/batman-adv/packet.h            | 1 -
 net/batman-adv/routing.c           | 1 -
 net/batman-adv/translation-table.c | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 20d9282..fedddbe 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -242,7 +242,6 @@ err:
 /**
  * batadv_frag_merge_packets - merge a chain of fragments
  * @chain: head of chain with fragments
- * @skb: packet with total size of skb after merging
  *
  * Expand the first skb in the chain and copy the content of the remaining
  * skb's into the expanded one. After doing so, clear the chain.
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index e80a8fc..6d5b178 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -413,7 +413,6 @@ struct batadv_bcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
- * @reserved: Align following fields to 2-byte boundaries
  * @first_source: original source of first included packet
  * @first_orig_dest: original destinal of first included packet
  * @first_crc: checksum of first included packet
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index e4f2646..54d6608 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -904,7 +904,6 @@ rx_success:
  * batadv_recv_unicast_tvlv - receive and process unicast tvlv packets
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
- * @dst_addr: the payload destination
  *
  * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
  * otherwise.
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a22080c..148fc14 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -217,7 +217,6 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
- * @hash: hash table containing the tt entries
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -302,7 +301,6 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_size_mod - change the size by v of the local table
  *  identified by vid
- * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -2408,7 +2406,6 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
  * @orig_node: originator for which the CRCs have to be checked
  * @tt_vlan: pointer to the first tvlv VLAN entry
  * @num_vlan: number of tvlv VLAN entries
- * @create: if true, create VLAN objects if not found
  *
  * Return true if all the received CRCs match the locally stored ones, false
  * otherwise
@@ -3377,7 +3374,6 @@ out:
  * @tt_change: pointer to the first entry in the TT buffer
  * @tt_num_changes: number of tt changes inside the tt buffer
  * @ttvn: translation table version number of this changeset
- * @tt_crc: crc32 checksum of orig node's translation table
  */
 static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0019-batman-adv-Fix-names-in-kerneldoc-of-functions.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0019-batman-adv-Fix-names-in-kerneldoc-of-functions.patch"

From 27388b788dde7d3a2f016c94770494bdef40648e Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:51 +0200
Subject: [PATCH 19/28] batman-adv: Fix names in kerneldoc of functions

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/originator.c        | 4 ++--
 net/batman-adv/packet.h            | 2 +-
 net/batman-adv/send.c              | 2 +-
 net/batman-adv/soft-interface.c    | 2 +-
 net/batman-adv/translation-table.c | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3c782a33..b27cc5b 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -416,7 +416,7 @@ out:
 
 /**
  * batadv_neigh_ifinfo_get - find the ifinfo from an neigh_node
- * @neigh_node: the neigh node to be queried
+ * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
  * The object is returned with refcounter increased by 1.
@@ -449,7 +449,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 
 /**
  * batadv_neigh_ifinfo_new - search and possibly create an neigh_ifinfo object
- * @neigh_node: the neigh node to be queried
+ * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
  * Returns NULL in case of failure or the neigh_ifinfo object for the
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 6d5b178..72fd5b0 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -494,7 +494,7 @@ struct batadv_tvlv_gateway_data {
  * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
- * @vlan_num: number of announced VLANs. In the TVLV this struct is followed by
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
  *  one batadv_tvlv_tt_vlan_data object per announced vlan
  */
 struct batadv_tvlv_tt_data {
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 782fa33..3fbf791 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -211,7 +211,7 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
  *  unicast 4addr header
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the skb containing the payload to encapsulate
- * @orig_node: the destination node
+ * @orig: the destination node
  * @packet_subtype: the unicast 4addr packet subtype to use
  *
  * Returns false if the payload could not be encapsulated or true otherwise.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index ac4d08d..c923e3c 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -480,7 +480,7 @@ out:
 /**
  * batadv_softif_vlan_free_ref - decrease the vlan object refcounter and
  *  possibly free it
- * @softif_vlan: the vlan object to release
+ * @vlan: the vlan object to release
  */
 void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 148fc14..2e57d10 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3368,8 +3368,8 @@ out:
  * batadv_tt_update_orig - update global translation table with new tt
  *  information received via ogms
  * @bat_priv: the bat priv with all the soft interface information
- * @orig: the orig_node of the ogm
- * @tt_vlan: pointer to the first tvlv VLAN entry
+ * @orig_node: the orig_node of the ogm
+ * @tt_buff: pointer to the first tvlv VLAN entry
  * @tt_num_vlan: number of tvlv VLAN entries
  * @tt_change: pointer to the first entry in the TT buffer
  * @tt_num_changes: number of tt changes inside the tt buffer
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0020-batman-adv-Drop-invalid-kerneldoc-for-variable-batad.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0020-batman-adv-Drop-invalid-kerneldoc-for-variable-batad.patch"

From 19a8072c11d9422c3c134e4f104f8624503acd7c Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 6 Sep 2015 21:38:53 +0200
Subject: [PATCH 20/28] batman-adv: Drop invalid kerneldoc for variable
 batadv_vlan_attrs

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index fe87777..33772d9 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -620,9 +620,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 
 BATADV_ATTR_VLAN_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 
-/**
- * batadv_vlan_attrs - array of vlan specific sysfs attributes
- */
+/* array of vlan specific sysfs attributes */
 static struct batadv_attribute *batadv_vlan_attrs[] = {
 	&batadv_attr_vlan_ap_isolation,
 	NULL,
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0021-batman-adv-kernel-doc-readability-updates.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0021-batman-adv-kernel-doc-readability-updates.patch"

From 99c7faa44ae65d5a15ba994c861edbfc368f5225 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 15 Aug 2015 18:04:59 +0800
Subject: [PATCH 21/28] batman-adv: kernel doc readability updates

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8c3dda3..7f7a0f1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -73,7 +73,7 @@ enum batadv_dhcp_recipient {
 #define BATADV_TT_SYNC_MASK	0x00F0
 
 /**
- * struct batadv_hard_iface_bat_iv - per hard interface B.A.T.M.A.N. IV data
+ * struct batadv_hard_iface_bat_iv - per hard-interface B.A.T.M.A.N. IV data
  * @ogm_buff: buffer holding the OGM packet
  * @ogm_buff_len: length of the OGM packet buffer
  * @ogm_seqno: OGM sequence number - used to identify each OGM
@@ -97,8 +97,8 @@ struct batadv_hard_iface_bat_iv {
  *  batman-adv for this interface
  * @soft_iface: the batman-adv interface which uses this network interface
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: BATMAN IV specific per hard interface data
- * @cleanup_work: work queue callback item for hard interface deinit
+ * @bat_iv: per hard-interface B.A.T.M.A.N. IV data
+ * @cleanup_work: work queue callback item for hard-interface deinit
  * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
  * @neigh_list: list of unique single hop neighbors via this interface
  * @neigh_list_lock: lock protecting neigh_list
@@ -125,7 +125,7 @@ struct batadv_hard_iface {
 /**
  * struct batadv_orig_ifinfo - originator info per outgoing interface
  * @list: list node for orig_node::ifinfo_list
- * @if_outgoing: pointer to outgoing hard interface
+ * @if_outgoing: pointer to outgoing hard-interface
  * @router: router that should be used to reach this originator
  * @last_real_seqno: last and best known sequence number
  * @last_ttl: ttl of last received packet
@@ -202,7 +202,7 @@ struct batadv_orig_node_vlan {
 
 /**
  * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
- * @bcast_own: set of bitfields (one per hard interface) where each one counts
+ * @bcast_own: set of bitfields (one per hard-interface) where each one counts
  * the number of our OGMs this orig_node rebroadcasted "back" to us  (relative
  * to last_real_seqno). Every bitfield is BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
  * @bcast_own_sum: sum of bcast_own
@@ -346,10 +346,11 @@ struct batadv_gw_node {
 };
 
 /**
- * struct batadv_hardif_neigh_node - unique neighbor per hard interface
+ * struct batadv_hardif_neigh_node - unique neighbor per hard-interface
  * @list: list node for batadv_hard_iface::neigh_list
  * @addr: the MAC address of the neighboring interface
- * @if_incoming: pointer to incoming hard interface
+ * @if_incoming: pointer to incoming hard-interface
+ * @last_seen: when last packet via this neighbor was received
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in a RCU-safe manner
  */
@@ -369,7 +370,7 @@ struct batadv_hardif_neigh_node {
  * @addr: the MAC address of the neighboring interface
  * @ifinfo_list: list for routing metrics per outgoing interface
  * @ifinfo_lock: lock protecting private ifinfo members and list
- * @if_incoming: pointer to incoming hard interface
+ * @if_incoming: pointer to incoming hard-interface
  * @last_seen: when last packet via this neighbor was received
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
@@ -388,7 +389,7 @@ struct batadv_neigh_node {
 
 /**
  * struct batadv_neigh_ifinfo_bat_iv - neighbor information per outgoing
- *  interface for BATMAN IV
+ *  interface for B.A.T.M.A.N. IV
  * @tq_recv: ring buffer of received TQ values from this neigh node
  * @tq_index: ring buffer index
  * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
@@ -407,7 +408,7 @@ struct batadv_neigh_ifinfo_bat_iv {
 /**
  * struct batadv_neigh_ifinfo - neighbor information per outgoing interface
  * @list: list node for batadv_neigh_node::ifinfo_list
- * @if_outgoing: pointer to outgoing hard interface
+ * @if_outgoing: pointer to outgoing hard-interface
  * @bat_iv: B.A.T.M.A.N. IV private structure
  * @last_ttl: last received ttl from this neigh node
  * @refcount: number of contexts the object is used
@@ -783,8 +784,8 @@ struct batadv_softif_vlan {
  * @forw_bat_list_lock: lock protecting forw_bat_list
  * @forw_bcast_list_lock: lock protecting forw_bcast_list
  * @orig_work: work queue callback item for orig node purging
- * @cleanup_work: work queue callback item for soft interface deinit
- * @primary_if: one of the hard interfaces assigned to this mesh interface
+ * @cleanup_work: work queue callback item for soft-interface deinit
+ * @primary_if: one of the hard-interfaces assigned to this mesh interface
  *  becomes the primary interface
  * @bat_algo_ops: routing algorithm used by this mesh interface
  * @softif_vlan_list: a list of softif_vlan structs, one per VLAN created on top
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0023-batman-adv-Fix-kerneldoc-of-main-functions.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0023-batman-adv-Fix-kerneldoc-of-main-functions.patch"

From 05af30045611a0c4b7c2d77172e5b212c698444c Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2015 12:29:29 +0100
Subject: [PATCH 23/28] batman-adv: Fix kerneldoc of main functions

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bitarray.c       | 12 +++++++++---
 net/batman-adv/bitarray.h       | 11 +++++------
 net/batman-adv/debugfs.c        |  6 ++++++
 net/batman-adv/main.c           |  2 ++
 net/batman-adv/main.h           |  4 ++++
 net/batman-adv/originator.c     |  4 +++-
 net/batman-adv/packet.h         |  6 ++++++
 net/batman-adv/routing.c        |  7 ++++++-
 net/batman-adv/send.c           |  5 ++++-
 net/batman-adv/soft-interface.c |  2 ++
 net/batman-adv/sysfs.c          |  1 +
 11 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 06bab51..3404195 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -29,10 +29,16 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
 	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZE);
 }
 
-/* receive and process one packet within the sequence number window.
+/**
+ * batadv_bit_get_packet - receive and process one packet within the sequence
+ *  number window
+ * @priv: the bat priv with all the soft interface information
+ * @seq_bits: pointer to the sequence number receive packet
+ * @seq_num_diff: difference between the current/received sequence number and
+ *  the last sequence number
+ * @set_mark: whether this packet should be marked in seq_bits
  *
- * Return:
- *  1 if the window was moved (either new or very old)
+ * Return: 1 if the window was moved (either new or very old),
  *  0 if the window was not moved/shifted.
  */
 int batadv_bit_get_packet(void *priv, unsigned long *seq_bits, s32 seq_num_diff,
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index cf2aeb0..2b64d7a 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -25,7 +25,11 @@
 #include <linux/types.h>
 
 /**
- * batadv_test_bit
+ * batadv_test_bit - check if bit is set in the current window
+ *
+ * @seq_bits: pointer to the sequence number receive packet
+ * @last_seqno: latest sequence number in seq_bits
+ * @curr_seqno: sequence number to test for
  *
  * Return: 1 if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno. Otherwise returns 0.
@@ -51,11 +55,6 @@ static inline void batadv_set_bit(unsigned long *seq_bits, s32 n)
 	set_bit(n, seq_bits); /* turn the position on */
 }
 
-/**
- * batadv_bit_get_packet - receive and process one packet
- *
- * Return: 1 if received seq_num is considered new, 0 if old
- */
 int batadv_bit_get_packet(void *priv, unsigned long *seq_bits, s32 seq_num_diff,
 			  int set_mark);
 
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 037ad0a..0fc9df5 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -281,6 +281,8 @@ static int batadv_originators_open(struct inode *inode, struct file *file)
  *  originator table of an hard interface
  * @inode: inode pointer to debugfs file
  * @file: pointer to the seq_file
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 static int batadv_originators_hardif_open(struct inode *inode,
 					  struct file *file)
@@ -329,6 +331,8 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
  * batadv_dat_cache_open - Prepare file handler for reads from dat_chache
  * @inode: inode which was opened
  * @file: file handle to be initialized
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 static int batadv_dat_cache_open(struct inode *inode, struct file *file)
 {
@@ -483,6 +487,8 @@ void batadv_debugfs_destroy(void)
  * batadv_debugfs_add_hardif - creates the base directory for a hard interface
  *  in debugfs.
  * @hard_iface: hard interface which should be added.
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 {
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 70907f6f..9d34be6 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -599,6 +599,8 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
  *
  * payload_ptr must always point to an address in the skb head buffer and not to
  * a fragment.
+ *
+ * Return: big endian crc32c of the checksummed data
  */
 __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 {
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8a48d4a..34f56ef 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -275,6 +275,8 @@ static inline void _batadv_dbg(int type __always_unused,
 
 /**
  * batadv_compare_eth - Compare two not u16 aligned Ethernet addresses
+ * @data1: Pointer to a six-byte array containing the Ethernet address
+ * @data2: Pointer other six-byte array containing the Ethernet address
  *
  * note: can't use ether_addr_equal() as it requires aligned memory
  *
@@ -331,6 +333,8 @@ static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 
 /**
  * batadv_sum_counter - Sum the cpu-local counters for index 'idx'
+ * @bat_priv: the bat priv with all the soft interface information
+ * @idx: index of counter to sum up
  *
  * Return: sum of all cpu-local counters
  */
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ddf22f5..00b0437 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -48,7 +48,9 @@ static struct lock_class_key batadv_orig_hash_lock_class_key;
 static void batadv_purge_orig(struct work_struct *work);
 
 /**
- * batadv_compare_orig
+ * batadv_compare_orig - comparing function used in the originator hash table
+ * @node: node in the local table
+ * @data2: second object to compare the node to
  *
  * Return: 1 if they are the same originator
  */
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 72fd5b0..fdb0163 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -209,6 +209,11 @@ struct batadv_bla_claim_dst {
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
  * @flags: contains routing relevant flags - see enum batadv_iv_flags
+ * @seqno: sequence identification
+ * @orig: address of the source node
+ * @prev_sender: address of the previous sender
+ * @reserved: reserved byte for alignment
+ * @tq: transmission quality
  * @tvlv_len: length of tvlv data following the ogm header
  */
 struct batadv_ogm_packet {
@@ -345,6 +350,7 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
+ * @reserved: reserved byte for alignment
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bcaa787..1fb1be3 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -141,8 +141,13 @@ out:
 }
 
 /**
- * batadv_window_protected checks whether the host restarted and is in the
+ * batadv_window_protected - checks whether the host restarted and is in the
  *  protection time.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @seq_num_diff: difference between the current/received sequence number and
+ *  the last sequence number
+ * @last_reset: jiffies timestamp of the last reset, will be updated when reset
+ *  is detected
  *
  * Return:
  *  0 if the packet is to be accepted.
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d9b93c5..c188f46 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -431,7 +431,10 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_add_bcast_packet_to_list
+ * batadv_add_bcast_packet_to_list - queue broadcast packet for multiple sends
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to add
+ * @delay: number of jiffies to wait before sending
  *
  * add a broadcast packet to the queue and setup timers. broadcast packets
  * are sent multiple times to increase probability for being received.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5ee794b..6c65de9 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -594,6 +594,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 /**
  * batadv_interface_add_vid - ndo_add_vid API implementation
  * @dev: the netdev of the mesh interface
+ * @proto: protocol of the the vlan id
  * @vid: identifier of the new vlan
  *
  * Set up all the internal structures for handling the new vlan on top of the
@@ -651,6 +652,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 /**
  * batadv_interface_kill_vid - ndo_kill_vid API implementation
  * @dev: the netdev of the mesh interface
+ * @proto: protocol of the the vlan id
  * @vid: identifier of the deleted vlan
  *
  * Destroy all the internal structures used to handle the vlan identified by vid
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 7658e6e..f38d7b7 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -82,6 +82,7 @@ static struct batadv_priv *batadv_vlan_kobj_to_batpriv(struct kobject *obj)
 
 /**
  * batadv_kobj_to_vlan - convert a kobj in the associated softif_vlan struct
+ * @bat_priv: the bat priv with all the soft interface information
  * @obj: kobject to covert
  *
  * Return: the associated softif_vlan struct if found, NULL otherwise.
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0022-batman-adv-Fix-kerneldoc-parsing-of-return-descripti.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0022-batman-adv-Fix-kerneldoc-parsing-of-return-descripti.patch"

From ffff90655467fd283b884d086047dd8e928f1674 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 15 Sep 2015 19:00:48 +0200
Subject: [PATCH 22/28] batman-adv: Fix kerneldoc parsing of return description

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_iv_ogm.c            | 18 +++----
 net/batman-adv/bitarray.c              |  2 +-
 net/batman-adv/bitarray.h              | 11 +++--
 net/batman-adv/bridge_loop_avoidance.c | 68 ++++++++++++++++++--------
 net/batman-adv/distributed-arp-table.c | 37 +++++++-------
 net/batman-adv/fragmentation.c         | 17 ++++---
 net/batman-adv/fragmentation.h         |  2 +-
 net/batman-adv/gateway_client.c        | 14 +++---
 net/batman-adv/gateway_common.c        |  2 +-
 net/batman-adv/hard-interface.c        |  7 +--
 net/batman-adv/hash.h                  | 22 +++++----
 net/batman-adv/main.c                  | 26 +++++-----
 net/batman-adv/main.h                  | 13 +++--
 net/batman-adv/multicast.c             | 35 +++++++-------
 net/batman-adv/network-coding.c        | 42 ++++++++--------
 net/batman-adv/originator.c            | 48 +++++++++++--------
 net/batman-adv/routing.c               | 30 +++++++-----
 net/batman-adv/send.c                  | 24 +++++-----
 net/batman-adv/send.h                  |  4 +-
 net/batman-adv/soft-interface.c        | 14 +++---
 net/batman-adv/sysfs.c                 | 10 ++--
 net/batman-adv/translation-table.c     | 88 ++++++++++++++++++++--------------
 22 files changed, 305 insertions(+), 229 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 2467024..ad678f0 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -88,7 +88,7 @@ static void batadv_ring_buffer_set(u8 lq_recv[], u8 *lq_index, u8 value)
  * in the given ring buffer
  * @lq_recv: pointer to the ring buffer
  *
- * Returns computed average value.
+ * Return: computed average value.
  */
 static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
 {
@@ -132,7 +132,7 @@ static void batadv_iv_ogm_orig_free(struct batadv_orig_node *orig_node)
  * @orig_node: the orig_node that has to be changed
  * @max_if_num: the current amount of interfaces
  *
- * Returns 0 on success, a negative error code otherwise.
+ * Return: 0 on success, a negative error code otherwise.
  */
 static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
 				     int max_if_num)
@@ -180,7 +180,7 @@ unlock:
  * @max_if_num: the current amount of interfaces
  * @del_if_num: the index of the interface being removed
  *
- * Returns 0 on success, a negative error code otherwise.
+ * Return: 0 on success, a negative error code otherwise.
  */
 static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
 				     int max_if_num, int del_if_num)
@@ -244,7 +244,7 @@ unlock:
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: mac address of the originator
  *
- * Returns the originator object corresponding to the passed mac address or NULL
+ * Return: the originator object corresponding to the passed mac address or NULL
  * on failure.
  * If the object does not exists it is created an initialised.
  */
@@ -520,7 +520,7 @@ out:
  * @if_outgoing: interface for which the retransmission should be considered
  * @forw_packet: the forwarded packet which should be checked
  *
- * Returns true if new_packet can be aggregated with forw_packet
+ * Return: true if new_packet can be aggregated with forw_packet
  */
 static bool
 batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
@@ -1123,7 +1123,7 @@ out:
  * @if_incoming: interface where the packet was received
  * @if_outgoing: interface for which the retransmission should be considered
  *
- * Returns 1 if the link can be considered bidirectional, 0 otherwise
+ * Return: 1 if the link can be considered bidirectional, 0 otherwise
  */
 static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 				 struct batadv_orig_node *orig_neigh_node,
@@ -1267,7 +1267,7 @@ out:
  * @if_incoming: interface on which the OGM packet was received
  * @if_outgoing: interface for which the retransmission should be considered
  *
- * Returns duplicate status as enum batadv_dup_status
+ * Return: duplicate status as enum batadv_dup_status
  */
 static enum batadv_dup_status
 batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
@@ -1927,7 +1927,7 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
  * @neigh2: the second neighbor object of the comparison
  * @if_outgoing2: outgoing interface for the second neighbor
  *
- * Returns a value less, equal to or greater than 0 if the metric via neigh1 is
+ * Return: a value less, equal to or greater than 0 if the metric via neigh1 is
  * lower, the same as or higher than the metric via neigh2
  */
 static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
@@ -1968,7 +1968,7 @@ out:
  * @neigh2: the second neighbor object of the comparison
  * @if_outgoing2: outgoing interface for the second neighbor
  *
- * Returns true if the metric via neigh1 is equally good or better than
+ * Return: true if the metric via neigh1 is equally good or better than
  * the metric via neigh2, false otherwise.
  */
 static bool
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 25cbc36..06bab51 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -31,7 +31,7 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
 
 /* receive and process one packet within the sequence number window.
  *
- * returns:
+ * Return:
  *  1 if the window was moved (either new or very old)
  *  0 if the window was not moved/shifted.
  */
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 0226b22..cf2aeb0 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -24,7 +24,10 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
-/* Returns 1 if the corresponding bit in the given seq_bits indicates true
+/**
+ * batadv_test_bit
+ *
+ * Return: 1 if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno. Otherwise returns 0.
  */
 static inline int batadv_test_bit(const unsigned long *seq_bits,
@@ -48,8 +51,10 @@ static inline void batadv_set_bit(unsigned long *seq_bits, s32 n)
 	set_bit(n, seq_bits); /* turn the position on */
 }
 
-/* receive and process one packet, returns 1 if received seq_num is considered
- * new, 0 if old
+/**
+ * batadv_bit_get_packet - receive and process one packet
+ *
+ * Return: 1 if received seq_num is considered new, 0 if old
  */
 int batadv_bit_get_packet(void *priv, unsigned long *seq_bits, s32 seq_num_diff,
 			  int set_mark);
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d5d71ac..7aeffd4 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -58,7 +58,11 @@ static void
 batadv_bla_send_announce(struct batadv_priv *bat_priv,
 			 struct batadv_bla_backbone_gw *backbone_gw);
 
-/* return the index of the claim */
+/**
+ * batadv_choose_claim
+ *
+ * Return: the index of the claim
+ */
 static inline u32 batadv_choose_claim(const void *data, u32 size)
 {
 	struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
@@ -70,7 +74,11 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
 	return hash % size;
 }
 
-/* return the index of the backbone gateway */
+/**
+ * batadv_choose_backbone_gw
+ *
+ * Return: the index of the backbone gateway
+ */
 static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 {
 	const struct batadv_bla_claim *claim = (struct batadv_bla_claim *)data;
@@ -149,8 +157,9 @@ static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
  * @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
- * looks for a claim in the hash, and returns it if found
- * or NULL otherwise.
+ * looks for a claim in the hash
+ *
+ * Return: claim if found or NULL otherwise.
  */
 static struct batadv_bla_claim
 *batadv_claim_hash_find(struct batadv_priv *bat_priv,
@@ -190,7 +199,7 @@ static struct batadv_bla_claim
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
- * Returns claim if found or NULL otherwise.
+ * Return: claim if found or NULL otherwise.
  */
 static struct batadv_bla_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
@@ -670,7 +679,11 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	batadv_claim_free_ref(claim);
 }
 
-/* check for ANNOUNCE frame, return 1 if handled */
+/**
+ * batadv_handle_announce - check for ANNOUNCE frame
+ *
+ * Return: 1 if handled
+ */
 static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 				  u8 *backbone_addr, unsigned short vid)
 {
@@ -720,7 +733,11 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 	return 1;
 }
 
-/* check for REQUEST frame, return 1 if handled */
+/**
+ * batadv_handle_request - check for REQUEST frame
+ *
+ * Return: 1 if handled
+ */
 static int batadv_handle_request(struct batadv_priv *bat_priv,
 				 struct batadv_hard_iface *primary_if,
 				 u8 *backbone_addr, struct ethhdr *ethhdr,
@@ -744,7 +761,11 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 	return 1;
 }
 
-/* check for UNCLAIM frame, return 1 if handled */
+/**
+ * batadv_handle_unclaim - check for UNCLAIM frame
+ *
+ * Return: 1 if handled
+ */
 static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 				 struct batadv_hard_iface *primary_if,
 				 u8 *backbone_addr, u8 *claim_addr,
@@ -773,7 +794,11 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 	return 1;
 }
 
-/* check for CLAIM frame, return 1 if handled */
+/**
+ * batadv_handle_claim - check for CLAIM frame
+ *
+ * Return: 1 if handled
+ */
 static int batadv_handle_claim(struct batadv_priv *bat_priv,
 			       struct batadv_hard_iface *primary_if,
 			       u8 *backbone_addr, u8 *claim_addr,
@@ -813,7 +838,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
  * This function also applies the group ID of the sender
  * if it is in the same mesh.
  *
- * returns:
+ * Return:
  *	2  - if it is a claim packet and on the same group
  *	1  - if is a claim packet from another group
  *	0  - if it is not a claim packet
@@ -884,7 +909,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
  *
  * Check if this is a claim frame, and process it accordingly.
  *
- * returns 1 if it was a claim frame, otherwise return 0 to
+ * Return: 1 if it was a claim frame, otherwise return 0 to
  * tell the callee that it can use the frame on its own.
  */
 static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
@@ -1401,7 +1426,7 @@ out:
  *
  * Check if the originator is a gateway for the VLAN identified by vid.
  *
- * Returns true if orig is a backbone for this vid, false otherwise.
+ * Return: true if orig is a backbone for this vid, false otherwise.
  */
 bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 				    unsigned short vid)
@@ -1440,9 +1465,10 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
- * bla_is_backbone_gw inspects the skb for the VLAN ID and returns 1
- * if the orig_node is also a gateway on the soft interface, otherwise it
- * returns 0.
+ * bla_is_backbone_gw inspects the skb for the VLAN ID
+ *
+ * Return: 1 if the orig_node is also a gateway on the soft interface, otherwise
+ * it returns 0.
  */
 int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 			      struct batadv_orig_node *orig_node, int hdr_size)
@@ -1502,8 +1528,9 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
  *  * we have to race for a claim
  *  * if the frame is allowed on the LAN
  *
- * in these cases, the skb is further handled by this function and
- * returns 1, otherwise it returns 0 and the caller shall further
+ * in these cases, the skb is further handled by this function
+ *
+ * Return: 1 if handled, otherwise it returns 0 and the caller shall further
  * process the skb.
  */
 int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
@@ -1596,11 +1623,12 @@ out:
  *  * a claim was received which has to be processed
  *  * the frame is allowed on the mesh
  *
- * in these cases, the skb is further handled by this function and
- * returns 1, otherwise it returns 0 and the caller shall further
- * process the skb.
+ * in these cases, the skb is further handled by this function.
  *
  * This call might reallocate skb data.
+ *
+ * Return: 1 if handled, otherwise it returns 0 and the caller shall further
+ * process the skb.
  */
 int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		  unsigned short vid)
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a49c705..2f13429 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -76,7 +76,7 @@ static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
  * batadv_dat_to_purge - check whether a dat_entry has to be purged or not
  * @dat_entry: the entry to check
  *
- * Returns true if the entry has to be purged now, false otherwise.
+ * Return: true if the entry has to be purged now, false otherwise.
  */
 static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 {
@@ -151,7 +151,7 @@ static void batadv_dat_purge(struct work_struct *work)
  * @node: node in the local table
  * @data2: second object to compare the node to
  *
- * Returns 1 if the two entries are the same, 0 otherwise.
+ * Return: 1 if the two entries are the same, 0 otherwise.
  */
 static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
@@ -166,7 +166,7 @@ static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
- * Returns the value of the hw_src field in the ARP packet.
+ * Return: the value of the hw_src field in the ARP packet.
  */
 static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
 {
@@ -183,7 +183,7 @@ static u8 *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
- * Returns the value of the ip_src field in the ARP packet.
+ * Return: the value of the ip_src field in the ARP packet.
  */
 static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
 {
@@ -195,7 +195,7 @@ static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
- * Returns the value of the hw_dst field in the ARP packet.
+ * Return: the value of the hw_dst field in the ARP packet.
  */
 static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
 {
@@ -207,7 +207,7 @@ static u8 *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  *
- * Returns the value of the ip_dst field in the ARP packet.
+ * Return: the value of the ip_dst field in the ARP packet.
  */
 static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 {
@@ -219,7 +219,7 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
  * @data: data to hash
  * @size: size of the hash table
  *
- * Returns the selected index in the hash table for the given data.
+ * Return: the selected index in the hash table for the given data.
  */
 static u32 batadv_hash_dat(const void *data, u32 size)
 {
@@ -256,7 +256,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
  * @ip: search key
  * @vid: VLAN identifier
  *
- * Returns the dat_entry if found, NULL otherwise.
+ * Return: the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
 batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
@@ -440,7 +440,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * @candidate: orig_node under evaluation
  * @max_orig_node: last selected candidate
  *
- * Returns true if the node has been elected as next candidate or false
+ * Return: true if the node has been elected as next candidate or false
  * otherwise.
  */
 static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
@@ -558,7 +558,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * closest values (from the LEFT, with wrap around if needed) then the hash
  * value of the key. ip_dst is the key.
  *
- * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
+ * Return: the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
 static struct batadv_dat_candidate *
 batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
@@ -602,7 +602,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * This function copies the skb with pskb_copy() and is sent as unicast packet
  * to each of the selected candidates.
  *
- * Returns true if the packet is sent to at least one candidate, false
+ * Return: true if the packet is sent to at least one candidate, false
  * otherwise.
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
@@ -831,7 +831,7 @@ out:
  * @skb: packet to analyse
  * @hdr_size: size of the possible header before the ARP packet in the skb
  *
- * Returns the ARP type if the skb contains a valid ARP packet, 0 otherwise.
+ * Return: the ARP type if the skb contains a valid ARP packet, 0 otherwise.
  */
 static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
 			       struct sk_buff *skb, int hdr_size)
@@ -904,8 +904,9 @@ out:
  * @skb: the buffer containing the packet to extract the VID from
  * @hdr_size: the size of the batman-adv header encapsulating the packet
  *
- * If the packet embedded in the skb is vlan tagged this function returns the
- * VID with the BATADV_VLAN_HAS_TAG flag. Otherwise BATADV_NO_FLAGS is returned.
+ * Return: If the packet embedded in the skb is vlan tagged this function
+ * returns the VID with the BATADV_VLAN_HAS_TAG flag. Otherwise BATADV_NO_FLAGS
+ * is returned.
  */
 static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 {
@@ -930,7 +931,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  *
- * Returns true if the message has been sent to the dht candidates, false
+ * Return: true if the message has been sent to the dht candidates, false
  * otherwise. In case of a positive return value the message has to be enqueued
  * to permit the fallback.
  */
@@ -1020,7 +1021,7 @@ out:
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
- * Returns true if the request has been answered, false otherwise.
+ * Return: true if the request has been answered, false otherwise.
  */
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
@@ -1143,7 +1144,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
- * Returns true if the packet was snooped and consumed by DAT. False if the
+ * Return: true if the packet was snooped and consumed by DAT. False if the
  * packet has to be delivered to the interface
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
@@ -1200,7 +1201,7 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @forw_packet: the broadcast packet
  *
- * Returns true if the node can drop the packet, false otherwise.
+ * Return: true if the node can drop the packet, false otherwise.
  */
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet)
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index fedddbe..80eddf4 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -85,7 +85,7 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
 /**
  * batadv_frag_size_limit - maximum possible size of packet to be fragmented
  *
- * Returns the maximum size of payload that can be fragmented.
+ * Return: the maximum size of payload that can be fragmented.
  */
 static int batadv_frag_size_limit(void)
 {
@@ -107,7 +107,7 @@ static int batadv_frag_size_limit(void)
  *
  * Caller must hold chain->lock.
  *
- * Returns true if chain is empty and caller can just insert the new fragment
+ * Return: true if chain is empty and caller can just insert the new fragment
  * without searching for the right position.
  */
 static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
@@ -136,7 +136,7 @@ static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
  * Insert a new fragment into the reverse ordered chain in the right table
  * entry. The hash table entry is cleared if "old" fragments exist in it.
  *
- * Returns true if skb is buffered, false on error. If the chain has all the
+ * Return: true if skb is buffered, false on error. If the chain has all the
  * fragments needed to merge the packet, the chain is moved to the passed head
  * to avoid locking the chain in the table.
  */
@@ -246,7 +246,7 @@ err:
  * Expand the first skb in the chain and copy the content of the remaining
  * skb's into the expanded one. After doing so, clear the chain.
  *
- * Returns the merged skb or NULL on error.
+ * Return: the merged skb or NULL on error.
  */
 static struct sk_buff *
 batadv_frag_merge_packets(struct hlist_head *chain)
@@ -306,6 +306,9 @@ free:
  * There are three possible outcomes: 1) Packet is merged: Return true and
  * set *skb to merged packet; 2) Packet is buffered: Return true and set *skb
  * to NULL; 3) Error: Return false and leave skb as is.
+ *
+ * Return: true when packet is merged or buffered, false when skb is not not
+ * used.
  */
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node_src)
@@ -343,7 +346,7 @@ out_err:
  * will exceed the MTU towards the next-hop. If so, the fragment is forwarded
  * without merging it.
  *
- * Returns true if the fragment is consumed/forwarded, false otherwise.
+ * Return: true if the fragment is consumed/forwarded, false otherwise.
  */
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
@@ -398,7 +401,7 @@ out:
  * passed mtu and the old one with the rest. The new skb contains data from the
  * tail of the old skb.
  *
- * Returns the new fragment, NULL on error.
+ * Return: the new fragment, NULL on error.
  */
 static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 					  struct batadv_frag_packet *frag_head,
@@ -432,7 +435,7 @@ err:
  * @orig_node: final destination of the created fragments
  * @neigh_node: next-hop of the created fragments
  *
- * Returns true on success, false otherwise.
+ * Return: true on success, false otherwise.
  */
 bool batadv_frag_send_packet(struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node,
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 8b9877e..c5476fe 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -42,7 +42,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
  * batadv_frag_check_entry - check if a list of fragments has timed out
  * @frags_entry: table entry to check
  *
- * Returns true if the frags entry has timed out, false otherwise.
+ * Return: true if the frags entry has timed out, false otherwise.
  */
 static inline bool
 batadv_frag_check_entry(struct batadv_frag_table_entry *frags_entry)
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e6c8382..8350775 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -456,7 +456,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
  *
- * Returns gateway node if found or NULL otherwise.
+ * Return: gateway node if found or NULL otherwise.
  */
 static struct batadv_gw_node *
 batadv_gw_node_get(struct batadv_priv *bat_priv,
@@ -655,13 +655,13 @@ out:
  * @chaddr: buffer where the client address will be stored. Valid
  *  only if the function returns BATADV_DHCP_TO_CLIENT
  *
- * Returns:
+ * This function may re-allocate the data buffer of the skb passed as argument.
+ *
+ * Return:
  * - BATADV_DHCP_NO if the packet is not a dhcp message or if there was an error
  *   while parsing it
  * - BATADV_DHCP_TO_SERVER if this is a message going to the DHCP server
  * - BATADV_DHCP_TO_CLIENT if this is a message going to a DHCP client
- *
- * This function may re-allocate the data buffer of the skb passed as argument.
  */
 enum batadv_dhcp_recipient
 batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
@@ -776,11 +776,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
  * server. Due to topology changes it may be the case that the GW server
  * previously selected is not the best one anymore.
  *
- * Returns true if the packet destination is unicast and it is not the best gw,
- * false otherwise.
- *
  * This call might reallocate skb data.
  * Must be invoked only when the DHCP packet is going TO a DHCP SERVER.
+ *
+ * Return: true if the packet destination is unicast and it is not the best gw,
+ * false otherwise.
  */
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb)
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b51bfac..b287448 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -38,7 +38,7 @@
  * @description: text shown when throughput string cannot be parsed
  * @throughput: pointer holding the returned throughput information
  *
- * Returns false on parse error and true otherwise.
+ * Return: false on parse error and true otherwise.
  */
 static bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
 				    const char *description, u32 *throughput)
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 01acccc..49e05d2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -85,7 +85,7 @@ out:
  * This function recursively checks all the fathers of the device passed as
  * argument looking for a batman-adv soft interface.
  *
- * Returns true if the device is descendant of a batman-adv mesh interface (or
+ * Return: true if the device is descendant of a batman-adv mesh interface (or
  * if it is a batman-adv interface itself), false otherwise
  */
 static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
@@ -136,7 +136,7 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
  *  interface
  * @net_device: the device to check
  *
- * Returns true if the net device is a 802.11 wireless device, false otherwise.
+ * Return: true if the net device is a 802.11 wireless device, false otherwise.
  */
 bool batadv_is_wifi_netdev(struct net_device *net_device)
 {
@@ -401,7 +401,8 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
  *
  * Invoke ndo_del_slave on master passing slave as argument. In this way slave
  * is free'd and master can correctly change its internal state.
- * Return 0 on success, a negative value representing the error otherwise
+ *
+ * Return: 0 on success, a negative value representing the error otherwise
  */
 static int batadv_master_del_slave(struct batadv_hard_iface *slave,
 				   struct net_device *master)
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 3776262..071a87e 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -30,14 +30,17 @@
 struct lock_class_key;
 
 /* callback to a compare function.  should compare 2 element datas for their
- * keys, return 0 if same and not 0 if not same
+ * keys
+ *
+ * Return: 0 if same and not 0 if not same
  */
 typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
 					  const void *);
 
-/* the hashfunction, should return an index
- * based on the key in the data of the first
- * argument and the size the second
+/* the hashfunction
+ *
+ * Return: an index based on the key in the data of the first argument and the
+ * size the second
  */
 typedef u32 (*batadv_hashdata_choose_cb)(const void *, u32);
 typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
@@ -96,7 +99,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	@data: data passed to the aforementioned callbacks as argument
  *	@data_node: to be added element
  *
- *	Returns 0 on success, 1 if the element already is in the hash
+ *	Return: 0 on success, 1 if the element already is in the hash
  *	and -1 on error.
  */
 static inline int batadv_hash_add(struct batadv_hashtable *hash,
@@ -139,10 +142,11 @@ out:
 	return ret;
 }
 
-/* removes data from hash, if found. returns pointer do data on success, so you
- * can remove the used structure yourself, or NULL on error .  data could be the
- * structure you use with just the key filled, we just need the key for
- * comparing.
+/* removes data from hash, if found. data could be the structure you use with
+ * just the key filled, we just need the key for comparing.
+ *
+ * Return: returns pointer do data on success, so you can remove the used
+ * structure yourself, or NULL on error
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 				       batadv_hashdata_compare_cb compare,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4b5d61f..70907f6f 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -233,7 +233,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address to check
  *
- * Returns 'true' if the mac address was found, false otherwise.
+ * Return: 'true' if the mac address was found, false otherwise.
  */
 bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
 {
@@ -262,7 +262,7 @@ bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
  *  function that requires the primary interface
  * @seq: debugfs table seq_file struct
  *
- * Returns primary interface if found or NULL otherwise.
+ * Return: primary interface if found or NULL otherwise.
  */
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq)
@@ -297,7 +297,7 @@ out:
  * batadv_max_header_len - calculate maximum encapsulation overhead for a
  *  payload packet
  *
- * Return the maximum encapsulation overhead in bytes.
+ * Return: the maximum encapsulation overhead in bytes.
  */
 int batadv_max_header_len(void)
 {
@@ -640,7 +640,7 @@ batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
  * @type: tvlv handler type to look for
  * @version: tvlv handler version to look for
  *
- * Returns tvlv handler if found or NULL otherwise.
+ * Return: tvlv handler if found or NULL otherwise.
  */
 static struct batadv_tvlv_handler
 *batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
@@ -688,7 +688,7 @@ static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
  * Has to be called with the appropriate locks being acquired
  * (tvlv.container_list_lock).
  *
- * Returns tvlv container if found or NULL otherwise.
+ * Return: tvlv container if found or NULL otherwise.
  */
 static struct batadv_tvlv_container
 *batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
@@ -720,7 +720,7 @@ static struct batadv_tvlv_container
  * Has to be called with the appropriate locks being acquired
  * (tvlv.container_list_lock).
  *
- * Returns size of all currently registered tvlv containers in bytes.
+ * Return: size of all currently registered tvlv containers in bytes.
  */
 static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 {
@@ -826,7 +826,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
  * @additional_packet_len: requested additional packet size on top of minimum
  *  size
  *
- * Returns true of the packet buffer could be changed to the requested size,
+ * Return: true of the packet buffer could be changed to the requested size,
  * false otherwise.
  */
 static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
@@ -862,7 +862,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  * The ogm packet might be enlarged or shrunk depending on the current size
  * and the size of the to-be-appended tvlv containers.
  *
- * Returns size of all appended tvlv containers in bytes.
+ * Return: size of all appended tvlv containers in bytes.
  */
 u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
@@ -915,7 +915,7 @@ end:
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Returns success if handler was not found or the return value of the handler
+ * Return: success if handler was not found or the return value of the handler
  * callback.
  */
 static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
@@ -968,7 +968,7 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Returns success when processing an OGM or the return value of all called
+ * Return: success when processing an OGM or the return value of all called
  * handler callbacks.
  */
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
@@ -1190,8 +1190,8 @@ out:
  * @skb: the buffer containing the packet
  * @header_len: length of the batman header preceding the ethernet header
  *
- * If the packet embedded in the skb is vlan tagged this function returns the
- * VID with the BATADV_VLAN_HAS_TAG flag. Otherwise BATADV_NO_FLAGS is returned.
+ * Return: VID with the BATADV_VLAN_HAS_TAG flag when the packet embedded in the
+ * skb is vlan tagged. Otherwise BATADV_NO_FLAGS.
  */
 unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
 {
@@ -1218,7 +1218,7 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
  * @vid: the VLAN identifier for which the AP isolation attributed as to be
  *  looked up
  *
- * Returns true if AP isolation is on for the VLAN idenfied by vid, false
+ * Return: true if AP isolation is on for the VLAN idenfied by vid, false
  * otherwise
  */
 bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 9dbd910..8a48d4a 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -273,9 +273,12 @@ static inline void _batadv_dbg(int type __always_unused,
 		pr_err("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
 
-/* returns 1 if they are the same ethernet addr
+/**
+ * batadv_compare_eth - Compare two not u16 aligned Ethernet addresses
  *
  * note: can't use ether_addr_equal() as it requires aligned memory
+ *
+ * Return: 1 if they are the same ethernet addr
  */
 static inline bool batadv_compare_eth(const void *data1, const void *data2)
 {
@@ -287,7 +290,7 @@ static inline bool batadv_compare_eth(const void *data1, const void *data2)
  * @timestamp:		base value to compare with (in jiffies)
  * @timeout:		added to base value before comparing (in milliseconds)
  *
- * Returns true if current time is after timestamp + timeout
+ * Return: true if current time is after timestamp + timeout
  */
 static inline bool batadv_has_timed_out(unsigned long timestamp,
 					unsigned int timeout)
@@ -326,7 +329,11 @@ static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 
 #define batadv_inc_counter(b, i) batadv_add_counter(b, i, 1)
 
-/* Sum and return the cpu-local counters for index 'idx' */
+/**
+ * batadv_sum_counter - Sum the cpu-local counters for index 'idx'
+ *
+ * Return: sum of all cpu-local counters
+ */
 static inline u64 batadv_sum_counter(struct batadv_priv *bat_priv,  size_t idx)
 {
 	u64 *counters, sum = 0;
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index eb76386..8abf488 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -55,7 +55,7 @@
  * Collect multicast addresses of the local multicast listeners
  * on the given soft interface, dev, in the given mcast_list.
  *
- * Returns -ENOMEM on memory allocation error or the number of
+ * Return: -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
  */
 static int batadv_mcast_mla_softif_get(struct net_device *dev,
@@ -87,7 +87,7 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
  * @mcast_addr: the multicast address to check
  * @mcast_list: the list with multicast addresses to search in
  *
- * Returns true if the given address is already in the given list.
+ * Return: true if the given address is already in the given list.
  * Otherwise returns false.
  */
 static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
@@ -195,8 +195,9 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
  * batadv_mcast_has_bridge - check whether the soft-iface is bridged
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Checks whether there is a bridge on top of our soft interface. Returns
- * true if so, false otherwise.
+ * Checks whether there is a bridge on top of our soft interface.
+ *
+ * Return: true if there is a bridge, false otherwise.
  */
 static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 {
@@ -218,7 +219,7 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
  * Updates the own multicast tvlv with our current multicast related settings,
  * capabilities and inabilities.
  *
- * Returns true if the tvlv container is registered afterwards. Otherwise
+ * Return: true if the tvlv container is registered afterwards. Otherwise
  * returns false.
  */
 static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
@@ -289,8 +290,8 @@ out:
  * Checks whether the given IPv4 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
  *
- * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM in case of
- * memory allocation failure.
+ * Return: If so then 0. Otherwise -EINVAL or -ENOMEM in case of memory
+ * allocation failure.
  */
 static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
@@ -327,8 +328,7 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  * Checks whether the given IPv6 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
  *
- * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM if we are out
- * of memory.
+ * Return: If so then 0. Otherwise -EINVAL is or -ENOMEM if we are out of memory
  */
 static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
@@ -366,8 +366,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * Checks whether the given multicast ethernet frame has the potential to be
  * forwarded with a mode more optimal than classic flooding.
  *
- * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM if we are out
- * of memory.
+ * Return: If so then 0. Otherwise -EINVAL is or -ENOMEM if we are out of memory
  */
 static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
@@ -398,7 +397,7 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: ethernet header of a packet
  *
- * Returns the number of nodes which want all IPv4 multicast traffic if the
+ * Return: the number of nodes which want all IPv4 multicast traffic if the
  * given ethhdr is from an IPv4 packet or the number of nodes which want all
  * IPv6 traffic if it matches an IPv6 packet.
  */
@@ -421,7 +420,7 @@ static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the ether header containing the multicast destination
  *
- * Returns an orig_node matching the multicast address provided by ethhdr
+ * Return: an orig_node matching the multicast address provided by ethhdr
  * via a translation table lookup. This increases the returned nodes refcount.
  */
 static struct batadv_orig_node *
@@ -436,7 +435,7 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
  * batadv_mcast_want_forw_ipv4_node_get - get a node with an ipv4 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set and
+ * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set and
  * increases its refcount.
  */
 static struct batadv_orig_node *
@@ -463,7 +462,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
  * batadv_mcast_want_forw_ipv6_node_get - get a node with an ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
+ * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
  * and increases its refcount.
  */
 static struct batadv_orig_node *
@@ -491,7 +490,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: an ethernet header to determine the protocol family from
  *
- * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 or
+ * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 or
  * BATADV_MCAST_WANT_ALL_IPV6 flag, depending on the provided ethhdr, set and
  * increases its refcount.
  */
@@ -514,7 +513,7 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
  * batadv_mcast_want_forw_unsnoop_node_get - get a node with an unsnoopable flag
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag
+ * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag
  * set and increases its refcount.
  */
 static struct batadv_orig_node *
@@ -543,7 +542,7 @@ batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
  * @skb: The multicast packet to check
  * @orig: an originator to be set to forward the skb to
  *
- * Returns the forwarding mode as enum batadv_forw_mode and in case of
+ * Return: the forwarding mode as enum batadv_forw_mode and in case of
  * BATADV_FORW_SINGLE set the orig to the single originator the skb
  * should be forwarded to.
  */
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index c98b0ab..25d35da 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -254,7 +254,7 @@ static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_node: the nc node to check
  *
- * Returns true if the entry has to be purged now, false otherwise
+ * Return: true if the entry has to be purged now, false otherwise
  */
 static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
 				       struct batadv_nc_node *nc_node)
@@ -270,7 +270,7 @@ static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path to check
  *
- * Returns true if the entry has to be purged now, false otherwise
+ * Return: true if the entry has to be purged now, false otherwise
  */
 static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
 					      struct batadv_nc_path *nc_path)
@@ -290,7 +290,7 @@ static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path to check
  *
- * Returns true if the entry has to be purged now, false otherwise
+ * Return: true if the entry has to be purged now, false otherwise
  */
 static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_priv,
 						struct batadv_nc_path *nc_path)
@@ -473,7 +473,7 @@ static void batadv_nc_hash_key_gen(struct batadv_nc_path *key, const char *src,
  * @data: data to hash
  * @size: size of the hash table
  *
- * Returns the selected index in the hash table for the given data.
+ * Return: the selected index in the hash table for the given data.
  */
 static u32 batadv_nc_hash_choose(const void *data, u32 size)
 {
@@ -492,7 +492,7 @@ static u32 batadv_nc_hash_choose(const void *data, u32 size)
  * @node: node in the local table
  * @data2: second object to compare the node to
  *
- * Returns 1 if the two entry are the same, 0 otherwise
+ * Return: 1 if the two entry are the same, 0 otherwise
  */
 static int batadv_nc_hash_compare(const struct hlist_node *node,
 				  const void *data2)
@@ -519,7 +519,7 @@ static int batadv_nc_hash_compare(const struct hlist_node *node,
  * @hash: hash table containing the nc path
  * @data: search key
  *
- * Returns the nc_path if found, NULL otherwise.
+ * Return: the nc_path if found, NULL otherwise.
  */
 static struct batadv_nc_path *
 batadv_nc_hash_find(struct batadv_hashtable *hash,
@@ -574,7 +574,7 @@ static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
  * timeout. If so, the packet is no longer kept and the entry deleted from the
  * queue. Has to be called with the appropriate locks.
  *
- * Returns false as soon as the entry in the fifo queue has not been timed out
+ * Return: false as soon as the entry in the fifo queue has not been timed out
  * yet and true otherwise.
  */
 static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
@@ -613,7 +613,7 @@ out:
  * packet is no longer delayed, immediately sent and the entry deleted from the
  * queue. Has to be called with the appropriate locks.
  *
- * Returns false as soon as the entry in the fifo queue has not been timed out
+ * Return: false as soon as the entry in the fifo queue has not been timed out
  * yet and true otherwise.
  */
 static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
@@ -734,7 +734,7 @@ static void batadv_nc_worker(struct work_struct *work)
  * @orig_node: neighboring orig node which may be used as nc candidate
  * @ogm_packet: incoming ogm packet also used for the checks
  *
- * Returns true if:
+ * Return: true if:
  *  1) The OGM must have the most recent sequence number.
  *  2) The TTL must be decremented by one and only one.
  *  3) The OGM must be received from the first hop from orig_node.
@@ -775,7 +775,7 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
  *  (can be equal to orig_node)
  * @in_coding: traverse incoming or outgoing network coding list
  *
- * Returns the nc_node if found, NULL otherwise.
+ * Return: the nc_node if found, NULL otherwise.
  */
 static struct batadv_nc_node
 *batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
@@ -817,7 +817,7 @@ static struct batadv_nc_node
  *  (can be equal to orig_node)
  * @in_coding: traverse incoming or outgoing network coding list
  *
- * Returns the nc_node if found or created, NULL in case of an error.
+ * Return: the nc_node if found or created, NULL in case of an error.
  */
 static struct batadv_nc_node
 *batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
@@ -935,7 +935,7 @@ out:
  * @src: ethernet source address - first half of the nc path search key
  * @dst: ethernet destination address - second half of the nc path search key
  *
- * Returns pointer to nc_path if the path was found or created, returns NULL
+ * Return: pointer to nc_path if the path was found or created, returns NULL
  * on error.
  */
 static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
@@ -1032,7 +1032,7 @@ static void batadv_nc_memxor(char *dst, const char *src, unsigned int len)
  * @nc_packet: structure containing the packet to the skb can be coded with
  * @neigh_node: next hop to forward packet to
  *
- * Returns true if both packets are consumed, false otherwise.
+ * Return: true if both packets are consumed, false otherwise.
  */
 static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb,
@@ -1231,7 +1231,7 @@ out:
  * Since the source encoded the packet we can be certain it has all necessary
  * decode information.
  *
- * Returns true if coding of a decoded packet is allowed.
+ * Return: true if coding of a decoded packet is allowed.
  */
 static bool batadv_nc_skb_coding_possible(struct sk_buff *skb, u8 *dst, u8 *src)
 {
@@ -1249,7 +1249,7 @@ static bool batadv_nc_skb_coding_possible(struct sk_buff *skb, u8 *dst, u8 *src)
  * @skb: data skb to forward
  * @eth_dst: next hop mac address of skb
  *
- * Returns true if coding of a decoded skb is allowed.
+ * Return: true if coding of a decoded skb is allowed.
  */
 static struct batadv_nc_packet *
 batadv_nc_path_search(struct batadv_priv *bat_priv,
@@ -1317,7 +1317,7 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
  * @eth_src: source mac address of skb
  * @in_nc_node: pointer to skb next hop's neighbor nc node
  *
- * Returns an nc packet if a suitable coding packet was found, NULL otherwise.
+ * Return: an nc packet if a suitable coding packet was found, NULL otherwise.
  */
 static struct batadv_nc_packet *
 batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
@@ -1400,7 +1400,7 @@ static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
  * next hop that potentially sent a packet which our next hop also received
  * (overheard) and has stored for later decoding.
  *
- * Returns true if the skb was consumed (encoded packet sent) or false otherwise
+ * Return: true if the skb was consumed (encoded packet sent) or false otherwise
  */
 static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
 				     struct batadv_neigh_node *neigh_node,
@@ -1454,7 +1454,7 @@ static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
  * @neigh_node: next hop to forward packet to
  * @packet_id: checksum to identify packet
  *
- * Returns true if the packet was buffered or false in case of an error.
+ * Return: true if the packet was buffered or false in case of an error.
  */
 static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
 				      struct batadv_nc_path *nc_path,
@@ -1488,7 +1488,7 @@ static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
  * @skb: data skb to forward
  * @neigh_node: next hop to forward packet to
  *
- * Returns true if the skb was consumed (encoded packet sent) or false otherwise
+ * Return: true if the skb was consumed (encoded packet sent) or false otherwise
  */
 bool batadv_nc_skb_forward(struct sk_buff *skb,
 			   struct batadv_neigh_node *neigh_node)
@@ -1627,7 +1627,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
  * @skb: unicast skb to decode
  * @nc_packet: decode data needed to decode the skb
  *
- * Returns pointer to decoded unicast packet if the packet was decoded or NULL
+ * Return: pointer to decoded unicast packet if the packet was decoded or NULL
  * in case of an error.
  */
 static struct batadv_unicast_packet *
@@ -1721,7 +1721,7 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * @ethhdr: pointer to the ethernet header inside the coded packet
  * @coded: coded packet we try to find decode data for
  *
- * Returns pointer to nc packet if the needed data was found or NULL otherwise.
+ * Return: pointer to nc packet if the needed data was found or NULL otherwise.
  */
 static struct batadv_nc_packet *
 batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b27cc5b..ddf22f5 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -47,7 +47,11 @@ static struct lock_class_key batadv_orig_hash_lock_class_key;
 
 static void batadv_purge_orig(struct work_struct *work);
 
-/* returns 1 if they are the same originator */
+/**
+ * batadv_compare_orig
+ *
+ * Return: 1 if they are the same originator
+ */
 int batadv_compare_orig(const struct hlist_node *node, const void *data2)
 {
 	const void *data1 = container_of(node, struct batadv_orig_node,
@@ -61,7 +65,7 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2)
  * @orig_node: the originator serving the VLAN
  * @vid: the VLAN identifier
  *
- * Returns the vlan object identified by vid and belonging to orig_node or NULL
+ * Return: the vlan object identified by vid and belonging to orig_node or NULL
  * if it does not exist.
  */
 struct batadv_orig_node_vlan *
@@ -93,7 +97,7 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
  * @orig_node: the originator serving the VLAN
  * @vid: the VLAN identifier
  *
- * Returns NULL in case of failure or the vlan object identified by vid and
+ * Return: NULL in case of failure or the vlan object identified by vid and
  * belonging to orig_node otherwise. The object is created and added to the list
  * if it does not exist.
  *
@@ -307,7 +311,7 @@ void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
  * @if_outgoing: the interface where the payload packet has been received or
  *  the OGM should be sent to
  *
- * Returns the neighbor which should be router for this orig_node/iface.
+ * Return: the neighbor which should be router for this orig_node/iface.
  *
  * The object is returned with refcounter increased by 1.
  */
@@ -339,7 +343,7 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
  * @orig_node: the orig node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
- * Returns the requested orig_ifinfo or NULL if not found.
+ * Return: the requested orig_ifinfo or NULL if not found.
  *
  * The object is returned with refcounter increased by 1.
  */
@@ -371,7 +375,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
  * @orig_node: the orig node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
- * Returns NULL in case of failure or the orig_ifinfo object for the if_outgoing
+ * Return: NULL in case of failure or the orig_ifinfo object for the if_outgoing
  * interface otherwise. The object is created and added to the list
  * if it does not exist.
  *
@@ -421,7 +425,7 @@ out:
  *
  * The object is returned with refcounter increased by 1.
  *
- * Returns the requested neigh_ifinfo or NULL if not found
+ * Return: the requested neigh_ifinfo or NULL if not found
  */
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
@@ -452,7 +456,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
- * Returns NULL in case of failure or the neigh_ifinfo object for the
+ * Return: NULL in case of failure or the neigh_ifinfo object for the
  * if_outgoing interface otherwise. The object is created and added to the list
  * if it does not exist.
  *
@@ -500,7 +504,8 @@ out:
  *
  * Looks for and possibly returns a neighbour belonging to this originator list
  * which is connected through the provided hard interface.
- * Returns NULL if the neighbour is not found.
+ *
+ * Return: neighbor when found. Othwerwise NULL
  */
 static struct batadv_neigh_node *
 batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
@@ -533,7 +538,7 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
  *
- * Returns the hardif neighbour node if found or created or NULL otherwise.
+ * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
 static struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
@@ -581,7 +586,7 @@ out:
  * @hard_iface: the interface this neighbour is connected to
  * @neigh_addr: the interface address of the neighbour to retrieve
  *
- * Returns the hardif neighbour node if found or created or NULL otherwise.
+ * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
 static struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
@@ -603,7 +608,8 @@ batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
  * @neigh_addr: the address of the neighbour
  *
  * Looks for and possibly returns a neighbour belonging to this hard interface.
- * Returns NULL if the neighbour is not found.
+ *
+ * Return: neighbor when found. Othwerwise NULL
  */
 struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
@@ -635,7 +641,8 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
  * @neigh_addr: the mac address of the neighbour interface
  *
  * Allocates a new neigh_node object and initialises all the generic fields.
- * Returns the new object or NULL on failure.
+ *
+ * Return: neighbor when found. Othwerwise NULL
  */
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_orig_node *orig_node,
@@ -697,7 +704,7 @@ out:
  * @seq: neighbour table seq_file struct
  * @offset: not used
  *
- * Always returns 0.
+ * Return: always 0
  */
 int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 {
@@ -870,7 +877,8 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
  *
  * Creates a new originator object and initialise all the generic fields.
  * The new object is not added to the originator list.
- * Returns the newly created object or NULL on failure.
+ *
+ * Return: the newly created object or NULL on failure.
  */
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr)
@@ -987,7 +995,7 @@ batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
  *
- * Returns true if any ifinfo entry was purged, false otherwise.
+ * Return: true if any ifinfo entry was purged, false otherwise.
  */
 static bool
 batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
@@ -1039,7 +1047,7 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
  *
- * Returns true if any neighbor was purged, false otherwise
+ * Return: true if any neighbor was purged, false otherwise
  */
 static bool
 batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
@@ -1098,7 +1106,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
  * @orig_node: orig node which is to be checked
  * @if_outgoing: the interface for which the metric should be compared
  *
- * Returns the current best neighbor, with refcount increased.
+ * Return: the current best neighbor, with refcount increased.
  */
 static struct batadv_neigh_node *
 batadv_find_best_neighbor(struct batadv_priv *bat_priv,
@@ -1135,7 +1143,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
  * This function checks if the orig_node or substructures of it have become
  * obsolete, and purges this information if that's the case.
  *
- * Returns true if the orig_node is to be removed, false otherwise.
+ * Return: true if the orig_node is to be removed, false otherwise.
  */
 static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
@@ -1280,7 +1288,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
  * @seq: debugfs table seq_file struct
  * @offset: not used
  *
- * Returns 0
+ * Return: 0
  */
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 {
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 54d6608..bcaa787 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -140,9 +140,12 @@ out:
 		batadv_neigh_node_free_ref(router);
 }
 
-/* checks whether the host restarted and is in the protection time.
- * returns:
- *  0 if the packet is to be accepted
+/**
+ * batadv_window_protected checks whether the host restarted and is in the
+ *  protection time.
+ *
+ * Return:
+ *  0 if the packet is to be accepted.
  *  1 if the packet is to be ignored.
  */
 int batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
@@ -198,7 +201,7 @@ bool batadv_check_management_packet(struct sk_buff *skb,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: icmp packet to process
  *
- * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
+ * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
  * otherwise.
  */
 static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
@@ -398,10 +401,11 @@ out:
  * @skb: packet to check
  * @hdr_size: size of header to pull
  *
- * Check for short header and bad addresses in given packet. Returns negative
- * value when check fails and 0 otherwise. The negative value depends on the
- * reason: -ENODATA for bad header, -EBADR for broadcast destination or source,
- * and -EREMOTE for non-local (other host) destination.
+ * Check for short header and bad addresses in given packet.
+ *
+ * Return: negative value when check fails and 0 otherwise. The negative value
+ * depends on the reason: -ENODATA for bad header, -EBADR for broadcast
+ * destination or source, and -EREMOTE for non-local (other host) destination.
  */
 static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 				       struct sk_buff *skb, int hdr_size)
@@ -435,7 +439,7 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
  * @orig_node: the destination node
  * @recv_if: pointer to interface this packet was received on
  *
- * Returns the router which should be used for this orig_node on
+ * Return: the router which should be used for this orig_node on
  * this interface, or NULL if not available.
  */
 struct batadv_neigh_node *
@@ -648,7 +652,7 @@ out:
  * the new corresponding information (originator address where the destination
  * client currently is and its known TTVN)
  *
- * Returns true if the packet header has been updated, false otherwise
+ * Return: true if the packet header has been updated, false otherwise
  */
 static bool
 batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
@@ -805,7 +809,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
+ * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
  * otherwise.
  */
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
@@ -905,7 +909,7 @@ rx_success:
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
+ * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
  * otherwise.
  */
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
@@ -959,7 +963,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
  * the assembled packet will exceed our MTU; 2) Buffer fragment, if we till
  * lack further fragments; 3) Merge fragments, if we have all needed parts.
  *
- * Return NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
  */
 int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 3fbf791..d9b93c5 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -111,7 +111,7 @@ send_skb_err:
  * host, NULL can be passed as recv_if and no interface alternating is
  * attempted.
  *
- * Returns NET_XMIT_SUCCESS on success, NET_XMIT_DROP on failure, or
+ * Return: NET_XMIT_SUCCESS on success, NET_XMIT_DROP on failure, or
  * NET_XMIT_POLICED if the skb is buffered for later transmit.
  */
 int batadv_send_skb_to_orig(struct sk_buff *skb,
@@ -165,7 +165,7 @@ out:
  * @hdr_size: amount of bytes to push at the beginning of the skb
  * @orig_node: the destination node
  *
- * Returns false if the buffer extension was not possible or true otherwise.
+ * Return: false if the buffer extension was not possible or true otherwise.
  */
 static bool
 batadv_send_skb_push_fill_unicast(struct sk_buff *skb, int hdr_size,
@@ -196,7 +196,7 @@ batadv_send_skb_push_fill_unicast(struct sk_buff *skb, int hdr_size,
  * @skb: the skb containing the payload to encapsulate
  * @orig_node: the destination node
  *
- * Returns false if the payload could not be encapsulated or true otherwise.
+ * Return: false if the payload could not be encapsulated or true otherwise.
  */
 static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
 					    struct batadv_orig_node *orig_node)
@@ -214,7 +214,7 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
  * @orig: the destination node
  * @packet_subtype: the unicast 4addr packet subtype to use
  *
- * Returns false if the payload could not be encapsulated or true otherwise.
+ * Return: false if the payload could not be encapsulated or true otherwise.
  */
 bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb,
@@ -265,7 +265,7 @@ out:
  * as packet_type. Then send this frame to the given orig_node and release a
  * reference to this orig_node.
  *
- * Returns NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
+ * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, int packet_type,
@@ -339,7 +339,7 @@ out:
  * BATADV_UNICAST_4ADDR was supplied as packet_type. Then send this frame
  * to the according destination node.
  *
- * Returns NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
+ * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb, int packet_type,
@@ -373,7 +373,7 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
  * Look up the currently selected gateway. Wrap the given skb into a batman-adv
  * unicast header and send this frame to this gateway node.
  *
- * Returns NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
+ * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			   unsigned short vid)
@@ -430,14 +430,16 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 			   send_time);
 }
 
-/* add a broadcast packet to the queue and setup timers. broadcast packets
- * are sent multiple times to increase probability for being received.
+/**
+ * batadv_add_bcast_packet_to_list
  *
- * This function returns NETDEV_TX_OK on success and NETDEV_TX_BUSY on
- * errors.
+ * add a broadcast packet to the queue and setup timers. broadcast packets
+ * are sent multiple times to increase probability for being received.
  *
  * The skb is not consumed, so the caller should make sure that the
  * skb is freed.
+ *
+ * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
  */
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 82059f2..3adc11f 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -69,7 +69,7 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * header via the translation table. Wrap the given skb into a batman-adv
  * unicast header. Then send this frame to the according destination node.
  *
- * Returns NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
+ * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, u8 *dst_hint,
@@ -92,7 +92,7 @@ static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
  * unicast-4addr header. Then send this frame to the according destination
  * node.
  *
- * Returns NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
+ * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 static inline int batadv_send_skb_via_tt_4addr(struct batadv_priv *bat_priv,
 					       struct sk_buff *skb,
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c923e3c..5ee794b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -501,7 +501,7 @@ void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the identifier of the vlan object to retrieve
  *
- * Returns the private data of the vlan matching the vid passed as argument or
+ * Return: the private data of the vlan matching the vid passed as argument or
  * NULL otherwise. The refcounter of the returned object is incremented by 1.
  */
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
@@ -530,7 +530,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  *
- * Returns 0 on success, a negative error otherwise.
+ * Return: 0 on success, a negative error otherwise.
  */
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
@@ -599,7 +599,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
  * Set up all the internal structures for handling the new vlan on top of the
  * mesh interface
  *
- * Returns 0 on success or a negative error code in case of failure.
+ * Return: 0 on success or a negative error code in case of failure.
  */
 static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
@@ -656,7 +656,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
  * Destroy all the internal structures used to handle the vlan identified by vid
  * on top of the mesh interface
  *
- * Returns 0 on success, -EINVAL if the specified prototype is not ETH_P_8021Q
+ * Return: 0 on success, -EINVAL if the specified prototype is not ETH_P_8021Q
  * or -ENOENT if the specified vlan id wasn't registered.
  */
 static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
@@ -745,7 +745,7 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
  * batadv_softif_init_late - late stage initialization of soft interface
  * @dev: registered network device to modify
  *
- * Returns error code on failures
+ * Return: error code on failures
  */
 static int batadv_softif_init_late(struct net_device *dev)
 {
@@ -847,7 +847,7 @@ free_bat_counters:
  * @dev: batadv_soft_interface used as master interface
  * @slave_dev: net_device which should become the slave interface
  *
- * Return 0 if successful or error otherwise.
+ * Return: 0 if successful or error otherwise.
  */
 static int batadv_softif_slave_add(struct net_device *dev,
 				   struct net_device *slave_dev)
@@ -872,7 +872,7 @@ out:
  * @dev: batadv_soft_interface used as master interface
  * @slave_dev: net_device which should be removed from the master interface
  *
- * Return 0 if successful or error otherwise.
+ * Return: 0 if successful or error otherwise.
  */
 static int batadv_softif_slave_del(struct net_device *dev,
 				   struct net_device *slave_dev)
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 33772d9..7658e6e 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -64,7 +64,7 @@ static struct batadv_priv *batadv_kobj_to_batpriv(struct kobject *obj)
  * batadv_vlan_kobj_to_batpriv - convert a vlan kobj in the associated batpriv
  * @obj: kobject to covert
  *
- * Returns the associated batadv_priv struct.
+ * Return: the associated batadv_priv struct.
  */
 static struct batadv_priv *batadv_vlan_kobj_to_batpriv(struct kobject *obj)
 {
@@ -84,7 +84,7 @@ static struct batadv_priv *batadv_vlan_kobj_to_batpriv(struct kobject *obj)
  * batadv_kobj_to_vlan - convert a kobj in the associated softif_vlan struct
  * @obj: kobject to covert
  *
- * Returns the associated softif_vlan struct if found, NULL otherwise.
+ * Return: the associated softif_vlan struct if found, NULL otherwise.
  */
 static struct batadv_softif_vlan *
 batadv_kobj_to_vlan(struct batadv_priv *bat_priv, struct kobject *obj)
@@ -491,7 +491,7 @@ static ssize_t batadv_store_gw_bwidth(struct kobject *kobj,
  * @attr: the batman-adv attribute the user is interacting with
  * @buff: the buffer that will contain the data to send back to the user
  *
- * Returns the number of bytes written into 'buff' on success or a negative
+ * Return: the number of bytes written into 'buff' on success or a negative
  * error code in case of failure
  */
 static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
@@ -511,7 +511,7 @@ static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
  * @buff: the buffer containing the user data
  * @count: number of bytes in the buffer
  *
- * Returns 'count' on success or a negative error code in case of failure
+ * Return: 'count' on success or a negative error code in case of failure
  */
 static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 					   struct attribute *attr, char *buff,
@@ -681,7 +681,7 @@ void batadv_sysfs_del_meshif(struct net_device *dev)
  * @dev: netdev of the mesh interface
  * @vlan: private data of the newly added VLAN interface
  *
- * Returns 0 on success and -ENOMEM if any of the structure allocations fails.
+ * Return: 0 on success and -ENOMEM if any of the structure allocations fails.
  */
 int batadv_sysfs_add_vlan(struct net_device *dev,
 			  struct batadv_softif_vlan *vlan)
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2e57d10..0d00fef 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -68,7 +68,11 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 unsigned short vid, const char *message,
 				 bool roaming);
 
-/* returns 1 if they are the same mac addr and vid */
+/**
+ * batadv_compare_tt
+ *
+ * Return: 1 if they are the same mac addr and vid
+ */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
 	const void *data1 = container_of(node, struct batadv_tt_common_entry,
@@ -84,7 +88,7 @@ static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
  * @data: pointer to the tt_common_entry object to map
  * @size: the size of the hash table
  *
- * Returns the hash index where the object represented by 'data' should be
+ * Return: the hash index where the object represented by 'data' should be
  * stored at.
  */
 static inline u32 batadv_choose_tt(const void *data, u32 size)
@@ -105,7 +109,7 @@ static inline u32 batadv_choose_tt(const void *data, u32 size)
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
  *
- * Returns a pointer to the tt_common struct belonging to the searched client if
+ * Return: a pointer to the tt_common struct belonging to the searched client if
  * found, NULL otherwise.
  */
 static struct batadv_tt_common_entry *
@@ -150,7 +154,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
  *
- * Returns a pointer to the corresponding tt_local_entry struct if the client is
+ * Return: a pointer to the corresponding tt_local_entry struct if the client is
  * found, NULL otherwise.
  */
 static struct batadv_tt_local_entry *
@@ -175,7 +179,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
  *
- * Returns a pointer to the corresponding tt_global_entry struct if the client
+ * Return: a pointer to the corresponding tt_global_entry struct if the client
  * is found, NULL otherwise.
  */
 static struct batadv_tt_global_entry *
@@ -220,7 +224,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
- * Return the number of originators advertising the given address/data
+ * Return: the number of originators advertising the given address/data
  * (excluding ourself).
  */
 int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
@@ -435,7 +439,7 @@ unlock:
  * batadv_tt_len - compute length in bytes of given number of tt changes
  * @changes_num: number of tt changes
  *
- * Returns computed length in bytes.
+ * Return: computed length in bytes.
  */
 static int batadv_tt_len(int changes_num)
 {
@@ -446,7 +450,7 @@ static int batadv_tt_len(int changes_num)
  * batadv_tt_entries - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
  *
- * Returns the number of entries.
+ * Return: the number of entries.
  */
 static u16 batadv_tt_entries(u16 tt_len)
 {
@@ -458,7 +462,7 @@ static u16 batadv_tt_entries(u16 tt_len)
  *  size when transmitted over the air
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Returns local translation table size in bytes.
+ * Return: local translation table size in bytes.
  */
 static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 {
@@ -524,7 +528,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
  * @mark: the value contained in the skb->mark field of the received packet (if
  *  any)
  *
- * Returns true if the client was successfully added, false otherwise.
+ * Return: true if the client was successfully added, false otherwise.
  */
 bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark)
@@ -724,7 +728,7 @@ out:
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN served by the originator node.
  *
- * Return the size of the allocated buffer or 0 in case of failure.
+ * Return: the size of the allocated buffer or 0 in case of failure.
  */
 static u16
 batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
@@ -798,7 +802,7 @@ out:
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN.
  *
- * Return the size of the allocated buffer or 0 in case of failure.
+ * Return: the size of the allocated buffer or 0 in case of failure.
  */
 static u16
 batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
@@ -1040,7 +1044,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
  *
- * Returns the flags assigned to the local entry before being deleted
+ * Return: the flags assigned to the local entry before being deleted
  */
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid, const char *message,
@@ -1240,10 +1244,13 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
-/* retrieves the orig_tt_list_entry belonging to orig_node from the
+/**
+ * batadv_tt_global_orig_entry_find
+ *
+ * retrieves the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
  *
- * returns it with an increased refcounter, NULL if not found
+ * Return: it with an increased refcounter, NULL if not found
  */
 static struct batadv_tt_orig_list_entry *
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
@@ -1268,8 +1275,12 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 	return orig_entry;
 }
 
-/* find out if an orig_node is already in the list of a tt_global_entry.
- * returns true if found, false otherwise
+/**
+ * batadv_tt_global_entry_has_orig
+ *
+ * find out if an orig_node is already in the list of a tt_global_entry.
+ *
+ * Return: true if found, false otherwise
  */
 static bool
 batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
@@ -1341,7 +1352,7 @@ out:
  *
  * The caller must hold orig_node refcount.
  *
- * Return true if the new entry has been added, false otherwise
+ * Return: true if the new entry has been added, false otherwise
  */
 static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
@@ -1499,7 +1510,7 @@ out:
  * @tt_global_entry: global translation table entry to be analyzed
  *
  * This functon assumes the caller holds rcu_read_lock().
- * Returns best originator list entry or NULL on errors.
+ * Return: best originator list entry or NULL on errors.
  */
 static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
@@ -2029,7 +2040,7 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
  * @addr: mac address of the destination client
  * @vid: VLAN identifier
  *
- * Returns a pointer to the originator that was selected as destination in the
+ * Return: a pointer to the originator that was selected as destination in the
  * mesh for contacting the client 'addr', NULL otherwise.
  * In case of multiple originators serving the same client, the function returns
  * the best one (best in terms of metric towards the destination node).
@@ -2104,7 +2115,7 @@ out:
  * because the XOR operation can combine them all while trying to reduce the
  * noise as much as possible.
  *
- * Returns the checksum of the global table of a given originator.
+ * Return: the checksum of the global table of a given originator.
  */
 static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 				struct batadv_orig_node *orig_node,
@@ -2181,7 +2192,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
  * For details about the computation, please refer to the documentation for
  * batadv_tt_global_crc().
  *
- * Returns the checksum of the local table
+ * Return: the checksum of the local table
  */
 static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 			       unsigned short vid)
@@ -2287,7 +2298,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node this request is being issued for
  *
- * Returns the pointer to the new tt_req_node struct if no request
+ * Return: the pointer to the new tt_req_node struct if no request
  * has already been issued for this orig_node, NULL otherwise.
  */
 static struct batadv_tt_req_node *
@@ -2322,7 +2333,7 @@ unlock:
  * @entry_ptr: to be checked local tt entry
  * @data_ptr: not used but definition required to satisfy the callback prototype
  *
- * Returns 1 if the entry is a valid, 0 otherwise.
+ * Return: 1 if the entry is a valid, 0 otherwise.
  */
 static int batadv_tt_local_valid(const void *entry_ptr, const void *data_ptr)
 {
@@ -2407,7 +2418,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
  * @tt_vlan: pointer to the first tvlv VLAN entry
  * @num_vlan: number of tvlv VLAN entries
  *
- * Return true if all the received CRCs match the locally stored ones, false
+ * Return: true if all the received CRCs match the locally stored ones, false
  * otherwise
  */
 static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
@@ -2590,7 +2601,7 @@ out:
  * @req_src: mac address of tt request sender
  * @req_dst: mac address of tt request recipient
  *
- * Returns true if tt request reply was sent, false otherwise.
+ * Return: true if tt request reply was sent, false otherwise.
  */
 static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 					  struct batadv_tvlv_tt_data *tt_data,
@@ -2722,7 +2733,7 @@ out:
  * @tt_data: tt data containing the tt request information
  * @req_src: mac address of tt request sender
  *
- * Returns true if tt request reply was sent, false otherwise.
+ * Return: true if tt request reply was sent, false otherwise.
  */
 static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 				       struct batadv_tvlv_tt_data *tt_data,
@@ -2840,7 +2851,7 @@ out:
  * @req_src: mac address of tt request sender
  * @req_dst: mac address of tt request recipient
  *
- * Returns true if tt request reply was sent, false otherwise.
+ * Return: true if tt request reply was sent, false otherwise.
  */
 static bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_tt_data *tt_data,
@@ -2935,7 +2946,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
  * @addr: the mac address of the client to check
  * @vid: VLAN identifier
  *
- * Returns true if the client is served by this node, false otherwise.
+ * Return: true if the client is served by this node, false otherwise.
  */
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid)
@@ -3052,11 +3063,14 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.roam_list_lock);
 }
 
-/* This function checks whether the client already reached the
+/**
+ * batadv_tt_check_roam_count
+ *
+ * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
  * will not be sent.
  *
- * returns true if the ROAMING_ADV can be sent, false otherwise
+ * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
 static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 {
@@ -3455,7 +3469,7 @@ request_table:
  * @addr: the mac address of the client to check
  * @vid: VLAN identifier
  *
- * Returns true if we know that the client has moved from its old originator
+ * Return: true if we know that the client has moved from its old originator
  * to another one. This entry is still kept for consistency purposes and will be
  * deleted later by a DEL or because of timeout
  */
@@ -3481,7 +3495,7 @@ out:
  * @addr: the mac address of the local client to query
  * @vid: VLAN identifier
  *
- * Returns true if the local client is known to be roaming (it is not served by
+ * Return: true if the local client is known to be roaming (it is not served by
  * this node anymore) or not. If yes, the client is still present in the table
  * to keep the latter consistent with the node TTVN
  */
@@ -3610,7 +3624,7 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv buffer containing the tt data
  * @tvlv_value_len: tvlv buffer length
  *
- * Returns NET_RX_DROP if the tt tvlv is to be re-routed, NET_RX_SUCCESS
+ * Return: NET_RX_DROP if the tt tvlv is to be re-routed, NET_RX_SUCCESS
  * otherwise.
  */
 static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
@@ -3691,7 +3705,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv buffer containing the tt data
  * @tvlv_value_len: tvlv buffer length
  *
- * Returns NET_RX_DROP if the tt roam tvlv is to be re-routed, NET_RX_SUCCESS
+ * Return: NET_RX_DROP if the tt roam tvlv is to be re-routed, NET_RX_SUCCESS
  * otherwise.
  */
 static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
@@ -3737,7 +3751,7 @@ out:
  * batadv_tt_init - initialise the translation table internals
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return 0 on success or negative error number in case of failure.
+ * Return: 0 on success or negative error number in case of failure.
  */
 int batadv_tt_init(struct batadv_priv *bat_priv)
 {
@@ -3775,7 +3789,7 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
  * @addr: the mac address of the client
  * @vid: the identifier of the VLAN where this client is connected
  *
- * Returns true if the client is marked with the TT_CLIENT_ISOLA flag, false
+ * Return: true if the client is marked with the TT_CLIENT_ISOLA flag, false
  * otherwise
  */
 bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0024-batman-adv-Fix-kerneldoc-of-network-coding-functions.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0024-batman-adv-Fix-kerneldoc-of-network-coding-functions.patch"

From 005d49eaf54921c83e9ae2f91ad07fc991ccf357 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2015 12:29:30 +0100
Subject: [PATCH 24/28] batman-adv: Fix kerneldoc of network-coding functions

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/network-coding.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 25d35da..56100c5 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -64,6 +64,8 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 
 /**
  * batadv_nc_init - one-time initialization for network coding
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int __init batadv_nc_init(void)
 {
@@ -142,6 +144,8 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_mesh_init - initialise coding hash table and start house keeping
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 {
@@ -992,6 +996,8 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
  * batadv_nc_random_weight_tq - scale the receivers TQ-value to avoid unfair
  *  selection of a receiver with slightly lower TQ than the other
  * @tq: to be weighted tq value
+ *
+ * Return: scaled tq value
  */
 static u8 batadv_nc_random_weight_tq(u8 tq)
 {
@@ -1784,6 +1790,9 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
  *  resulting unicast packet
  * @skb: incoming coded packet
  * @recv_if: pointer to interface this packet was received on
+ *
+ * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
+ * otherwise.
  */
 static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
@@ -1868,6 +1877,8 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
  * batadv_nc_nodes_seq_print_text - print the nc node information
  * @seq: seq file to print on
  * @offset: not used
+ *
+ * Return: always 0
  */
 int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 {
@@ -1930,6 +1941,8 @@ out:
 /**
  * batadv_nc_init_debugfs - create nc folder and related files in debugfs
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
  */
 int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 {
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0025-batman-adv-Update-repair-bridge-loop-avoidance-kerne.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0025-batman-adv-Update-repair-bridge-loop-avoidance-kerne.patch"

From deafbb0a83f20025e6fd461ce457395b59ba0043 Mon Sep 17 00:00:00 2001
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 6 Nov 2015 10:45:19 +0100
Subject: [PATCH 25/28] batman-adv: Update/repair bridge loop avoidance
 kerneldoc

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bridge_loop_avoidance.c | 177 ++++++++++++++++++++++++---------
 1 file changed, 129 insertions(+), 48 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 7aeffd4..d9b034a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -59,9 +59,11 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
 			 struct batadv_bla_backbone_gw *backbone_gw);
 
 /**
- * batadv_choose_claim
+ * batadv_choose_claim - choose the right bucket for a claim.
+ * @data: data to hash
+ * @size: size of the hash table
  *
- * Return: the index of the claim
+ * Return: the hash index of the claim
  */
 static inline u32 batadv_choose_claim(const void *data, u32 size)
 {
@@ -75,9 +77,11 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
 }
 
 /**
- * batadv_choose_backbone_gw
+ * batadv_choose_backbone_gw - choose the right bucket for a backbone gateway.
+ * @data: data to hash
+ * @size: size of the hash table
  *
- * Return: the index of the backbone gateway
+ * Return: the hash index of the backbone gateway
  */
 static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 {
@@ -90,7 +94,13 @@ static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 	return hash % size;
 }
 
-/* compares address and vid of two backbone gws */
+/**
+ * batadv_compare_backbone_gw - compare address and vid of two backbone gws
+ * @node: list node of the first entry to compare
+ * @data2: pointer to the second backbone gateway
+ *
+ * Return: 1 if the backbones have the same data, 0 otherwise
+ */
 static int batadv_compare_backbone_gw(const struct hlist_node *node,
 				      const void *data2)
 {
@@ -108,7 +118,13 @@ static int batadv_compare_backbone_gw(const struct hlist_node *node,
 	return 1;
 }
 
-/* compares address and vid of two claims */
+/**
+ * batadv_compare_backbone_gw - compare address and vid of two claims
+ * @node: list node of the first entry to compare
+ * @data2: pointer to the second claims
+ *
+ * Return: 1 if the claim have the same data, 0 otherwise
+ */
 static int batadv_compare_claim(const struct hlist_node *node,
 				const void *data2)
 {
@@ -126,7 +142,10 @@ static int batadv_compare_claim(const struct hlist_node *node,
 	return 1;
 }
 
-/* free a backbone gw */
+/**
+ * batadv_compare_backbone_gw - free backbone gw
+ * @backbone_gw: backbone gateway to be free'd
+ */
 static void
 batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 {
@@ -134,7 +153,10 @@ batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 		kfree_rcu(backbone_gw, rcu);
 }
 
-/* finally deinitialize the claim */
+/**
+ * batadv_claim_free_rcu - finally deinitialize the claim
+ * @rcu: rcu pointer within the claim structure
+ */
 static void batadv_claim_free_rcu(struct rcu_head *rcu)
 {
 	struct batadv_bla_claim *claim;
@@ -145,7 +167,10 @@ static void batadv_claim_free_rcu(struct rcu_head *rcu)
 	kfree(claim);
 }
 
-/* free a claim, call claim_free_rcu if its the last reference */
+/**
+ * batadv_claim_free_rcu - free a claim
+ * @claim: claim to be free'd
+ */
 static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 {
 	if (atomic_dec_and_test(&claim->refcount))
@@ -153,12 +178,10 @@ static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 }
 
 /**
- * batadv_claim_hash_find
+ * batadv_claim_hash_find - looks for a claim in the claim hash
  * @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
- * looks for a claim in the hash
- *
  * Return: claim if found or NULL otherwise.
  */
 static struct batadv_bla_claim
@@ -194,12 +217,12 @@ static struct batadv_bla_claim
 }
 
 /**
- * batadv_backbone_hash_find - looks for a claim in the hash
+ * batadv_backbone_hash_find - looks for a backbone gateway in the hash
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
- * Return: claim if found or NULL otherwise.
+ * Return: backbone gateway if found or NULL otherwise
  */
 static struct batadv_bla_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
@@ -237,7 +260,10 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv, u8 *addr,
 	return backbone_gw_tmp;
 }
 
-/* delete all claims for a backbone */
+/**
+ * batadv_bla_del_backbone_claims - delete all claims for a backbone
+ * @backbone_gw: backbone gateway where the claims should be removed
+ */
 static void
 batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 {
@@ -385,14 +411,13 @@ out:
 }
 
 /**
- * batadv_bla_get_backbone_gw
+ * batadv_bla_get_backbone_gw - finds or creates a backbone gateway
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
  * @own_backbone: set if the requested backbone is local
  *
- * searches for the backbone gw or creates a new one if it could not
- * be found.
+ * Return: the (possibly created) backbone gateway or NULL on error
  */
 static struct batadv_bla_backbone_gw *
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
@@ -458,7 +483,13 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
 	return entry;
 }
 
-/* update or add the own backbone gw to make sure we announce
+/**
+ * batadv_bla_update_own_backbone_gw - updates the own backbone gw for a VLAN
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the selected primary interface
+ * @vid: VLAN identifier
+ *
+ * update or add the own backbone gw to make sure we announce
  * where we receive other backbone gws
  */
 static void
@@ -555,12 +586,9 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_bla_send_announce
+ * batadv_bla_send_announce - Send an announcement frame
  * @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: our backbone gateway which should be announced
- *
- * This function sends an announcement. It is called from multiple
- * places.
  */
 static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 				     struct batadv_bla_backbone_gw *backbone_gw)
@@ -650,8 +678,11 @@ claim_free_ref:
 	batadv_claim_free_ref(claim);
 }
 
-/* Delete a claim from the claim hash which has the
- * given mac address and vid.
+/**
+ * batadv_bla_del_claim - delete a claim from the claim hash
+ * @bat_priv: the bat priv with all the soft interface information
+ * @mac: mac address of the claim to be removed
+ * @vid: VLAN id for the claim to be removed
  */
 static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 				 const u8 *mac, const unsigned short vid)
@@ -681,6 +712,10 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_announce - check for ANNOUNCE frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @an_addr: announcement mac address (ARP Sender HW address)
+ * @backbone_addr: originator address of the sender (Ethernet source MAC)
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -735,6 +770,11 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 /**
  * batadv_handle_request - check for REQUEST frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: backbone address to be requested (ARP sender HW MAC)
+ * @ethhdr: ethernet header of a packet
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -763,6 +803,11 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_unclaim - check for UNCLAIM frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: originator address of the backbone (Ethernet source)
+ * @claim_addr: Client to be unclaimed (ARP sender HW MAC)
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -796,6 +841,11 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_claim - check for CLAIM frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: originator address of the backbone (Ethernet Source)
+ * @claim_addr: client mac address to be claimed (ARP sender HW MAC)
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -827,7 +877,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_check_claim_group
+ * batadv_check_claim_group - check for claim group membership
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary interface of this batman interface
  * @hw_src: the Hardware source in the ARP Header
@@ -902,13 +952,11 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_process_claim
+ * batadv_bla_process_claim - Check if this is a claim frame, and process it
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @skb: the frame to be checked
  *
- * Check if this is a claim frame, and process it accordingly.
- *
  * Return: 1 if it was a claim frame, otherwise return 0 to
  * tell the callee that it can use the frame on its own.
  */
@@ -1040,7 +1088,13 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	return 1;
 }
 
-/* Check when we last heard from other nodes, and remove them in case of
+/**
+ * batadv_bla_purge_backbone_gw - Remove backbone gateways after a timeout or
+ *  immediately
+ * @bat_priv: the bat priv with all the soft interface information
+ * @now: whether the whole hash shall be wiped now
+ *
+ * Check when we last heard from other nodes, and remove them in case of
  * a time out, or clean all backbone gws if now is set.
  */
 static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
@@ -1088,7 +1142,7 @@ purge_now:
 }
 
 /**
- * batadv_bla_purge_claims
+ * batadv_bla_purge_claims - Remove claims after a timeout or immediately
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the selected primary interface, may be NULL if now is set
  * @now: whether the whole hash shall be wiped now
@@ -1137,12 +1191,11 @@ purge_now:
 }
 
 /**
- * batadv_bla_update_orig_address
+ * batadv_bla_update_orig_address - Update the backbone gateways when the own
+ *  originator address changes
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the new selected primary_if
  * @oldif: the old primary interface, may be NULL
- *
- * Update the backbone gateways when the own orig address changes.
  */
 void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
@@ -1213,7 +1266,11 @@ void batadv_bla_status_update(struct net_device *net_dev)
 	batadv_hardif_free_ref(primary_if);
 }
 
-/* periodic work to do:
+/**
+ * batadv_bla_periodic_work - performs periodic bla work
+ * @work: kernel work struct
+ *
+ * periodic work to do:
  *  * purge structures when they are too old
  *  * send announcements
  */
@@ -1294,7 +1351,12 @@ out:
 static struct lock_class_key batadv_claim_hash_lock_class_key;
 static struct lock_class_key batadv_backbone_hash_lock_class_key;
 
-/* initialize all bla structures */
+/**
+ * batadv_bla_init - initialize all bla structures
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success, < 0 on error.
+ */
 int batadv_bla_init(struct batadv_priv *bat_priv)
 {
 	int i;
@@ -1349,7 +1411,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_check_bcast_duplist
+ * batadv_bla_check_bcast_duplist - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: contains the bcast_packet to be checked
  *
@@ -1361,6 +1423,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  * with a good chance that it is the same packet. If it is furthermore
  * sent by another host, drop it. We allow equal packets from
  * the same host however as this might be intended.
+ *
+ * Return: 1 if a packet is in the duplicate list, 0 otherwise.
  */
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb)
@@ -1419,13 +1483,12 @@ out:
 }
 
 /**
- * batadv_bla_is_backbone_gw_orig
+ * batadv_bla_is_backbone_gw_orig - Check if the originator is a gateway for
+ *  the VLAN identified by vid.
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: originator mac address
  * @vid: VLAN identifier
  *
- * Check if the originator is a gateway for the VLAN identified by vid.
- *
  * Return: true if orig is a backbone for this vid, false otherwise.
  */
 bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
@@ -1460,13 +1523,11 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 }
 
 /**
- * batadv_bla_is_backbone_gw
+ * batadv_bla_is_backbone_gw - check if originator is a backbone gw for a VLAN.
  * @skb: the frame to be checked
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
- * bla_is_backbone_gw inspects the skb for the VLAN ID
- *
  * Return: 1 if the orig_node is also a gateway on the soft interface, otherwise
  * it returns 0.
  */
@@ -1495,7 +1556,12 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	return 1;
 }
 
-/* free all bla structures (for softinterface free or module unload) */
+/**
+ * batadv_bla_init - free all bla structures
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * for softinterface free or module unload
+ */
 void batadv_bla_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *primary_if;
@@ -1518,13 +1584,13 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_rx
+ * batadv_bla_rx - check packets coming from the mesh.
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
  * @is_bcast: the packet came in a broadcast packet type.
  *
- * bla_rx avoidance checks if:
+ * batadv_bla_rx avoidance checks if:
  *  * we have to race for a claim
  *  * if the frame is allowed on the LAN
  *
@@ -1614,12 +1680,12 @@ out:
 }
 
 /**
- * batadv_bla_tx
+ * batadv_bla_tx - check packets going into the mesh
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
  *
- * bla_tx checks if:
+ * batadv_bla_tx checks if:
  *  * a claim was received which has to be processed
  *  * the frame is allowed on the mesh
  *
@@ -1702,6 +1768,13 @@ out:
 	return ret;
 }
 
+/**
+ * batadv_bla_claim_table_seq_print_text - print the claim table in a seq file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
@@ -1751,6 +1824,14 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_bla_backbone_table_seq_print_text - print the backbone table in a seq
+ *  file
+ * @seq: seq file to print on
+ * @offset: not used
+ *
+ * Return: always 0
+ */
 int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0026-batman-adv-fix-kerneldoc-for-DAT-functions.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0026-batman-adv-fix-kerneldoc-for-DAT-functions.patch"

From 94ebb7c2fb57caa38b16131a5a0fbac2b73a2173 Mon Sep 17 00:00:00 2001
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 17 Nov 2015 16:40:51 +0800
Subject: [PATCH 26/28] batman-adv: fix kerneldoc for DAT functions

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/distributed-arp-table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 2f13429..60df823 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -741,6 +741,8 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 /**
  * batadv_dat_init - initialise the DAT internals
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 in case of success, a negative error code otherwise
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
@@ -779,6 +781,8 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
  * batadv_dat_cache_seq_print_text - print the local DAT hash table
  * @seq: seq file to print on
  * @offset: not used
+ *
+ * Return: always 0
  */
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0027-batman-adv-fix-kerneldoc-for-TT-functions.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0027-batman-adv-fix-kerneldoc-for-TT-functions.patch"

From e9069d3daabbf475c2e86f6ae59d9936cf1f1387 Mon Sep 17 00:00:00 2001
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 17 Nov 2015 16:40:52 +0800
Subject: [PATCH 27/28] batman-adv: fix kerneldoc for TT functions

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/translation-table.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0d00fef..1ca8831 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -69,9 +69,13 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 bool roaming);
 
 /**
- * batadv_compare_tt
+ * batadv_compare_tt - check if two TT entries are the same
+ * @node: the list element pointer of the first TT entry
+ * @data2: pointer to the tt_common_entry of the second TT entry
  *
- * Return: 1 if they are the same mac addr and vid
+ * Compare the MAC address and the VLAN ID of the two TT entries and check if
+ * they are the same TT client.
+ * Return: 1 if the two TT clients are the same, 0 otherwise
  */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
@@ -221,6 +225,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
+ * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -303,8 +308,9 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_global_size_mod - change the size by v of the local table
- *  identified by vid
+ * batadv_tt_global_size_mod - change the size by v of the global table
+ *  for orig_node identified by vid
+ * @orig_node: the originator for which the table has to be modified
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -723,7 +729,6 @@ out:
  *  function reserves the amount of space needed to send the entire global TT
  *  table. In case of success the value is updated with the real amount of
  *  reserved bytes
-
  * Allocate the needed amount of memory for the entire TT TVLV and write its
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN served by the originator node.
@@ -1245,9 +1250,12 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_global_orig_entry_find
+ * batadv_tt_global_orig_entry_find - find a TT orig_list_entry
+ * @entry: the TT global entry where the orig_list_entry has to be
+ *  extracted from
+ * @orig_node: the originator for which the orig_list_entry has to be found
  *
- * retrieves the orig_tt_list_entry belonging to orig_node from the
+ * retrieve the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
  *
  * Return: it with an increased refcounter, NULL if not found
@@ -1276,7 +1284,10 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 }
 
 /**
- * batadv_tt_global_entry_has_orig
+ * batadv_tt_global_entry_has_orig - check if a TT global entry is also handled
+ *  by a given originator
+ * @entry: the TT global entry to check
+ * @orig_node: the originator to search in the list
  *
  * find out if an orig_node is already in the list of a tt_global_entry.
  *
@@ -2521,6 +2532,8 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
  * @num_vlan: number of tvlv VLAN entries
  * @full_table: ask for the entire translation table if true, while only for the
  *  last TT diff otherwise
+ *
+ * Return: true if the TT Request was sent, false otherwise
  */
 static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *dst_orig_node,
@@ -3064,7 +3077,9 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_check_roam_count
+ * batadv_tt_check_roam_count - check if a client has roamed too frequently
+ * @bat_priv: the bat priv with all the soft interface information
+ * @client: mac address of the roaming client
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z
Content-Disposition: attachment; filename="0028-batman-adv-add-kernel-doc-for-AP-isolation-attribute.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0028-batman-adv-add-kernel-doc-for-AP-isolation-attribute.patch"

From 8e1271ba42cd2373a8398c9193a72a2df81214b1 Mon Sep 17 00:00:00 2001
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 17 Nov 2015 16:40:53 +0800
Subject: [PATCH 28/28] batman-adv: add kernel doc for AP isolation attributes
 in bat_priv

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7f7a0f1..5e8c8df 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -772,6 +772,9 @@ struct batadv_softif_vlan {
  * @orig_interval: OGM broadcast interval in milliseconds
  * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
  * @log_level: configured log level (see batadv_dbg_level)
+ * @isolation_mark: the skb->mark value used to match packets for AP isolation
+ * @isolation_mark_mask: bitmask identifying the bits in skb->mark to be used
+ *  for the isolation mark
  * @bcast_seqno: last sent broadcast packet sequence number
  * @bcast_queue_left: number of remaining buffered broadcast packet slots
  * @batman_queue_left: number of remaining OGM packet slots
-- 
2.6.4


--nextPart1613818.QmmG72Px1Z--

