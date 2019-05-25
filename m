Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 1/2] batman-adv: mcast: detect,
 distribute and maintain multicast router presence
Date: Sat, 25 May 2019 12:06:00 +0200
Message-ID: <259819773.qqnsgro9p8@sven-edge>
In-Reply-To: <20190507042004.4219-2-linus.luessing@c0d3.blue>
References: <20190507042004.4219-1-linus.luessing@c0d3.blue>
 <20190507042004.4219-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5219242.DDDBTUVtlx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart5219242.DDDBTUVtlx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 7 May 2019 06:20:03 CEST Linus L=FCssing wrote:
> +static u8 batadv_mcast_mla_rtr_flags_softif_get(struct batadv_priv *bat_=
priv,
> +                                               struct net_device *bridge)
> +{
> +       struct net_device *dev =3D bridge ? bridge : bat_priv->soft_iface;
> +       u8 flags =3D BATADV_NO_FLAGS;
> +       struct inet6_dev *in6_dev;
> +       struct in_device *in_dev;
> +
> +       rcu_read_lock();
> +       in_dev =3D __in_dev_get_rcu(dev);
> +       if (in_dev && IN_DEV_MFORWARD(in_dev))
> +               flags |=3D BATADV_MCAST_WANT_ALL_RTR4;
> +
> +       in6_dev =3D __in6_dev_get(dev);
> +       if (in6_dev && in6_dev->cnf.mc_forwarding)
> +               flags |=3D BATADV_MCAST_WANT_ALL_RTR6;
> +       rcu_read_unlock();
> +
> +       return flags;
> +}

=46ails to build on Linux 5.1 with:

/home/sven/tmp/qemu-batman/batman-adv/net/batman-adv/multicast.c: In functi=
on 'batadv_mcast_mla_rtr_flags_softif_get':
/home/sven/tmp/qemu-batman/batman-adv/net/batman-adv/multicast.c:130:30: er=
ror: 'struct ipv6_devconf' has no member named 'mc_forwarding'; did you mea=
n 'forwarding'?
  if (in6_dev && in6_dev->cnf.mc_forwarding)
                              ^~~~~~~~~~~~~
                              forwarding

See=20
https://git.open-mesh.org/build_test.git/blob/HEAD:/generate_linux_headers.=
sh=20
for the configuration.

Kind regards,
	Sven

--nextPart5219242.DDDBTUVtlx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpE4gACgkQXYcKB8Em
e0YEQhAAke9rLTiLs/15NDuZL67VwV8vheK98mfO0KvblDNWlD8UY+LkUpXKRWoK
pDADo+BccuwHyskDiYvMJpkQtUzqQH+OLrRSmZZGMykkcpE35i9BHfmdHL8N8QyN
BkWeRhlvY5G+rSzanCwfrMziD6oES+h4XHIkxIedkuzj9/xIjW+Lnb3oxp6b3Jma
BkC72+d5NnBkduapnq3T+1H+wMQTBx9XUkzwQjf3D+0wBktf0ACNuBUxaFTJvjgu
8jkny6DcCTwx9dcqT1nB1T0Bw60kDzY1xflKFS/JC2KoVirohpLSzjO+mnFa54X/
A7AJCuLHBt6MsplUrj32+UbXq8vRgRIjvHhWsd4wL4lgTIlgEZLtXYVYd9DeJq2R
6fAtWNXfTZB13/bfAWwPziQZEPkQ0+A13VOA/f0DEPucjw4vPQCwRf26uCP9F3b8
KKU85wa0YG50qA2TdSL88nUXYeesHbilvlFpl6HRf/QisjBQParcdNQHZkU3Lt1Y
9h1jQbjMU+BRC59pmknE6SVhzf+uDfoCA3tirODTuSPfUcgOb+T4oY83sWumsgpd
mSWEWiIXYDWEFWtBsmfKW6cV0QC12BXaAA5yaiKQZHAVWRA0boTfQwjpMmeltGKr
coow9omvjP0U63K4Kei+ervDD6tiNOP/CT1I+XLB9mmwL+3VAPg=
=fUqP
-----END PGP SIGNATURE-----

--nextPart5219242.DDDBTUVtlx--



