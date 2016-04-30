Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Apr 2016 12:00:05 +0200
Message-ID: <1991019.ZB5CQeA6YM@sven-edge>
In-Reply-To: <1461970765-24615-3-git-send-email-andrew@lunn.ch>
References: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
 <1461970765-24615-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6833714.vP3YWErjoK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 02/12] batman-adv: compat.h: Add
	workaround for get_link_net()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart6833714.vP3YWErjoK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday 30 April 2016 00:59:15 Andrew Lunn wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  compat.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/compat.h b/compat.h
> index 5a5f478..f746163 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -137,9 +137,15 @@ static int __batadv_interface_kill_vid(struct
> net_device *dev, __be16 proto,\ #warning cfg80211 based throughput me=
tric
> is only supported with Linux 3.15+
>=20
>  #endif
> -
>  #endif /* < KERNEL_VERSION(3, 15, 0) */
>=20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
> +
> +/* WARNING for batadv_getlink_net */
> +#define get_link_net get_xstats_size || 1 ||
> netdev->rtnl_link_ops->get_xstats_size +
> +#endif /* < KERNEL_VERSION(4, 0, 0) */
> +
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
>=20
>  #define IFF_NO_QUEUE=090; dev->tx_queue_len =3D 0

This cannot work because you've modified the initial patch
and used parts of your old patch again.

    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c: In functio=
n =E2=80=98batadv_getlink_net=E2=80=99:
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:104:9: warn=
ing: return makes pointer from integer without a cast [-Wint-conversion=
]
      return netdev->rtnl_link_ops->get_link_net(netdev);
             ^
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c: In functio=
n =E2=80=98batadv_mutual_parents=E2=80=99:
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:131:26: war=
ning: suggest parentheses around =E2=80=98&&=E2=80=99 within =E2=80=98|=
|=E2=80=99 [-Wparentheses]
      if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
                              ^
    In file included from <command-line>:0:0:
    /qemu-batman/batman-adv/compat.h:151:46: error: =E2=80=98netdev=E2=80=
=99 undeclared (first use in this function)
     #define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops=
=2D>get_xstats_size
                                                  ^
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:131:50: not=
e: in expansion of macro =E2=80=98get_link_net=E2=80=99
      if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
                                                      ^
    /qemu-batman/batman-adv/compat.h:151:46: note: each undeclared iden=
tifier is reported only once for each function it appears in
     #define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops=
=2D>get_xstats_size
                                                  ^
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:131:50: not=
e: in expansion of macro =E2=80=98get_link_net=E2=80=99
      if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
                                                      ^
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:133:26: war=
ning: suggest parentheses around =E2=80=98&&=E2=80=99 within =E2=80=98|=
|=E2=80=99 [-Wparentheses]
      if (dev2->rtnl_link_ops && dev2->rtnl_link_ops->get_link_net)
                              ^
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c: In functio=
n =E2=80=98batadv_is_on_batman_iface=E2=80=99:
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:174:29: war=
ning: suggest parentheses around =E2=80=98&&=E2=80=99 within =E2=80=98|=
|=E2=80=99 [-Wparentheses]
      if (net_dev->rtnl_link_ops && net_dev->rtnl_link_ops->get_link_ne=
t)
                                 ^
    In file included from <command-line>:0:0:
    /qemu-batman/batman-adv/compat.h:151:46: error: =E2=80=98netdev=E2=80=
=99 undeclared (first use in this function)
     #define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops=
=2D>get_xstats_size
                                                  ^
    /qemu-batman/batman-adv/net/batman-adv/hard-interface.c:174:56: not=
e: in expansion of macro =E2=80=98get_link_net=E2=80=99
      if (net_dev->rtnl_link_ops && net_dev->rtnl_link_ops->get_link_ne=
t

Kind regards,
=09Sven
--nextPart6833714.vP3YWErjoK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXJIIlAAoJEF2HCgfBJntGWA4P/0i/0zTGYFkb4BSWIT4qb0M1
69qjro/kshGZcdcdK+Z3BAnuqNGtkRuHacvkoMwL/X/liW4ObIjMp/U9oOpUjo1T
rgx5uzUyZ08bPwBWlN+lNw9RaIXo6Sr40AKeh4U/T0e11a5nZ4hC3f5L2/icCu6K
7qwblADQrmssQy7XGIFVRxR9nWpirrkgzy/hoRy2PDenviypl6rv0limiZfw2xWR
3vE2V8Q+fNQb63DupkltWq0300JFw1BGrI2QfYhTFcNlGYj57sdJ+WNO6X8rF34J
K536oDzwfg/hWwJcFBUu0CnXjgHxfGrZ0SfnZybvsWrVJJixGiAZz8XtqaohkIVu
fAhAmeYrzYQb4Trqap9KilDvzYejCrElfN0Yb+7KvvLQ0MrI//R0jRtsaBH34w+E
O/NBZITjnTIis3/Uv8XYNaXgf9Xtnr59Qg/4q+vKT451BhwLSMEck5thj/fOv9HE
dRLni5+IoLAh7jy91skyfPYG1TQ0pV3cCN6TnZcONRCjlvZYpPVL+fmSOUan4r7g
e7YmF2vJuox7/SaW9IYL2i6zDaQvZM6oVasZSjhGyDAzHI/y6X6CIRUy90hI1PQN
6pOsc2qdICca31jPeSj8o5a0L1weU6qGBrbJUS32pqqhbcOS68drhOm7/OuBLuW8
pc9+ZgQc2k/6U+Gsc9rG
=HlFQ
-----END PGP SIGNATURE-----

--nextPart6833714.vP3YWErjoK--

