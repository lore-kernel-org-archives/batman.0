Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 10 Oct 2010 12:34:19 +0200
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1767940.eSYfKxdvve";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010101234.20739.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Introduce generic
	BAT_ATTR_* macros
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

--nextPart1767940.eSYfKxdvve
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> +/* Use this, if you are going to turn a [name]_enabled in bat_priv on or
> off */ +#define BAT_ATTR_SWITCH(_name, _mode,
> _post_func)                      \ +static ssize_t store_##_name(struct
> kobject *kobj, struct attribute *attr, \ +                     char *buff,
> size_t count)                         \
> +{                                                                      \
> +       struct device *dev =3D to_dev(kobj->parent);                     =
 \
> +       struct net_device *net_dev =3D to_net_dev(dev);                  =
 \
> +       struct bat_priv *bat_priv =3D netdev_priv(net_dev);              =
 \
> +       void (*post_func)(struct net_device *) =3D _post_func;           =
 \
> +       int ret;                                                        \
> +       ret =3D store_switch_attr(buff, count, net_dev, (char *)attr->nam=
e,
> \ +                              =20
> &bat_priv->_name##_enabled);           \ +       if (post_func &&
> ret)                                           \
> +               post_func(net_dev);                                     \
> +       return ret;                                                     \
> +}                                                                      \
> +static ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,
> \ +                           char
> *buff)                                 \
> +{                                                                      \
> +       struct device *dev =3D to_dev(kobj->parent);                     =
 \
> +       struct bat_priv *bat_priv =3D netdev_priv(to_net_dev(dev));      =
 \
> +       return sprintf(buff, "%s\n",                                    \
> +                      atomic_read(&bat_priv->_name##_enabled) =3D=3D 0 ?=
   \
> +                      "disabled" : "enabled");                         \
> +}                                                                      \
> +BAT_ATTR(_name, _mode, show_##_name, store_##_name)

Please change the last line (and the similar line) to "static BAT_ATTR(...."

And yes, I like the idea to remove some redundancy.

Best regards,
	Sven

--nextPart1767940.eSYfKxdvve
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMsZarAAoJEF2HCgfBJntGKXYQAJto6R6PZNN7cSIfcLsZdtFR
rhP18TVgx8G3oUZQuTq3SSvGip7V2OUMIE6LVz+EhoNZlxJUazKzvasx3Iu0ad5h
YdXkdKwoESKurksMFhRxLJaASuwJxJ9r3KYTcjyzntpkj7Yez35R0xsvCVFOkBcX
LuNgA5LymNcwk1Mk4AF1oqjlZKo+bMX5hCbtab8OfQR+K7wI0cWP/at1apmtqIdN
tGu7ftVg+kaDd0+l0/ffsTgmO8pCIZ33jG10ui0/ve59JOtoXJBSVZgVSsN9eoUn
lXgjzV9Eyn+LSnIMAouJzX5nOnEAKmqEdNsFXPchwcwpqTGYnzDF78oHKzyK8Ev5
9SpChcq8v7v31sDHd7FYUd6arzlQXzVZnrX/U6uvW75+81wIp/hQIToSxd052Mv9
WkKIF37GgUzoxkbx7b9WPgoqgFRYMVjCNrfuE5Miyz7PgYsgzJa7bTv+83syDNeM
zIvL/+WWFa69LFpDdWPCaRpmrpLsHs7lTXDMrV6IX+V94IpXGU60fm2v+ht7pa2g
pJMxoA181kj/2ZbaHCelxqumhGw5mq6dbcoUJtkHrKKt2rW0uWL0RIl/jffEpCwU
7fehAxnkPI5F6Wo0G8HKO4kN+CJNl2Nvli8SUYQDXHTMe97CZCZQZ1QfTdIDHGAb
fp3aA8GaoAiKhWzWe4aI
=GZac
-----END PGP SIGNATURE-----

--nextPart1767940.eSYfKxdvve--
