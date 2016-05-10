Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 10 May 2016 02:03:11 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160510000311.GJ5816@otheros>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <1811882.4NqUN7GsV2@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1811882.4NqUN7GsV2@sven-edge>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, May 05, 2016 at 11:15:28PM +0200, Sven Eckelmann wrote:
> On Thursday 05 May 2016 17:07:01 Linus Lüssing wrote:
> > This patchset can be found in the current linus/multicast-bridge
> > branch.
> 
> Please check the attached results of the daily build test scripts.

Thanks Sven!

Just wanted to note that there seem to be some false positives in
there.

"[net/batman-adv/multicast.c:1181]: (style) The function 'batadv_mcast_flags_seq_print_text' is never used."
-> used in debugfs.c


Also the header suggestions seem a bit unreliable to me,
the following removals are false positives, I think:

* header removals in compat-sources/*
  -> breaks compiling

* linux/icmp6.h in multicast.c
  -> icmp6_hdr()
* linux/ipv6.h in multicast.c
  -> ipv6_hdr()

* net/addrconf.h in multicast.c
  -> ipv6_mc_check_mld()
  -> ipv6_addr_is_ll_all_nodes()
* net/ip.h in multicast.c
  -> ip_eth_mc_map()
* net/ipv6.h in multicast.c
  -> IPV6_ADDR_MC_SCOPE
  -> IPV6_ADDR_SCOPE_LINKLOCAL

Moving the following includes upwards seems unnecessary:
* linux/if_bridge.h in multicast.c
* linux/igmp.h in multicast.c

The following removals seem correct \o/:
* linux/in6.h in multicast.c
* net/mld.h in multicast.c

Additionally, the following include seems to be missing but wasn't
caught by the scripts:
* net/if_inet6.h in multicast.c
  -> ipv6_eth_mc_map()


Let me know whether this seems about right. Or whether I am
missing #includes in my->head :).

Regards, Linus


PS: I also do not understand the sparse complaints regarding
ip_eth_mc_map(). The according include is currently there, seems
to compile fine.
