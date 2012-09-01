Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  1 Sep 2012 19:49:42 +0200
Message-Id: <1346521782-5634-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: prevent using any virtual device
	created on batman-adv as hard-interface
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

Any virtual device created on top of a batman-adv mesh interface must be
prevented to be used to create a new mesh network (this would lead to an
unwanted batman-over-batman configuration)

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hard-interface.c b/hard-interface.c
index fab9e41..11d5434 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -58,6 +58,41 @@ out:
 	return hard_iface;
 }
 
+/**
+ * batadv_is_on_batman_iface - check if a device is a batman iface descendant
+ * @net_dev: the device to check
+ *
+ * If the user creates any virtual device on top of a batman-adv interface, it
+ * is important to prevent this new interface to be used to create a new mesh
+ * network (this behaviour would lead to a batman-over-batman configuration).
+ * This function recursively checks all the fathers of the device passed as
+ * argument looking for a batman-adv soft interface.
+ *
+ * Returns true if the device is descendant of a batman-adv mesh interface (or
+ * if it is a batman-adv interface itself), false otherwise
+ */
+static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
+{
+	struct net_device *parent_dev;
+	bool ret;
+
+	/* check if this is a batman-adv mesh interface */
+	if (batadv_softif_is_valid(net_dev))
+		return true;
+
+	/* no more parents..stop recursion */
+	if (net_dev->iflink == net_dev->ifindex)
+		return false;
+
+	/* recurse over the parent device */
+	parent_dev = dev_get_by_index(&init_net, net_dev->iflink);
+	ret = batadv_is_on_batman_iface(parent_dev);
+
+	if (parent_dev)
+		dev_put(parent_dev);
+	return ret;
+}
+
 static int batadv_is_valid_iface(const struct net_device *net_dev)
 {
 	if (net_dev->flags & IFF_LOOPBACK)
@@ -70,7 +105,7 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
 		return 0;
 
 	/* no batman over batman */
-	if (batadv_softif_is_valid(net_dev))
+	if (batadv_is_on_batman_iface(net_dev))
 		return 0;
 
 	return 1;
-- 
1.7.12

