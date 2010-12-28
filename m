Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Dec 2010 16:14:29 +0100
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
	<1292320696-11983-9-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-9-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201012281614.30476.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 08/10] batman-adv: Adding batman_if
	specific sysfs wrapper macros for UINT
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
Cc: Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@ascom.ch>

On Tuesday 14 December 2010 10:58:14 Linus L=C3=BCssing wrote:
> +#define BAT_ATTR_IF_STORE_UINT(_name, _min, _max, _post_func)          \
> +ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,    \
> +                            char *buff, size_t count)                  \
> +{                                                                      \
> +       struct net_device *net_dev =3D kobj_to_netdev(kobj);             =
 \
> +       struct batman_if *batman_if =3D get_batman_if_by_netdev(net_dev);=
 \
> +       return __store_uint_attr(buff, count, _min, _max, _post_func,   \
> +                                attr, &batman_if->_name, net_dev);     \
> +}
> +
> +#define BAT_ATTR_IF_SHOW_UINT(_name)                                   \
> +ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,     \
> +                           char *buff)                                 \
> +{                                                                      \
> +       struct net_device *net_dev =3D kobj_to_netdev(kobj);             =
 \
> +       struct batman_if *batman_if =3D get_batman_if_by_netdev(net_dev);=
 \
> +       return sprintf(buff, "%i\n", atomic_read(&batman_if->_name));   \
> +}    =20

get_batman_if_by_netdev() increases the batman_if refcount which is never=20
decreased. Check the other get_batman_if_by_netdev() calls in the same file=
 to=20
get an idea how to handle this,

Cheers,
Marek

