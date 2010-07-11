Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 11 Jul 2010 08:26:26 +0200
References: <201007101606.27989.lindner_marek@yahoo.de>
In-Reply-To: <201007101606.27989.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1395940.YObzrapcAs";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007110826.28596.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] multiple mesh clouds
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

--nextPart1395940.YObzrapcAs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Hi folks,
>=20
> we already had quite some patches going into batman-adv to allow concurre=
nt
> meshes on the same device. I'm happy to announce that this is the final
> batch which will unlock this feature.
> As you can see it is a lot of code that needs to be reviewed and tested. =
On
> my testbed it works quite well but nearly all subsystems are affected, so
> I expect more bugs to materialize. Please give it a try and let me know
> what you think.

I hadn't found time to test the patches, but the they have to be cleaned up=
 a
little bit. So just as reminder:

WARNING: please, no space before tabs
#436: FILE: batman-adv/hard-interface.c:336:
+// ^Iif ((atomic_read(&module_state) =3D=3D MODULE_ACTIVE) &&$

ERROR: do not use C99 // comments
#436: FILE: batman-adv/hard-interface.c:336:
+//     if ((atomic_read(&module_state) =3D=3D MODULE_ACTIVE) &&

WARNING: please, no space before tabs
#437: FILE: batman-adv/hard-interface.c:337:
+// ^I    (bat_priv->num_ifaces =3D=3D 0))$

ERROR: do not use C99 // comments
#437: FILE: batman-adv/hard-interface.c:337:
+//         (bat_priv->num_ifaces =3D=3D 0))

WARNING: please, no space before tabs
#438: FILE: batman-adv/hard-interface.c:338:
+// ^I^Ideactivate_module();$

ERROR: do not use C99 // comments
#438: FILE: batman-adv/hard-interface.c:338:
+//             deactivate_module();

WARNING: please, no space before tabs
#723: FILE: batman-adv/main.c:113:
+// ^Ihna_local_add(soft_device->dev_addr);$

ERROR: do not use C99 // comments
#723: FILE: batman-adv/main.c:113:
+//     hna_local_add(soft_device->dev_addr);

WARNING: please, no space before tabs
#729: FILE: batman-adv/main.c:118:
+// ^Iupdate_min_mtu();$

ERROR: do not use C99 // comments
#729: FILE: batman-adv/main.c:118:
+//     update_min_mtu();

WARNING: please, no space before tabs
#788: FILE: batman-adv/originator.c:117:
+// ^Ihash_delete(orig_hash, free_orig_node, bat_priv);$

ERROR: do not use C99 // comments
#788: FILE: batman-adv/originator.c:117:
+//     hash_delete(orig_hash, free_orig_node, bat_priv);

WARNING: line over 80 characters
#845: FILE: batman-adv/originator.c:244:
+               if (purge_orig_neighbors(bat_priv, orig_node, &best_neigh_n=
ode)) {

WARNING: please, no space before tabs
#861: FILE: batman-adv/originator.c:269:
+// ^I^Iif (purge_orig_node(bat_priv, orig_node)) {$

ERROR: do not use C99 // comments
#861: FILE: batman-adv/originator.c:269:
+//             if (purge_orig_node(bat_priv, orig_node)) {

WARNING: please, no space before tabs
#862: FILE: batman-adv/originator.c:270:
+// ^I^I^Iif (orig_node->gw_flags)$

ERROR: do not use C99 // comments
#862: FILE: batman-adv/originator.c:270:
+//                     if (orig_node->gw_flags)

WARNING: please, no space before tabs
#863: FILE: batman-adv/originator.c:271:
+// ^I^I^I^Igw_node_delete(bat_priv, orig_node);$

ERROR: do not use C99 // comments
#863: FILE: batman-adv/originator.c:271:
+//                             gw_node_delete(bat_priv, orig_node);

WARNING: please, no space before tabs
#864: FILE: batman-adv/originator.c:272:
+// ^I^I^Ihash_remove_bucket(orig_hash, &hashit);$

ERROR: do not use C99 // comments
#864: FILE: batman-adv/originator.c:272:
+//                     hash_remove_bucket(orig_hash, &hashit);

WARNING: please, no space before tabs
#865: FILE: batman-adv/originator.c:273:
+// ^I^I^Ifree_orig_node(orig_node);$

ERROR: do not use C99 // comments
#865: FILE: batman-adv/originator.c:273:
+//                     free_orig_node(orig_node);

WARNING: please, no space before tabs
#866: FILE: batman-adv/originator.c:274:
+// ^I^I}$

ERROR: do not use C99 // comments
#866: FILE: batman-adv/originator.c:274:
+//             }

WARNING: please, no space before tabs
#873: FILE: batman-adv/originator.c:280:
+// ^Igw_election(bat_priv);$

ERROR: do not use C99 // comments
#873: FILE: batman-adv/originator.c:280:
+//     gw_election(bat_priv);

WARNING: line over 80 characters
#950: FILE: batman-adv/routing.c:90:
+               hna_global_del_orig(bat_priv, orig_node, "originator timed =
out");

WARNING: line over 80 characters
#959: FILE: batman-adv/routing.c:98:
+               hna_global_add_orig(bat_priv, orig_node, hna_buff, hna_buff=
_len);

WARNING: line over 80 characters
#1037: FILE: batman-adv/routing.c:317:
+       update_routes(bat_priv, orig_node, neigh_node, hna_buff, tmp_hna_bu=
ff_len);

WARNING: line over 80 characters
#1101: FILE: batman-adv/routing.c:404:
+               need_update |=3D bit_get_packet(bat_priv, tmp_neigh_node->r=
eal_bits,

WARNING: line over 80 characters
#1556: FILE: batman-adv/soft-interface.c:249:
+void interface_rx(struct net_device *soft_iface, struct sk_buff *skb, int =
hdr_size)

WARNING: line over 80 characters
#1689: FILE: batman-adv/soft-interface.h:27:
+void interface_rx(struct net_device *soft_iface, struct sk_buff *skb, int =
hdr_size);

WARNING: please, no space before tabs
#1791: FILE: batman-adv/translation-table.c:266:
+// ^I^Iif ((!hna_local_entry->never_purge) &&$

ERROR: do not use C99 // comments
#1791: FILE: batman-adv/translation-table.c:266:
+//             if ((!hna_local_entry->never_purge) &&

WARNING: please, no space before tabs
#1792: FILE: batman-adv/translation-table.c:267:
+// ^I^I    time_after(jiffies, timeout))$

ERROR: do not use C99 // comments
#1792: FILE: batman-adv/translation-table.c:267:
+//                 time_after(jiffies, timeout))

WARNING: please, no space before tabs
#1793: FILE: batman-adv/translation-table.c:268:
+// ^I^I^Ihna_local_del(bat_priv, hna_local_entry,$

ERROR: do not use C99 // comments
#1793: FILE: batman-adv/translation-table.c:268:
+//                     hna_local_del(bat_priv, hna_local_entry,

WARNING: please, no space before tabs
#1794: FILE: batman-adv/translation-table.c:269:
+// ^I^I^I^I      "address timed out");$

ERROR: do not use C99 // comments
#1794: FILE: batman-adv/translation-table.c:269:
+//                                   "address timed out");

WARNING: line over 80 characters
#1826: FILE: batman-adv/translation-table.c:350:
+                       hna_local_del(bat_priv, hna_local_entry, "global hn=
a received");

WARNING: please, no space before tabs
#1941: FILE: batman-adv/vis.c:704:
+// ^Istruct bat_priv *bat_priv =3D netdev_priv(soft_device);$

ERROR: do not use C99 // comments
#1941: FILE: batman-adv/vis.c:704:
+//     struct bat_priv *bat_priv =3D netdev_priv(soft_device);

WARNING: please, no space before tabs
#1951: FILE: batman-adv/vis.c:710:
+// ^Iif (generate_vis_packet(bat_priv) =3D=3D 0) {$

ERROR: do not use C99 // comments
#1951: FILE: batman-adv/vis.c:710:
+//     if (generate_vis_packet(bat_priv) =3D=3D 0) {

WARNING: please, no space before tabs
#1952: FILE: batman-adv/vis.c:711:
+// ^I^I/* schedule if generation was successful */$

ERROR: do not use C99 // comments
#1952: FILE: batman-adv/vis.c:711:
+//             /* schedule if generation was successful */

WARNING: please, no space before tabs
#1953: FILE: batman-adv/vis.c:712:
+// ^I^Isend_list_add(my_vis_info);$

ERROR: do not use C99 // comments
#1953: FILE: batman-adv/vis.c:712:
+//             send_list_add(my_vis_info);

WARNING: please, no space before tabs
#1954: FILE: batman-adv/vis.c:713:
+// ^I}$

ERROR: do not use C99 // comments
#1954: FILE: batman-adv/vis.c:713:
+//     }

total: 22 errors, 30 warnings, 0 checks, 1710 lines checked

0001-batman-adv-attach-each-hard-interface-to-a-soft-inte.patch has style p=
roblems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
WARNING: line over 80 characters
#1544: FILE: batman-adv/send.c:494:
+               _add_bcast_packet_to_list(bat_priv, forw_packet, ((5 * HZ) =
/ 1000));

CHECK: spinlock_t definition without comment
#2442: FILE: batman-adv/types.h:144:
+       spinlock_t orig_hash_lock;

CHECK: spinlock_t definition without comment
#2443: FILE: batman-adv/types.h:145:
+       spinlock_t forw_bat_list_lock;

CHECK: spinlock_t definition without comment
#2444: FILE: batman-adv/types.h:146:
+       spinlock_t forw_bcast_list_lock;

CHECK: spinlock_t definition without comment
#2445: FILE: batman-adv/types.h:147:
+       spinlock_t hna_lhash_lock;

CHECK: spinlock_t definition without comment
#2446: FILE: batman-adv/types.h:148:
+       spinlock_t hna_ghash_lock;

CHECK: spinlock_t definition without comment
#2447: FILE: batman-adv/types.h:149:
+       spinlock_t gw_list_lock;

CHECK: spinlock_t definition without comment
#2448: FILE: batman-adv/types.h:150:
+       spinlock_t vis_hash_lock;

CHECK: spinlock_t definition without comment
#2449: FILE: batman-adv/types.h:151:
+       spinlock_t vis_list_lock;

WARNING: line over 80 characters
#2822: FILE: batman-adv/vis.c:566:
+                               spin_unlock_irqrestore(&bat_priv->orig_hash=
_lock, flags);

total: 0 errors, 2 warnings, 8 checks, 2913 lines checked

0002-batman-adv-multiple-mesh-clouds.patch has style problems, please revie=
w.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


>=20
> Regards,
> Marek

--nextPart1395940.YObzrapcAs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMOWQTAAoJEF2HCgfBJntGwWUP/0IlnKErAD6MXFC3fePMZmwG
6soaX1hB0odWzGviw4l+WLkpf5/uz8ivCoPy4cofm2KEWcxzWtqTzbFxIjLuyXUG
+zCNy3+c18XB4QwUnAODz0/62YR0yDRCYshP+SZ/ggzYmdJIX9ldW7chmwBxmKQ1
gHOAv4lJzoxMZ5L1PDZpYeGqqB4yGokAhSf1uI9JXV2AHh4R1sH3/Pm5VXTwE8hP
6CeUQNYJcTpB0QE7Dsr9oRTrxqReJmlsdeZwkPtEYFbmpvL4j1B9ONSW6vLKM9GY
g5KXyU5Qo3WvlYNBbf6dJdbLQ1aGClqlSfbqzWx3tk5SF8tv3EoIEa2Xyb23u3YF
rwZhT7lI3i2rULKox/PiCnkJiGByBzEBPOQs6SPs6T+QHJom+WBXzmUtMqG12Rg0
5HbSKKXE/5WnlTAKjAaxWRljycIHFJJUTKR5+kJ8MmBKLpkfYUNh+DIN/FW//K7O
lnATxaAlnBCqd4bxLaYxukV37VKKIlFljgPQiy17kBYYeCVFl/V9Y+IhbxBOPGc5
qbAPzTToY4ovDNEQ8TRhp0HENkWNrgoqU3bAYQZiGeVka1iEfEocj75fgbNIonpV
YVVjAZjsiAuNdvDTBUYh1Uqbr9TSLLk9zgY2Fzt5o8yqFxk86Cj4nZ8Tf2sf4FCa
TSwuCKdEY+LYEm1qphfa
=4/Tx
-----END PGP SIGNATURE-----

--nextPart1395940.YObzrapcAs--
