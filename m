Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Feb 2016 16:57:38 +0100
Message-ID: <8270436.jm8W4bfGe2@sven-edge>
In-Reply-To: <3255100.5LmjYr8IdZ@sven-edge>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <3255100.5LmjYr8IdZ@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2510853.25Rl4SHXC2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/4] batman-adv: Add network name space
	support
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2510853.25Rl4SHXC2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 31 January 2016 14:26:27 Sven Eckelmann wrote:
[...]
> Just to let everybody know: This patchset will break batman-adv
> compatibility for kernels older than 4.0 (see
> d37512a277dfb2cef8a578e25a3246f61399a55a):
> 
> hard-interface.c:105:55: error: no member 'get_link_net' in struct
> rtnl_link_ops hard-interface.c:106:54: error: no member 'get_link_net' in
> struct rtnl_link_ops hard-interface.c:107:55: error: no member
> 'get_link_net' in struct rtnl_link_ops hard-interface.c:108:54: error: no
> member 'get_link_net' in struct rtnl_link_ops hard-interface.c:148:61:
> error: no member 'get_link_net' in struct rtnl_link_ops
> hard-interface.c:149:52: error: no member 'get_link_net' in struct
> rtnl_link_ops hard-interface.c: In function 'batadv_mutual_parents':
>     hard-interface.c:105:48: error: 'const struct rtnl_link_ops' has no
> member named 'get_link_net' if (dev1->rtnl_link_ops &&
> dev1->rtnl_link_ops->get_link_net) ^
>     hard-interface.c:106:40: error: 'const struct rtnl_link_ops' has no
> member named 'get_link_net' dev1_parent_net =
> dev1->rtnl_link_ops->get_link_net(dev1);
>                                             ^
>     hard-interface.c:107:48: error: 'const struct rtnl_link_ops' has no
> member named 'get_link_net' if (dev2->rtnl_link_ops &&
> dev2->rtnl_link_ops->get_link_net) ^
>     hard-interface.c:108:40: error: 'const struct rtnl_link_ops' has no
> member named 'get_link_net' dev2_parent_net =
> dev2->rtnl_link_ops->get_link_net(dev2);
>                                             ^
>     hard-interface.c: In function 'batadv_is_on_batman_iface':
>     hard-interface.c:148:54: error: 'const struct rtnl_link_ops' has no
> member named 'get_link_net' if (net_dev->rtnl_link_ops &&
> net_dev->rtnl_link_ops->get_link_net) ^
>     hard-interface.c:149:38: error: 'const struct rtnl_link_ops' has no
> member named 'get_link_net' parent_net =
> net_dev->rtnl_link_ops->get_link_net(net_dev); ^
>     make[2]: *** [hard-interface.o] Error 1
>     make[1]: *** [_module_] Error 2
>     make: *** [all] Error 2
> 
> (build stopped here and there may be a lot more problems)
> 
> And with 3.18 you will only get until (see
> 435d5f4bb2ccba3b791d9ef61d2590e30b8e806e):
> 
>     debugfs.c:87:40: error: no member 'ns' in struct net
>     debugfs.c:547:37: error: no member 'ns' in struct net
>     debugfs.c: In function 'batadv_debugfs_ns_get':
>     debugfs.c:87:26: error: 'struct net' has no member named 'ns'
>        sprintf(name, "%u", net->ns.inum);
>                               ^
>     debugfs.c: In function 'batadv_debugfs_init':
>     debugfs.c:547:30: error: 'struct net' has no member named 'ns'
>       sprintf(name, "%u", init_net.ns.inum);
>                                   ^
>     make[2]: *** [debugfs.o] Error 1
>     make[1]: *** [_module_] Error 2
>     make: *** [all] Error 2



On Friday 12 February 2016 16:25:36 Andrew Lunn wrote:
> But what about the netns case? This is mainly a backward compatible
> issue. It sounds like some of the older kernels you have via compat.h
> are going to have issues with netns support.

There is now more than compat.h. So maybe we can find a more complex way to 
work around the problem?

> What do the maintainers
> what to do about this? NACK my patches, drop support for some of the
> older kernels? Something else?

I personally don't be one of the maintainers but I see the reduction of 
supported kernel as being a significant problem. I am also for reducing the 
supported kernel in the near future but only to something like 3.2 (which 
should be the oldest not EOL kernel in some months). But reducing the 
compatibility to only 4.0-4.5 is is quite a cut. Especially when people like 
Andreas Pape still want to use 2.6.32 (bad idea btw.).

But even the OpenWrt trunk (3.18, 4.1, 4.3, 4.4) would be affected by this 
change. Maybe the OpenWrt case is not that problematic because someone could 
just apply some patches to get support for older kernels.

On the other hand, there are multiple people interested in this feature. So 
just NACKing them also would not be a good idea.

Kind regards,
	Sven
--nextPart2510853.25Rl4SHXC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWvgDyAAoJEF2HCgfBJntGKqEQANA/6CSj7x+KHfOvseaeBN0Z
EHhNyQxwV7ZIkvpnIt+8AWf7x5RkIiDScUD8+acravgyKEAmEW3Ib6Wf2oR0n8jn
6bLtN8+yTXla2k1qRlbxPMkvQDnwZCyvBEIABj1DYz6BZKCx/TfgkytshHoyKwe7
3pDMFB23LmbO7UQftzVjhNhLCZ9I9FpbGe1x+Za0CjZmSXHxp2maHlO4nQ7cZAUN
EiZNoEAm7F4bO62ch+IsWlAVna0Fh1V/X3J6dyOlUCV0Y8IhwpjpRvybIqEzNJOr
m9C8MToeMdc8RvWwJbeh+JaMoEtx6FqHKh6Q50zEuF85LG6GWI58fpEIMb5x1PmP
aiK9+s7Oypl78JPHfr/AzHJdiv/QMJ0K5S/r++ODwHYau+GtUVjuBrEiI/DidwpU
HS/3Iw8JZNNvz5/DgeMMokYzs+9Ke3UXLKT3AMQ6gWM7ontQdmMybrJRBV28Auc/
o6+RGoR6i8Ni9f0Z5GdSepC5fnSMSuivvDvhdZXfETtjU/+Nxwz3OzUdmrtZSMfc
qK6PEzrx4RMFNVBCXvDf1sKr3oVDFuTH+gZfbojYacBpp/jLqVIozQamaeBLoX2O
YfK3+6WZNQ0mJHD3P++aICNwxXhLvMkyiXIUU3EyRiU5WgE8qAnAVyQ8OXiCJPUx
sQgZKSLuhYBqymB2f1G2
=U28P
-----END PGP SIGNATURE-----

--nextPart2510853.25Rl4SHXC2--

