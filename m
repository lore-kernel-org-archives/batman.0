Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/3] batman-adv: mcast: collect softif listeners from
 IP lists instead
Date: Sat, 25 May 2019 13:40:11 +0200
Message-ID: <1915041.aIAeFaJ9db@sven-edge>
In-Reply-To: <20190507034824.3362-3-tux@c0d3.blue>
References: <20190507034824.3362-1-tux@c0d3.blue>
 <20190507034824.3362-3-tux@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2392286.jWkxezyonI";
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

--nextPart2392286.jWkxezyonI
Content-Type: multipart/mixed; boundary="nextPart1947738.zRIKLu7hdR"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1947738.zRIKLu7hdR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 7 May 2019 05:48:23 CEST T_X wrote:
[..]
> Instead of collecting multicast MAC addresses from the netdev hw mc
> list collect a node's multicast listeners from the IP lists and convert
> those to MAC addresses.
>=20
> This allows to exclude addresses of specific scope later. On a
> multicast MAC address the IP destination scope is not visible anymore.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

There are various build problems. See attachment.

Kind regards,
	Sven
--nextPart1947738.zRIKLu7hdR
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: kbuild test robot <lkp@intel.com>: [batman:batadv/net-next 7/7] net/batman-adv/multicast.c:446:55: error: 'union <anonymous>' has no member named 'ip6'; did you mean 'ip4'?

Return-Path: <lkp@intel.com>
Delivered-To: sven@narfation.org
Received: from narfation.org ([2001:4d88:2000:7::2]:993) by sven-atom.home.narfation.org with IMAP4-SSL for <sven@narfation.org>; 25 May 2019 11:35:10 -0000
X-Original-To: sven@narfation.org
Delivered-To: sven@narfation.org
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24]) by v3-1039.vlinux.de (Postfix) with ESMTPS id 1492C1100D9 for <sven@narfation.org>; Sat, 25 May 2019 13:35:05 +0200 (CEST)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26]) by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 May 2019 04:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,510,1549958400"; d="gz'50?scan'50,208,50";a="178176569"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150]) by fmsmga002.fm.intel.com with ESMTP; 25 May 2019 04:35:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89) (envelope-from <lkp@intel.com>) id 1hUUx1-000Gtx-ST; Sat, 25 May 2019 19:34:59 +0800
Date: Sat, 25 May 2019 19:34:31 +0800
From: kbuild test robot <lkp@intel.com>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: kbuild-all@01.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>
Subject: [batman:batadv/net-next 7/7] net/batman-adv/multicast.c:446:55: error: 'union <anonymous>' has no member named 'ip6'; did you mean 'ip4'?
Message-ID: <201905251929.NrJynIWG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-getmail-filter-classifier: fd[10]: OK

 

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

tree:   git://git.open-mesh.org/linux-merge batadv/net-next
head:   5e8230d96b966a3691f83e2b053798487725353e
commit: 5e8230d96b966a3691f83e2b053798487725353e [7/7] batman-adv: mcast: avoid redundant multicast TT entries with bridges
config: x86_64-randconfig-x008-201920 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 5e8230d96b966a3691f83e2b053798487725353e
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/batman-adv/multicast.c: In function 'batadv_mcast_mla_softif_get':
   net/batman-adv/multicast.c:362:42: error: passing argument 1 of 'batadv_mcast_mla_softif_get_ipv6' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret6 = batadv_mcast_mla_softif_get_ipv6(dev, mcast_list, flags);
                                             ^~~
   net/batman-adv/multicast.c:320:1: note: expected 'struct batadv_priv *' but argument is of type 'struct net_device *'
    batadv_mcast_mla_softif_get_ipv6(struct batadv_priv *bat_priv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/batman-adv/multicast.c:362:47: error: passing argument 2 of 'batadv_mcast_mla_softif_get_ipv6' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret6 = batadv_mcast_mla_softif_get_ipv6(dev, mcast_list, flags);
                                                  ^~~~~~~~~~
   net/batman-adv/multicast.c:320:1: note: expected 'struct net_device *' but argument is of type 'struct hlist_head *'
    batadv_mcast_mla_softif_get_ipv6(struct batadv_priv *bat_priv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/batman-adv/multicast.c:362:59: error: passing argument 3 of 'batadv_mcast_mla_softif_get_ipv6' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret6 = batadv_mcast_mla_softif_get_ipv6(dev, mcast_list, flags);
                                                              ^~~~~
   net/batman-adv/multicast.c:320:1: note: expected 'struct hlist_head *' but argument is of type 'struct batadv_mcast_mla_flags *'
    batadv_mcast_mla_softif_get_ipv6(struct batadv_priv *bat_priv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/batman-adv/multicast.c: In function 'batadv_mcast_mla_bridge_get':
>> net/batman-adv/multicast.c:446:55: error: 'union <anonymous>' has no member named 'ip6'; did you mean 'ip4'?
           ipv6_addr_is_ll_all_nodes(&br_ip_entry->addr.u.ip6))
                                                          ^~~
                                                          ip4
   cc1: some warnings being treated as errors

vim +446 net/batman-adv/multicast.c

   327	
   328	/**
   329	 * batadv_mcast_mla_softif_get() - get softif multicast listeners
   330	 * @dev: the device to collect multicast addresses from
   331	 * @mcast_list: a list to put found addresses into
   332	 * @flags: flags indicating the new multicast state
   333	 *
   334	 * Collects multicast addresses of multicast listeners residing
   335	 * on this kernel on the given soft interface, dev, in
   336	 * the given mcast_list. In general, multicast listeners provided by
   337	 * your multicast receiving applications run directly on this node.
   338	 *
   339	 * If there is a bridge interface on top of dev, collects from that one
   340	 * instead. Just like with IP addresses and routes, multicast listeners
   341	 * will(/should) register to the bridge interface instead of an
   342	 * enslaved bat0.
   343	 *
   344	 * Return: -ENOMEM on memory allocation error or the number of
   345	 * items added to the mcast_list otherwise.
   346	 */
   347	static int
   348	batadv_mcast_mla_softif_get(struct net_device *dev,
   349				    struct hlist_head *mcast_list,
   350				    struct batadv_mcast_mla_flags *flags)
   351	{
   352		struct net_device *bridge = batadv_mcast_get_bridge(dev);
   353		int ret4, ret6 = 0;
   354	
   355		if (bridge)
   356			dev = bridge;
   357	
   358		ret4 = batadv_mcast_mla_softif_get_ipv4(dev, mcast_list, flags);
   359		if (ret4 < 0)
   360			goto out;
   361	
 > 362		ret6 = batadv_mcast_mla_softif_get_ipv6(dev, mcast_list, flags);
   363		if (ret6 < 0) {
   364			ret4 = 0;
   365			goto out;
   366		}
   367	
   368	out:
   369		if (bridge)
   370			dev_put(bridge);
   371	
   372		return ret4 + ret6;
   373	}
   374	
   375	/**
   376	 * batadv_mcast_mla_br_addr_cpy() - copy a bridge multicast address
   377	 * @dst: destination to write to - a multicast MAC address
   378	 * @src: source to read from - a multicast IP address
   379	 *
   380	 * Converts a given multicast IPv4/IPv6 address from a bridge
   381	 * to its matching multicast MAC address and copies it into the given
   382	 * destination buffer.
   383	 *
   384	 * Caller needs to make sure the destination buffer can hold
   385	 * at least ETH_ALEN bytes.
   386	 */
   387	static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
   388	{
   389		if (src->proto == htons(ETH_P_IP))
   390			ip_eth_mc_map(src->u.ip4, dst);
   391	#if IS_ENABLED(CONFIG_IPV6)
   392		else if (src->proto == htons(ETH_P_IPV6))
   393			ipv6_eth_mc_map(&src->u.ip6, dst);
   394	#endif
   395		else
   396			eth_zero_addr(dst);
   397	}
   398	
   399	/**
   400	 * batadv_mcast_mla_bridge_get() - get bridged-in multicast listeners
   401	 * @dev: a bridge slave whose bridge to collect multicast addresses from
   402	 * @mcast_list: a list to put found addresses into
   403	 * @flags: flags indicating the new multicast state
   404	 *
   405	 * Collects multicast addresses of multicast listeners residing
   406	 * on foreign, non-mesh devices which we gave access to our mesh via
   407	 * a bridge on top of the given soft interface, dev, in the given
   408	 * mcast_list.
   409	 *
   410	 * Return: -ENOMEM on memory allocation error or the number of
   411	 * items added to the mcast_list otherwise.
   412	 */
   413	static int batadv_mcast_mla_bridge_get(struct net_device *dev,
   414					       struct hlist_head *mcast_list,
   415					       struct batadv_mcast_mla_flags *flags)
   416	{
   417		struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
   418		struct br_ip_list *br_ip_entry, *tmp;
   419		u8 tvlv_flags = flags->tvlv_flags;
   420		struct batadv_hw_addr *new;
   421		u8 mcast_addr[ETH_ALEN];
   422		int ret;
   423	
   424		/* we don't need to detect these devices/listeners, the IGMP/MLD
   425		 * snooping code of the Linux bridge already does that for us
   426		 */
   427		ret = br_multicast_list_adjacent(dev, &bridge_mcast_list);
   428		if (ret < 0)
   429			goto out;
   430	
   431		list_for_each_entry(br_ip_entry, &bridge_mcast_list, list) {
   432			if (br_ip_entry->addr.proto == htons(ETH_P_IP)) {
   433				if (tvlv_flags & BATADV_MCAST_WANT_ALL_IPV4)
   434					continue;
   435	
   436				if (tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
   437				    ipv4_is_local_multicast(br_ip_entry->addr.u.ip4))
   438					continue;
   439			}
   440	
   441			if (br_ip_entry->addr.proto == htons(ETH_P_IPV6)) {
   442				if (tvlv_flags & BATADV_MCAST_WANT_ALL_IPV6)
   443					continue;
   444	
   445				if (tvlv_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES &&
 > 446				    ipv6_addr_is_ll_all_nodes(&br_ip_entry->addr.u.ip6))
   447					continue;
   448			}
   449	
   450			batadv_mcast_mla_br_addr_cpy(mcast_addr, &br_ip_entry->addr);
   451			if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
   452				continue;
   453	
   454			new = kmalloc(sizeof(*new), GFP_ATOMIC);
   455			if (!new) {
   456				ret = -ENOMEM;
   457				break;
   458			}
   459	
   460			ether_addr_copy(new->addr, mcast_addr);
   461			hlist_add_head(&new->list, mcast_list);
   462		}
   463	
   464	out:
   465		list_for_each_entry_safe(br_ip_entry, tmp, &bridge_mcast_list, list) {
   466			list_del(&br_ip_entry->list);
   467			kfree(br_ip_entry);
   468		}
   469	
   470		return ret;
   471	}
   472	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
N/9e4Ce7aq/o39ZmSr48cwIA

--LQksG6bCIzRHxTLp--

--nextPart1947738.zRIKLu7hdR--

--nextPart2392286.jWkxezyonI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpKZsACgkQXYcKB8Em
e0ZaABAAhIuDdV4Buj6dIrNnYVT4/T3r+cdcehYicFPorgONFqGSgcRFk0FWFJ1O
PStHcK87sdx5Sxx2iLtAjYSp1yu/bV91vgrrN8XXHjzMcJ+zZ3KCNPykf7Kgqcoy
z/nbUTQjLEcI/Uu0IfLYuXqgPTzC/CDcJokhvK3mbIsuEURhrDaH1LSrWvEs1Had
SYjzLPgAj1Ff0i/09xN2Gv209SJlgwIbGQ4XyhULlITDtRRquZwOzJnUTeMPNd6n
dEbVK3byA5aorgKi9LKkP3uz/CI+Frqt+iw/UakYOdIBHg8RCG0jH7YjYl/92wnx
pZUNbYsBxPAtOztLNRldj6/fyCdmcrtfLTYnlsNafsh1hoQ9A3VkBlFAkejRdYtE
vYkrVcsyuGp9hWH+eJDRdr8T3T7dIlaAe/2JSryLgfA9Qfagy2P36A/OhDdCWcKZ
EQcW1Y4SkRY33nx34Rnnxzr5q205EDMGGpiAnOIfYiGDgPzdAIsISK4mNlpEYm01
2MqCKSeHg6qdSu6FavLmJN5h/16IAIvCwgg7LUJ29X9QOFwt6qTv6GNVnO1RB3TW
ys+U92MmfRunU0hxaZJEfWqx3sZkqvqta9DcmXwV6Pb3E0JRc3JSnGfov86hczYw
AliaGXU1lzyePM3ucXDtM6SExv9nXtXuObLfwo9WJlrMgkn8Zek=
=Yxe+
-----END PGP SIGNATURE-----

--nextPart2392286.jWkxezyonI--



