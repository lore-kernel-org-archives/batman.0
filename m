Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Jun 2015 16:45:01 +0200
Message-ID: <1898798.WP4bC1arXA@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1694866.T3S2MWd9xH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Missing list checks for *list_add*
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1694866.T3S2MWd9xH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

Simon debugged the refcnt problem and submitted some patches to fix the=
m. I
had a brief look and noticed that there are possible more problems simi=
lar to
the *list_del* ones - just with *list_add*. Basically some functions us=
e some
kind of get function, notice that the element does not exist and then c=
reate
a new one to add to the list. Only the "list_add" is protected. The res=
ult may
be that an element in twice in a list when only a single occurrence is =
allowed.

The problem I saw is batadv_gw_node_update. It first calls batadv_gw_no=
de_get
to check if an object with this value already exists and then uses
batadv_gw_node_add to add a node (which may already be added between th=
ese
two calls). So it has to be made sure that nothing modifies the list be=
tween
these two calls).

Similar looking functions are for example:

 * batadv_tvlv_handler_register
 * batadv_nc_get_nc_node
 * batadv_softif_create_vlan
 * batadv_tt_global_orig_entry_add

Just for illustration what I meant with "nothing modifies the list betw=
een
these two calls":

=2D-- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -30,6 +30,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -425,6 +426,8 @@ static void batadv_gw_node_add(struct batadv_priv *=
bat_priv,
 {
 =09struct batadv_gw_node *gw_node;
=20
+=09lockdep_assert_held(&bat_priv->gw.list_lock);
+
 =09if (gateway->bandwidth_down =3D=3D 0)
 =09=09return;
=20
@@ -441,9 +444,7 @@ static void batadv_gw_node_add(struct batadv_priv *=
bat_priv,
 =09gw_node->orig_node =3D orig_node;
 =09atomic_set(&gw_node->refcount, 1);
=20
=2D=09spin_lock_bh(&bat_priv->gw.list_lock);
 =09hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.list);
=2D=09spin_unlock_bh(&bat_priv->gw.list_lock);
=20
 =09batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 =09=09   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
@@ -497,11 +498,14 @@ void batadv_gw_node_update(struct batadv_priv *ba=
t_priv,
 =09struct batadv_gw_node *gw_node, *gw_node_tmp, *curr_gw =3D NULL;
 =09struct hlist_node *node_tmp;
=20
+=09spin_lock_bh(&bat_priv->gw.list_lock);
 =09gw_node =3D batadv_gw_node_get(bat_priv, orig_node);
 =09if (!gw_node) {
 =09=09batadv_gw_node_add(bat_priv, orig_node, gateway);
+=09=09spin_unlock_bh(&bat_priv->gw.list_lock);
 =09=09goto out;
 =09}
+=09spin_unlock_bh(&bat_priv->gw.list_lock);
=20
 =09if ((gw_node->bandwidth_down =3D=3D ntohl(gateway->bandwidth_down))=
 &&
 =09    (gw_node->bandwidth_up =3D=3D ntohl(gateway->bandwidth_up)))


Kind regards,
=09Sven
--nextPart1694866.T3S2MWd9xH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVjWVwAAoJEF2HCgfBJntGoVwP/1be4q0wYMiv3tevuWi7KXwD
COZX7+g2P/TpuAimMONUBgVcno/U/hsKIMOxlyw/QM9KqiLPxea/FojW28z8E8WK
9FMh808z7JzgPAcLjsonptClblQ6eERRJm0vWwVPiMFvA607Uqem3aMgbkCy8/je
B/yJJiiTT8lVmGPEJfSkOIhTlgcW5ol4+E4fVab/0z7Kmm6q50f7PBgOHkswEM3Y
LLXS6BZ65bURl82oXiLuozdrOkdbh6jeaHPPAHahyVvroFlfi3knRwKv7n0Hn+gp
KnCp+Cgb+jYNTDaSR57JcZSh6Nw24IgIlZt6yw6Y+FD4HBvUHUrVuZ1fb83xDPbo
5eST8wypDalaa553sougfXcjpBPPpDPGwlFuVe0iv+YhX9N5VHNljKm8F49XzYWa
a9N1kig+BdgOIfFZ0vAaac0tOK6uQbsuwjU0eDzb6yQDwrKnu9fk1wadhqgS7huv
LusL/q08xfbBppiIJ8HOA9AR6HEfPYX3o89Nx5S7ytA4V9XFeVCWH0NIvDrRD8eP
iv61b8oxS9HgflEc+xmC6iYvBHDMaOwK2QWmul6SJb9+8SVzMO1vyJRvwsh664dE
UBAFHDthYnAtXqW0zFl7wr5pM7A+lxn5QyAqKmUlpF0QsDGa/8a8B5dNs1MgxFnW
YVcp3HBmipXGa07Y0s/8
=uON7
-----END PGP SIGNATURE-----

--nextPart1694866.T3S2MWd9xH--

