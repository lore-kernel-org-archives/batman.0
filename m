Return-Path: <ruben@freifunk-nrw.de>
Date: Sat, 16 May 2015 22:07:36 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150516220736.2d896b4b@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/7HVJ81j3tforIha0NlBWT32"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Patch to add mesh_no_rebroadcast
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

--Sig_/7HVJ81j3tforIha0NlBWT32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
---
 hard-interface.c           |  2 ++
 send.c                     |  4 ++++
 sysfs-class-net-batman-adv | 10 ++++++++
 sysfs.c                    | 59 ++++++++++++++++++++++++++++++++++++++++++=
++++
 types.h                    |  1 +
 5 files changed, 76 insertions(+)

diff --git a/hard-interface.c b/hard-interface.c
index fbda6b5..3997f9c 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -591,6 +591,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	/* extra reference for return */
 	atomic_set(&hard_iface->refcount, 2);
=20
+	atomic_set(&hard_iface->no_rebroadcast, 0);
+
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
=20
diff --git a/send.c b/send.c
index d27161e..4383a66 100644
--- a/send.c
+++ b/send.c
@@ -513,6 +513,10 @@ static void batadv_send_outstanding_bcast_packet(struc=
t work_struct *work)
 		if (forw_packet->num_packets >=3D hard_iface->num_bcasts)
 			continue;
=20
+		if (atomic_read(&hard_iface->no_rebroadcast) &&
+		    forw_packet->skb->dev =3D=3D hard_iface->net_dev)
+			continue;
+
 		/* send a copy of the saved skb */
 		skb1 =3D skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
index 7f34a95..cf7fe00 100644
--- a/sysfs-class-net-batman-adv
+++ b/sysfs-class-net-batman-adv
@@ -13,3 +13,13 @@ Description:
                 displays the batman mesh interface this <iface>
                 currently is associated with.
=20
+What:           /sys/class/net/<iface>/batman-adv/no_rebroadcast
+Date:           Sep 2013
+Contact:        Linus L=C3=BCssing <linus.luessing@web.de>
+Description:
+                With this option set incoming multicast payload frames on
+                <iface> are not being rebroadcasted on <iface> again. This
+                option should be set on links which are known to be transi=
tive
+                and symmetric only, for instance point-to-point wifi longs=
hots
+                or wired links. Using this option wrongly is going to
+                break your mesh network, use at your own risk!
diff --git a/sysfs.c b/sysfs.c
index fc47baa..adaeca4 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -110,6 +110,17 @@ struct batadv_attribute batadv_attr_vlan_##_name =3D {=
	\
 	.store  =3D _store,				\
 }
=20
+/* Use this, if you have customized show and store functions
+ * for hard interface attrs
+ */
+#define BATADV_ATTR_HIF(_name, _mode, _show, _store)	\
+struct batadv_attribute batadv_attr_hif_##_name =3D {	\
+	.attr =3D {.name =3D __stringify(_name),		\
+		 .mode =3D _mode },			\
+	.show   =3D _show,				\
+	.store  =3D _store,				\
+};
+
 /* Use this, if you have customized show and store functions */
 #define BATADV_ATTR(_name, _mode, _show, _store)	\
 struct batadv_attribute batadv_attr_##_name =3D {		\
@@ -221,6 +232,52 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,=
			\
 	static BATADV_ATTR_VLAN(_name, _mode, batadv_show_vlan_##_name,	\
 				batadv_store_vlan_##_name)
=20
+#define BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)			\
+ssize_t batadv_store_hif_##_name(struct kobject *kobj,			\
+				 struct attribute *attr, char *buff,	\
+				 size_t count)				\
+{									\
+	struct net_device *net_dev =3D batadv_kobj_to_netdev(kobj);	\
+	struct batadv_hard_iface *hard_iface;				\
+	size_t res;							\
+									\
+	hard_iface =3D batadv_hardif_get_by_netdev(net_dev);		\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	res =3D __batadv_store_bool_attr(buff, count, _post_func,		\
+					      attr, &hard_iface->_name,	\
+					      hard_iface->soft_iface);	\
+	batadv_hardif_free_ref(hard_iface);				\
+	return res;							\
+}
+
+#define BATADV_ATTR_HIF_SHOW_BOOL(_name)				\
+ssize_t batadv_show_hif_##_name(struct kobject *kobj,			\
+				struct attribute *attr, char *buff)	\
+{									\
+	struct net_device *net_dev =3D batadv_kobj_to_netdev(kobj);	\
+	struct batadv_hard_iface *hard_iface;				\
+	size_t res;							\
+									\
+	hard_iface =3D batadv_hardif_get_by_netdev(net_dev);		\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	res =3D sprintf(buff, "%s\n",					\
+		      atomic_read(&hard_iface->_name) =3D=3D 0 ?		\
+				"disabled" : "enabled");		\
+	batadv_hardif_free_ref(hard_iface);				\
+	return res;							\
+}
+
+/* Use this, if you are going to turn a [name] in the vlan struct on or of=
f */
+#define BATADV_ATTR_HIF_BOOL(_name, _mode, _post_func)			\
+	static BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)		\
+	static BATADV_ATTR_HIF_SHOW_BOOL(_name)				\
+	static BATADV_ATTR_HIF(_name, _mode, batadv_show_hif_##_name,	\
+			       batadv_store_hif_##_name)
+
 static int batadv_store_bool_attr(char *buff, size_t count,
 				  struct net_device *net_dev,
 				  const char *attr_name, atomic_t *attr)
@@ -844,10 +901,12 @@ static ssize_t batadv_show_iface_status(struct kobjec=
t *kobj,
 static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
 		   batadv_store_mesh_iface);
 static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
+BATADV_ATTR_HIF_BOOL(no_rebroadcast, S_IRUGO | S_IWUSR, NULL);
=20
 static struct batadv_attribute *batadv_batman_attrs[] =3D {
 	&batadv_attr_mesh_iface,
 	&batadv_attr_iface_status,
+	&batadv_attr_hif_no_rebroadcast,
 	NULL,
 };
=20
diff --git a/types.h b/types.h
index 8854c05..39619fb 100644
--- a/types.h
+++ b/types.h
@@ -101,6 +101,7 @@ struct batadv_hard_iface {
 	struct batadv_hard_iface_bat_iv bat_iv;
 	struct work_struct cleanup_work;
 	struct dentry *debug_dir;
+	atomic_t no_rebroadcast;
 };
=20
 /**
--=20
2.1.3


--Sig_/7HVJ81j3tforIha0NlBWT32
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKAEARMKAAYFAlVXo4kACgkQgB++GrevraS0LQII/24XVHTiWXHzSAEr1TmWMPst
VpPx/0FKDQYDnlOy566zNMB6/KVfOcD/XKAWLAKqiCZftcG5S7sNE4CLUODnUcUC
CMhwFXC34hnDybm1L/DcHve9Qa8GuLvrgHR2ACUnE36oyb09jwFZK7AEjyh73Qs9
Cxt1mAj3HTMiq3jcrhtp77o8
=3teH
-----END PGP SIGNATURE-----

--Sig_/7HVJ81j3tforIha0NlBWT32--
