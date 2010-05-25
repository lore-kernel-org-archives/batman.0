Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 26 May 2010 00:54:11 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100525225411.GA23108@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: bonding and interface
	alternating
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This patch adds interface alternating to the new bonding feature.=20

Instead of only sending in a round robin fashion on the usable interfaces,
we can also attempt to use a different interface for sending than for
receiving (interface alternating). This should reduce problems of the
half-duplex nature of WiFi Hardware and thus increase performance. The
bonding modes are now enhanced from two modes (disabled/enabled) to the=20
following 4 modes:

 * 0 - bonding off
 * 1 - round robin (as before)
 * 2 - interface alternating
 * 3 - smart bonding (round robin + interface alternating)

This is an experimental patch and targeted for upcoming experiments at
Wireless Battle Mesh v3 in Bracciano/Italy.

Feedback, comments and reviews appreciated!

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
Index: a/batman-adv-kernelland/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/types.h	(revision 1679)
+++ a/batman-adv-kernelland/types.h	(working copy)
@@ -119,7 +119,7 @@
 struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
-	atomic_t bonding_enabled;
+	atomic_t bonding_mode;
 	atomic_t vis_mode;
 	atomic_t gw_mode;
 	atomic_t gw_class;
Index: a/batman-adv-kernelland/soft-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/soft-interface.c	(revision 1679)
+++ a/batman-adv-kernelland/soft-interface.c	(working copy)
@@ -250,7 +250,7 @@
 		if (!orig_node)
 			orig_node =3D transtable_search(ethhdr->h_dest);
=20
-		router =3D find_router(orig_node);
+		router =3D find_router(orig_node, NULL);
=20
 		if (!router)
 			goto unlock;
Index: a/batman-adv-kernelland/hard-interface.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/hard-interface.c	(revision 1679)
+++ a/batman-adv-kernelland/hard-interface.c	(working copy)
@@ -514,7 +514,7 @@
=20
 		/* unicast packet */
 	case BAT_UNICAST:
-		ret =3D recv_unicast_packet(skb);
+		ret =3D recv_unicast_packet(skb, batman_if);
 		break;
=20
 		/* broadcast packet */
Index: a/batman-adv-kernelland/routing.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/routing.c	(revision 1679)
+++ a/batman-adv-kernelland/routing.c	(working copy)
@@ -417,7 +417,7 @@
=20
 {
 	/* don't care if bonding is not enabled */
-	if (!atomic_read(&bat_priv->bonding_enabled)) {
+	if (!atomic_read(&bat_priv->bonding_mode)) {
 		orig_node->bond.candidates =3D 0;
 		return;
 	}
@@ -429,7 +429,7 @@
 	return;
 }
=20
-/* mark possible bonding candidates in the neighbor list */
+/* mark possible bond.candidates in the neighbor list */
 void update_bonding_candidates(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node)
 {
@@ -440,7 +440,7 @@
 	struct neigh_node *first_candidate, *last_candidate;
=20
 	/* don't care if bonding is not enabled */
-	if (!atomic_read(&bat_priv->bonding_enabled)) {
+	if (!atomic_read(&bat_priv->bonding_mode)) {
 		orig_node->bond.candidates =3D 0;
 		return;
 	}
@@ -453,7 +453,7 @@
=20
 	best_tq =3D orig_node->router->tq_avg;
=20
-	/* update bonding candidates */
+	/* update bond.candidates */
=20
 	candidates =3D 0;
=20
@@ -1007,14 +1007,16 @@
=20
 /* find a suitable router for this originator, and use
  * bonding if possible. */
-struct neigh_node *find_router(struct orig_node *orig_node)
+struct neigh_node *find_router(struct orig_node *orig_node,
+		struct batman_if *recv_if)
 {
 	/* FIXME: each orig_node->batman_if will be attached to a softif */
 	struct bat_priv *bat_priv =3D netdev_priv(soft_device);
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
-	struct neigh_node *router;
+	struct neigh_node *router, *first_candidate;
 	static uint8_t zero_mac[ETH_ALEN] =3D {0, 0, 0, 0, 0, 0};
+	int bonding_mode;
=20
 	if (!orig_node)
 		return NULL;
@@ -1022,8 +1024,9 @@
 	if (!orig_node->router)
 		return NULL;
=20
-	/* don't care if bonding is not enabled */
-	if (!atomic_read(&bat_priv->bonding_enabled))
+	/* just return default router if bonding is not enabled */
+	bonding_mode =3D atomic_read(&bat_priv->bonding_mode);
+	if (!bonding_mode)
 		return orig_node->router;
=20
 	router_orig =3D orig_node->router->orig_node;
@@ -1052,19 +1055,50 @@
 	if (primary_orig_node->bond.candidates < 2)
 		return orig_node->router;
=20
-	router =3D primary_orig_node->bond.selected;
+	switch (bonding_mode) {
+	case BONDING_ROUNDROBIN:
+		router =3D primary_orig_node->bond.selected;
=20
-	/* sanity check - this should never happen. */
-	if (!router)
-		return orig_node->router;
+		/* sanity check - this should never happen. */
+		if (!router)
+			return orig_node->router;
=20
-	/* select the next bonding partner ... */
-	primary_orig_node->bond.selected =3D router->next_bond_candidate;
+		/* select the next bonding partner ... */
+		primary_orig_node->bond.selected =3D router->next_bond_candidate;
+		break;
+	case BONDING_ALTERNATE:
+		/* in alternate mode, the first node should
+		 * always choose the default router. */
+		if (recv_if =3D=3D NULL)
+			return orig_node->router;
=20
+		/* all nodes between should choose a candidate which
+		 * is is not on the interface where the packet came
+		 * in. There might be more than one alternative
+		 * interface, and we send the packet in a round robin
+		 * fashion on these interfaces in this case. */
+	case BONDING_SMART:
+		first_candidate =3D primary_orig_node->bond.selected;
+		router =3D first_candidate;
+
+		do {
+			/* recv_if =3D=3D NULL on the first node. */
+			if (router->if_incoming !=3D recv_if)
+				break;
+			router =3D router->next_bond_candidate;
+		} while (router !=3D first_candidate);
+
+		/* select the next to have some diversity here. */
+		primary_orig_node->bond.selected =3D router->next_bond_candidate;
+		break;
+	default:
+		router =3D orig_node->router;
+	}
+
 	return router;
 }
=20
-int recv_unicast_packet(struct sk_buff *skb)
+int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
@@ -1116,7 +1150,7 @@
 	orig_node =3D ((struct orig_node *)
 		     hash_find(orig_hash, unicast_packet->dest));
=20
-	router =3D find_router(orig_node);
+	router =3D find_router(orig_node, recv_if);
=20
 	if (!router) {
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
Index: a/batman-adv-kernelland/main.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/main.h	(revision 1679)
+++ a/batman-adv-kernelland/main.h	(working copy)
@@ -63,6 +63,10 @@
  * to be considered as bonding candidates */
=20
 #define BONDING_TQ_THRESHOLD	50
+#define BONDING_NONE		0
+#define BONDING_ROUNDROBIN 	1
+#define BONDING_ALTERNATE	2
+#define BONDING_SMART		3
=20
 #define MAX_AGGREGATION_BYTES 512 /* should not be bigger than 512 bytes or
 				   * change the size of
Index: a/batman-adv-kernelland/routing.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/routing.h	(revision 1679)
+++ a/batman-adv-kernelland/routing.h	(working copy)
@@ -32,11 +32,12 @@
 				struct neigh_node *neigh_node,
 				unsigned char *hna_buff, int hna_buff_len);
 int recv_icmp_packet(struct sk_buff *skb);
-int recv_unicast_packet(struct sk_buff *skb);
+int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb);
 int recv_vis_packet(struct sk_buff *skb);
 int recv_bat_packet(struct sk_buff *skb,
 				struct batman_if *batman_if);
-struct neigh_node *find_router(struct orig_node *orig_node);
+struct neigh_node *find_router(struct orig_node *orig_node,
+		struct batman_if *recv_if);
 void update_bonding_candidates(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node);
Index: a/batman-adv-kernelland/bat_sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/batman-adv-kernelland/bat_sysfs.c	(revision 1679)
+++ a/batman-adv-kernelland/bat_sysfs.c	(working copy)
@@ -92,10 +92,9 @@
 {
 	struct device *dev =3D to_dev(kobj->parent);
 	struct bat_priv *bat_priv =3D netdev_priv(to_net_dev(dev));
-	int bond_status =3D atomic_read(&bat_priv->bonding_enabled);
+	int bonding_mode =3D atomic_read(&bat_priv->bonding_mode);
=20
-	return sprintf(buff, "%s\n",
-		       bond_status =3D=3D 0 ? "disabled" : "enabled");
+	return sprintf(buff, "%d\n", bonding_mode);
 }
=20
 static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
@@ -104,17 +103,25 @@
 	struct device *dev =3D to_dev(kobj->parent);
 	struct net_device *net_dev =3D to_net_dev(dev);
 	struct bat_priv *bat_priv =3D netdev_priv(net_dev);
-	int bonding_enabled_tmp =3D -1;
+	int bonding_mode_tmp =3D -1;
=20
-	if (((count =3D=3D 2) && (buff[0] =3D=3D '1')) ||
-	    (strncmp(buff, "enable", 6) =3D=3D 0))
-		bonding_enabled_tmp =3D 1;
+	if (count =3D=3D 2)
+		switch (buff[0]) {
+		case '0':
+			bonding_mode_tmp =3D 0;
+			break;
+		case '1':
+			bonding_mode_tmp =3D BONDING_ROUNDROBIN;
+			break;
+		case '2':
+			bonding_mode_tmp =3D BONDING_ALTERNATE;
+			break;
+		case '3':
+			bonding_mode_tmp =3D BONDING_SMART;
+			break;
+	}
=20
-	if (((count =3D=3D 2) && (buff[0] =3D=3D '0')) ||
-	    (strncmp(buff, "disable", 7) =3D=3D 0))
-		bonding_enabled_tmp =3D 0;
-
-	if (bonding_enabled_tmp < 0) {
+	if (bonding_mode_tmp < 0) {
 		if (buff[count - 1] =3D=3D '\n')
 			buff[count - 1] =3D '\0';
=20
@@ -123,16 +130,14 @@
 		return -EINVAL;
 	}
=20
-	if (atomic_read(&bat_priv->bonding_enabled) =3D=3D bonding_enabled_tmp)
+	if (atomic_read(&bat_priv->bonding_mode) =3D=3D bonding_mode_tmp)
 		return count;
=20
-	printk(KERN_INFO "batman-adv:Changing bonding from: %s to: %s on mesh: %s=
\n",
-	       atomic_read(&bat_priv->bonding_enabled) =3D=3D 1 ?
-	       "enabled" : "disabled",
-	       bonding_enabled_tmp =3D=3D 1 ? "enabled" : "disabled",
+	printk(KERN_INFO "batman-adv:Changing bonding from: %d to: %d on mesh: %s=
\n",
+	       atomic_read(&bat_priv->bonding_mode), bonding_mode_tmp,
 	       net_dev->name);
=20
-	atomic_set(&bat_priv->bonding_enabled, (unsigned)bonding_enabled_tmp);
+	atomic_set(&bat_priv->bonding_mode, (unsigned)bonding_mode_tmp);
 	return count;
 }
=20
@@ -303,7 +308,7 @@
 	/* FIXME: should be done in the general mesh setup
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
-	atomic_set(&bat_priv->bonding_enabled, 0);
+	atomic_set(&bat_priv->bonding_mode, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_class, 0);

