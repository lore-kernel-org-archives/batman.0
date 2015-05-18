Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 18 May 2015 10:33:10 +0200
Message-ID: <5518681.hhA3VFM6WN@prime>
In-Reply-To: <20150516220736.2d896b4b@i3.local>
References: <20150516220736.2d896b4b@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1722026.Cn7dV6FaOg";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patch to add mesh_no_rebroadcast
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


--nextPart1722026.Cn7dV6FaOg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Hi Ruben,

thanks for re-sending the patch - as Sven pointed out we need to have i=
t=20
formatted properly before we can accept it. He mentioned various links =
which=20
we have on the wiki, if you have troubles to apply we can also help you=
 on=20
IRC.

@All: I've been talking to Ruben personally at Wireless Community Weeke=
nd. He=20
explained that they drag this patch around for their gluon community fi=
rmware=20
and would like to get it merged - I found the original discussion, but =
he had=20
some good arguments to merge it anyway. Therefore I've asked Ruben to r=
ebase=20
and send it again to re-start the discussion. :)

Thanks!
    Simon

On Saturday 16 May 2015 22:07:36 Ruben Wisniewski wrote:
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  hard-interface.c           |  2 ++
>  send.c                     |  4 ++++
>  sysfs-class-net-batman-adv | 10 ++++++++
>  sysfs.c                    | 59
> ++++++++++++++++++++++++++++++++++++++++++++++ types.h               =
     |
>  1 +
>  5 files changed, 76 insertions(+)
>=20
> diff --git a/hard-interface.c b/hard-interface.c
> index fbda6b5..3997f9c 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -591,6 +591,8 @@ batadv_hardif_add_interface(struct net_device *ne=
t_dev)
>  =09/* extra reference for return */
>  =09atomic_set(&hard_iface->refcount, 2);
>=20
> +=09atomic_set(&hard_iface->no_rebroadcast, 0);
> +
>  =09batadv_check_known_mac_addr(hard_iface->net_dev);
>  =09list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
>=20
> diff --git a/send.c b/send.c
> index d27161e..4383a66 100644
> --- a/send.c
> +++ b/send.c
> @@ -513,6 +513,10 @@ static void batadv_send_outstanding_bcast_packet=
(struct
> work_struct *work) if (forw_packet->num_packets >=3D hard_iface->num_=
bcasts)
>  =09=09=09continue;
>=20
> +=09=09if (atomic_read(&hard_iface->no_rebroadcast) &&
> +=09=09    forw_packet->skb->dev =3D=3D hard_iface->net_dev)
> +=09=09=09continue;
> +
>  =09=09/* send a copy of the saved skb */
>  =09=09skb1 =3D skb_clone(forw_packet->skb, GFP_ATOMIC);
>  =09=09if (skb1)
> diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
> index 7f34a95..cf7fe00 100644
> --- a/sysfs-class-net-batman-adv
> +++ b/sysfs-class-net-batman-adv
> @@ -13,3 +13,13 @@ Description:
>                  displays the batman mesh interface this <iface>
>                  currently is associated with.
>=20
> +What:           /sys/class/net/<iface>/batman-adv/no_rebroadcast
> +Date:           Sep 2013
> +Contact:        Linus L=FCssing <linus.luessing@web.de>
> +Description:
> +                With this option set incoming multicast payload fram=
es on
> +                <iface> are not being rebroadcasted on <iface> again=
. This
> +                option should be set on links which are known to be
> transitive +                and symmetric only, for instance point-to=
=2Dpoint
> wifi longshots +                or wired links. Using this option wro=
ngly
> is going to +                break your mesh network, use at your own=
 risk!
> diff --git a/sysfs.c b/sysfs.c
> index fc47baa..adaeca4 100644
> --- a/sysfs.c
> +++ b/sysfs.c
> @@ -110,6 +110,17 @@ struct batadv_attribute batadv_attr_vlan_##_name=
 =3D {=09\
>  =09.store  =3D _store,=09=09=09=09\
>  }
>=20
> +/* Use this, if you have customized show and store functions
> + * for hard interface attrs
> + */
> +#define BATADV_ATTR_HIF(_name, _mode, _show, _store)=09\
> +struct batadv_attribute batadv_attr_hif_##_name =3D {=09\
> +=09.attr =3D {.name =3D __stringify(_name),=09=09\
> +=09=09 .mode =3D _mode },=09=09=09\
> +=09.show   =3D _show,=09=09=09=09\
> +=09.store  =3D _store,=09=09=09=09\
> +};
> +
>  /* Use this, if you have customized show and store functions */
>  #define BATADV_ATTR(_name, _mode, _show, _store)=09\
>  struct batadv_attribute batadv_attr_##_name =3D {=09=09\
> @@ -221,6 +232,52 @@ ssize_t batadv_show_vlan_##_name(struct kobject
> *kobj,=09=09=09\ static BATADV_ATTR_VLAN(_name, _mode,
> batadv_show_vlan_##_name,=09\ batadv_store_vlan_##_name)
>=20
> +#define BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)=09=09=09\
> +ssize_t batadv_store_hif_##_name(struct kobject *kobj,=09=09=09\
> +=09=09=09=09 struct attribute *attr, char *buff,=09\
> +=09=09=09=09 size_t count)=09=09=09=09\
> +{=09=09=09=09=09=09=09=09=09\
> +=09struct net_device *net_dev =3D batadv_kobj_to_netdev(kobj);=09\
> +=09struct batadv_hard_iface *hard_iface;=09=09=09=09\
> +=09size_t res;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09hard_iface =3D batadv_hardif_get_by_netdev(net_dev);=09=09\
> +=09if (!hard_iface)=09=09=09=09=09=09\
> +=09=09return 0;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09res =3D __batadv_store_bool_attr(buff, count, _post_func,=09=09\
> +=09=09=09=09=09      attr, &hard_iface->_name,=09\
> +=09=09=09=09=09      hard_iface->soft_iface);=09\
> +=09batadv_hardif_free_ref(hard_iface);=09=09=09=09\
> +=09return res;=09=09=09=09=09=09=09\
> +}
> +
> +#define BATADV_ATTR_HIF_SHOW_BOOL(_name)=09=09=09=09\
> +ssize_t batadv_show_hif_##_name(struct kobject *kobj,=09=09=09\
> +=09=09=09=09struct attribute *attr, char *buff)=09\
> +{=09=09=09=09=09=09=09=09=09\
> +=09struct net_device *net_dev =3D batadv_kobj_to_netdev(kobj);=09\
> +=09struct batadv_hard_iface *hard_iface;=09=09=09=09\
> +=09size_t res;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09hard_iface =3D batadv_hardif_get_by_netdev(net_dev);=09=09\
> +=09if (!hard_iface)=09=09=09=09=09=09\
> +=09=09return 0;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09res =3D sprintf(buff, "%s\n",=09=09=09=09=09\
> +=09=09      atomic_read(&hard_iface->_name) =3D=3D 0 ?=09=09\
> +=09=09=09=09"disabled" : "enabled");=09=09\
> +=09batadv_hardif_free_ref(hard_iface);=09=09=09=09\
> +=09return res;=09=09=09=09=09=09=09\
> +}
> +
> +/* Use this, if you are going to turn a [name] in the vlan struct on=
 or off
> */ +#define BATADV_ATTR_HIF_BOOL(_name, _mode, _post_func)=09=09=09\
> +=09static BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)=09=09\
> +=09static BATADV_ATTR_HIF_SHOW_BOOL(_name)=09=09=09=09\
> +=09static BATADV_ATTR_HIF(_name, _mode, batadv_show_hif_##_name,=09\=

> +=09=09=09       batadv_store_hif_##_name)
> +
>  static int batadv_store_bool_attr(char *buff, size_t count,
>  =09=09=09=09  struct net_device *net_dev,
>  =09=09=09=09  const char *attr_name, atomic_t *attr)
> @@ -844,10 +901,12 @@ static ssize_t batadv_show_iface_status(struct =
kobject
> *kobj, static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
> batadv_show_mesh_iface, batadv_store_mesh_iface);
>  static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, =
NULL);
> +BATADV_ATTR_HIF_BOOL(no_rebroadcast, S_IRUGO | S_IWUSR, NULL);
>=20
>  static struct batadv_attribute *batadv_batman_attrs[] =3D {
>  =09&batadv_attr_mesh_iface,
>  =09&batadv_attr_iface_status,
> +=09&batadv_attr_hif_no_rebroadcast,
>  =09NULL,
>  };
>=20
> diff --git a/types.h b/types.h
> index 8854c05..39619fb 100644
> --- a/types.h
> +++ b/types.h
> @@ -101,6 +101,7 @@ struct batadv_hard_iface {
>  =09struct batadv_hard_iface_bat_iv bat_iv;
>  =09struct work_struct cleanup_work;
>  =09struct dentry *debug_dir;
> +=09atomic_t no_rebroadcast;
>  };
>=20
>  /**

--nextPart1722026.Cn7dV6FaOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlVZo8oACgkQrzg/fFk7axb5lwCgw6lPh1ckGEHjgD+uxUu+NZbP
G8kAn2D3QVFH33C2BCY6fQfbBC+F8JgD
=EGJQ
-----END PGP SIGNATURE-----

--nextPart1722026.Cn7dV6FaOg--

