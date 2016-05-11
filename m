Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 11 May 2016 09:29:22 +0200
Message-ID: <16078999.daXBnunon6@bentobox>
In-Reply-To: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
References: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6936027.HqzrhpT0mj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: init ELP tweaking options
	only once
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart6936027.HqzrhpT0mj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 10 May 2016 22:31:59 Marek Lindner wrote:
> The ELP interval and throughput override interface settings are initialized
> with default settings on every time an interface is added to a mesh.
> This patch prevents this behavior by moving the configuration init to the
> interface detection routine which runs only once per interface.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
[...]
> index db2009d..dd6a5a2 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -683,6 +683,13 @@ batadv_hardif_add_interface(struct net_device *net_dev)
>  	if (batadv_is_wifi_netdev(net_dev))
>  		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
>  
> +	/* enable link throughput auto-detection by setting the throughput
> +	 * override to zero
> +	 */
> +	atomic_set(&hard_iface->bat_v.throughput_override, 0);
> +
> +	atomic_set(&hard_iface->bat_v.elp_interval, 500);
> +
>  	/* extra reference for return */
>  	kref_init(&hard_iface->refcount);
>  	kref_get(&hard_iface->refcount);
> 

This needs to check if BATMAN_V is enabled:

    /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:689:31: error: no member 'bat_v' in struct batadv_hard_iface
    /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:691:31: error: no member 'bat_v' in struct batadv_hard_iface
    /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c: In function 'batadv_hardif_add_interface':
    /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:689:24: error: 'struct batadv_hard_iface' has no member named 'bat_v'
      atomic_set(&hard_iface->bat_v.throughput_override, 0);
                            ^
    /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:691:24: error: 'struct batadv_hard_iface' has no member named 'bat_v'
      atomic_set(&hard_iface->bat_v.elp_interval, 500);
                            ^
    make[2]: *** [/home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.o] Error 1
    make[1]: *** [_module_/home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv] Error 2
    make: *** [all] Error 2

This report was brought to you by todays build test [1] - the leading provider
of "omg, batman-adv doesn't build cleanly"

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/linux-merge/2016-May/003168.html

--nextPart6936027.HqzrhpT0mj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMt9SAAoJEF2HCgfBJntGVB8P/i7bAHRaJJv/4K4FzZM5mUkb
iBaddMS5Qc0kxgX009iAK0LTJ6O4D0++n2RCVJwC0HrXLMHP2bTCAcMR2OfKoHy8
hjBjXBTNLmRAWJTg+ca89Gw5Q1uZiKYIViBi3MONDk17ZQ0oBTaJQQJiza6HC1td
CAkamBYG8LsoHcE2oFB4MrqSahFeHaiEBkReaGV9VAL59LD2qHD2KuXYX94rNe+e
uhfEK39u99oenheHfgEy5ph4/GkTK6egX+AOWungYSrsM/DCfTwvLH2suXq2+Rvs
CE5bMq/bhr7Tl49mTxxwQYLgzO4A39PDS0wGZldDTgbdcGqWfk4tNPn3Jm7vUM30
WKCkcCWVi0t63sQ9t+F70xZsVdcxJ7gtQWwUpfn6Ue8SLECW4tC0o+mns8zjThMU
f91AM0djuQo+/WykJ46aqwmUkXDJO90HiYhybxOgZAMbaSIx1QD/7vtN+OrQwrDG
WYAMIWbXvDOEwUYoj5kf3OXac0IXaJ5xcl/SmDZHRNfUoyqKP/6WYGrdnFi+h2jM
+A3ViSIsEYKgJ6E1zxpzWIHnOu4NOvi3dbLBnBzqMvErqq70loS4Lp/3ex++zLd4
NnsyV5XwV+R87r1lNQYqgC/o5SmzfA++i3BGEAPASNgpq/NTEngwWfVzvMhZ92K2
UL2DJ2/bOweYXuF7gtGN
=+Zrv
-----END PGP SIGNATURE-----

--nextPart6936027.HqzrhpT0mj--

