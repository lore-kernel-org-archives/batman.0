Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 20:38:10 +0800
Message-ID: <3044505.BN7NZDCpey@diderot>
In-Reply-To: <1419594103-10928-6-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-6-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1663686.2gNivnJ74Z";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 05/26] batman-adv: init,
	Add some error handling
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1663686.2gNivnJ74Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:22 Markus Pargmann wrote:
>  static int __init batadv_init(void)
>  {
> +       int ret;
> +
>         INIT_LIST_HEAD(&batadv_hardif_list);
>         INIT_HLIST_HEAD(&batadv_algo_list);
>  
>         batadv_recv_handler_init();
>  
> -       batadv_iv_init();
> -       batadv_nc_init();
> +       ret = batadv_iv_init();
> +       if (ret)
> +               return ret;
> +
> +       ret = batadv_nc_init();
> +       if (ret)
> +               return ret;
>  
>         batadv_event_workqueue =
> create_singlethread_workqueue("bat_events"); -
>         if (!batadv_event_workqueue)
>                 return -ENOMEM;
>  
>         batadv_socket_init();
>         batadv_debugfs_init();
>  
> -       register_netdevice_notifier(&batadv_hard_if_notifier);
> -       rtnl_link_register(&batadv_link_ops);
> +       ret = register_netdevice_notifier(&batadv_hard_if_notifier);
> +       if (ret)
> +               goto err_netdev_notifier;
> +
> +       ret = rtnl_link_register(&batadv_link_ops);
> +       if (ret)
> +               goto err_link_register;
>  
>         pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i)
> loaded\n", BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
>  
>         return 0;
> +
> +err_link_register:
> +       unregister_netdevice_notifier(&batadv_hard_if_notifier);
> +err_netdev_notifier:
> +       batadv_debugfs_destroy();
> +
> +       return ret;
>  }

To be truely clean, I guess the workqueue should be destroyed as well ?

Cheers,
Marek

--nextPart1663686.2gNivnJ74Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUsm6yAAoJEFNVTo/uthzAEKgH/0vG8gJiYwGBZXIRKHIJbeCO
3VbM174d0uraWgeefg7e047aBKBDNmK1+4HuvkayWGI+u3Eq59eGPYXHI62Qt5Yd
hmfeh4iQcByuPK5sqczIjlp1Vfb+b27BpbOuZb3y15HKHoYMcW3/K1PhjxLwS8Xw
X17VGR23BD5J3ZSwpkvMKLtFZTZKljt6c1wv/ZK6wDGVweKAErV0t2Am7sv1h1uv
VsoEGBmRfKiH3tn93hwWFZrV3Q8RvLDztyYZTSnGu8NQnpXQv4gacr2tiLY4yUZZ
kXXLnt5F8uP3Vh/8/U2kwhN2OZlfoVAg+gKEcobo/yi9F/evKMJSz8yrYa6ABIg=
=IX68
-----END PGP SIGNATURE-----

--nextPart1663686.2gNivnJ74Z--

