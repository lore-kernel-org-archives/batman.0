Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2016 11:11:32 +0200
Message-ID: <1872939.JCcrb9gEib@bentobox>
In-Reply-To: <1861048.i0QxsABPPD@bentobox>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <20160510000311.GJ5816@otheros> <1861048.i0QxsABPPD@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart81272898.dMVk1l7qSi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 0/4] Multicast optimizations for
	bridges
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

--nextPart81272898.dMVk1l7qSi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 10 May 2016 09:43:00 Sven Eckelmann wrote:
> > * linux/icmp6.h in multicast.c
> >   -> icmp6_hdr()
> > * linux/ipv6.h in multicast.c
> >   -> ipv6_hdr()
> > 
> > * net/addrconf.h in multicast.c
> >   -> ipv6_mc_check_mld()
> >   -> ipv6_addr_is_ll_all_nodes()
> > * net/ip.h in multicast.c
> >   -> ip_eth_mc_map()
> > * net/ipv6.h in multicast.c
> >   -> IPV6_ADDR_MC_SCOPE
> >   -> IPV6_ADDR_SCOPE_LINKLOCAL
> 
> Problem seems to be that your sources don't build at the moment. So most 
> likely you are missing some dependencies like CONFIG_INET (and maybe even 
> more).

I haven't checked all the included symbols (you should) but could it be that
BRIDGE + IPv6 is also a missing dependency? At least there are some parts 

 * { 0x18fb237a, __VMLINUX_SYMBOL_STR(netdev_master_upper_dev_get_rcu) },
 * { 0x65e57e43, __VMLINUX_SYMBOL_STR(br_multicast_list_adjacent) },
 * { 0x671d7cb3, __VMLINUX_SYMBOL_STR(ip_mc_check_igmp) },
 * { 0x10cfbe4f, __VMLINUX_SYMBOL_STR(br_multicast_has_querier_anywhere) },
 * { 0x1d18dce9, __VMLINUX_SYMBOL_STR(br_multicast_has_querier_adjacent) },
 * { 0xaf8ed45, __VMLINUX_SYMBOL_STR(ipv6_mc_check_mld) },

You can find all used symbols of a build module in net/batman-adv/batman-adv.mod.c

Kind regards,
	Sven
--nextPart81272898.dMVk1l7qSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMaXEAAoJEF2HCgfBJntGufAP/3tuKTEQL6Z5l1z4TVf1KpWU
q0RkELTMlvvJm/qrvN3D7bkLYH1vnTnPdUFE3YYnowCPtXIbbCzUwVFAVKUnbx3s
CNxUZi3ZhY+6BYSItB32uFSHBQMdieoi838cO22u2VNeE0JFDIqtrM7SQ+SnE0l7
0HPSU+qPhguajGY37NgUWo2RSAC5wJiH375EQ23GOXwhsK/R52uMlmt5uG+CyYg5
3haSpHORs2CcRQsa5nd7BRSqwk+hsxU9SEFD6si/bniR4sYg4/rX++NOmg2s1VcU
d1/Ez6Djpc31+E2i11Kgddn/m72jwGe0DKuDkZmS+6jUDsOwCEr4Iqc73RGgAJ7/
/SMya6kgz8Ew/tj9Ndb3H8RZBFiOQGI+Uv7sUfQRE3I9k5loULwDb+9aNPftOKOk
RtHP9gdmn5HpR1ocGzEDYv5OPtzSeSiZIkuzCZcczzTNQXRm0vqVi6fF1Q2lG0uq
dR3+MIbM8HM0GrMr65bvMLCJiBPM/64rOtjl+vqP3DfWhA4W6gmHGLt2qGXGHYen
Ntc1pnhteBYbIZZ1lv/JyIJTRoHKQllAP9y+KsjVl58D03cw3B8Wkv8ci+KAu/jj
/061l1/4evIX2K2sIJa3dUlqLFDDjwfS9RHb+eXijkp0l3QrZMdxkhyc85J7wsWR
vPAr3Zq0yRMvnAZAWafQ
=N/u+
-----END PGP SIGNATURE-----

--nextPart81272898.dMVk1l7qSi--

