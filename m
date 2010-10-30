Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 30 Oct 2010 14:14:02 +0200
References: <201010240313.35215.lindner_marek@yahoo.de>
In-Reply-To: <201010240313.35215.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart107372490.NFgRi83tEe";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010301414.06280.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway handling
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

--nextPart107372490.NFgRi83tEe
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[PATCH 1/8] batman-adv: remove redundant gw_node_list_free() function
> @@ -315,32 +315,20 @@ void gw_node_purge_deleted(struct bat_priv *bat_pri=
v)
>         spin_lock_bh(&bat_priv->gw_list_lock);
> =20
>         hlist_for_each_entry_safe(gw_node, node, node_tmp,
> -                                               &bat_priv->gw_list, list)=
 {
> -               if ((gw_node->deleted) &&
> -                   (time_after(jiffies, gw_node->deleted + timeout))) {
> -
> -                       hlist_del_rcu(&gw_node->list);
> -                       call_rcu(&gw_node->rcu, gw_node_free_rcu);
> -               }
> -       }
> -
> -       spin_unlock_bh(&bat_priv->gw_list_lock);
> -}
> -
> -void gw_node_list_free(struct bat_priv *bat_priv)
> -{
> -       struct gw_node *gw_node;
> -       struct hlist_node *node, *node_tmp;
> +                                 &bat_priv->gw_list, list) {
> +               if (((!gw_node->deleted) ||
> +                    (time_after(jiffies, gw_node->deleted + timeout))) &&
> +                   atomic_read(&bat_priv->mesh_state) =3D=3D MESH_ACTIVE)
> +                       continue;

This should be time_before.


[PATCH 4/8] batman-adv: move gateway bandwidth into its own sysfs file
> @@ -293,12 +293,38 @@ static ssize_t show_gw_mode(struct kobject *kobj,
> struct attribute *attr, }
> =20
>  static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *att=
r,
> -                             char *buff, size_t count)
> +                            char *buff, size_t count)

Why was the space removed?

> +               if ((strnicmp(tmp_ptr, "kbit", 4) =3D=3D 0) ||
> +                       (multi > 1))

Why this indentation? And This should be on a single line (or I count wrong=
).


[PATCH 5/8] batman-adv: cleanup gw mode sysfs file to only accept one value
> +       if ((gw_mode_tmp =3D=3D GW_MODE_CLIENT) &&
> +           (atomic_read(&bat_priv->gw_sel_class) =3D=3D 0))
> +               atomic_set(&bat_priv->gw_sel_class, 20);
> +
> +       if ((gw_mode_tmp =3D=3D GW_MODE_SERVER) &&
> +           (atomic_read(&bat_priv->gw_bandwidth) =3D=3D 0))
> +               atomic_set(&bat_priv->gw_bandwidth, 41);

Why setting that here? And why do you set gw_sel_class here to 20 (if it is=
 0=20
before) and in softif_create to 0? Shouldn't it be set to 20 in softif_crea=
te=20
instead?


I don't see a big problem at the moment.

Best regards,
	Sven

--nextPart107372490.NFgRi83tEe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJMzAwLAAoJEF2HCgfBJntG/iQP+gNaaL2gAGaQTqDC/x6ww6B1
aI/FKGUUr36f4QIDkCIsiPk/eeo4OWy+M/5IDnzRSrjmnr5C28pn/hJDCHjHrvJR
HdwNosDR03dNOhdPBVEYGuG6FmhXdS43sOQovWMbrUcbnKbWjRsVDPvniiy0Nh4U
KeXud1IcKF+w3+qPiiKjz5IW5yXdU2LIvRI+TCN5KL+Se6G9isYldy8oD852s/ny
ZDc+/H6UX5YVfCQWhzrEWEtyqwrmOko6ZTOtxN1J3boyoGPYmZFWKSHP89XfsTDG
2leV4dn1j/Zgywt24T+YHbZkFjUOYmkf2vScyuP4qqTLbmZfZsVNYx/jtdr+dnJz
5VK0buI+kA7EX/CVZ1q7wbKlXxnlFg1gbV5pjz43CJiunJHyqPmFaJewWpo5jrZx
r5GXtWzyNKQcXgV8DL+UEWGGmBS64mfTBN58zP3E2j/tbsfobuIiTVMV6+fhNgti
PKa1/2mQFM51m2NCJ60W3vBY67/zelOhAey65BB8EO4Zk1C+pKG7tJs6XyIRJtze
9Ia67KketxY7VEolErVi1Xx7AzbM57M6WDI2IB9VsCELUggxvZth26beSVOiMc7o
6i1RSyduscvfHIbTBcbbx9WLpDPtThe8Jy3V9GxvhT1HPEi5N3VtG6Ad/2pkXPWQ
lFbG/blT+nABrpfusRrd
=pEwa
-----END PGP SIGNATURE-----

--nextPart107372490.NFgRi83tEe--
