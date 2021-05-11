Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 11 May 2021 13:28:54 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [net-next v2 09/11] net: bridge: mcast: split multicast router
 state for IPv4 and IPv6
Message-ID: <20210511112854.GA2222@otheros>
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-10-linus.luessing@c0d3.blue>
 <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:29:41PM +0300, Nikolay Aleksandrov wrote:
> [...]
> > -static void br_multicast_mark_router(struct net_bridge *br,
> > -				     struct net_bridge_port *port)
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +struct hlist_node *
> > +br_ip6_multicast_get_rport_slot(struct net_bridge *br, struct net_bridge_port *port)
> > +{
> > +	struct hlist_node *slot = NULL;
> > +	struct net_bridge_port *p;
> > +
> > +	hlist_for_each_entry(p, &br->ip6_mc_router_list, ip6_rlist) {
> > +		if ((unsigned long)port >= (unsigned long)p)
> > +			break;
> > +		slot = &p->ip6_rlist;
> > +	}
> > +
> > +	return slot;
> > +}
> 
> The ip4/ip6 get_rport_slot functions are identical, why not add a list pointer
> and use one function ?

Hi Nikolay,

Thanks for all the feedback and reviewing again! I'll
remove (most of) the inlines as the router list modifications are
not in the fast path.

For the get_rport_slot functions, maybe I'm missing a simple
solution. Note that "ip6_rlist" in hlist_for_each_entry() is not a
pointer but will be expanded by the macro. I currently don't see
how I could solve this with just one hlist_for_each_entry().

Regards, Linus
