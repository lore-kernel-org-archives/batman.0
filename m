Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 28 Jun 2015 05:59:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150628035913.GB2398@odroid>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
 <1434893777-17618-2-git-send-email-linus.luessing@c0d3.blue>
 <2472003.5ybaWVxMcq@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2472003.5ybaWVxMcq@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/1] batman-adv: Always flood IGMP/MLD
 reports
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Jun 28, 2015 at 09:37:20AM +0800, Marek Lindner wrote:
> On Sunday, June 21, 2015 15:36:17 Linus Lüssing wrote:
> > With this patch IGMP or MLD reports are always flooded. This is
> > necessary for the upcoming bridge integration:
> > 
> > An IGMPv2/MLDv1 querier does not actively join the multicast group the
> > reports are sent to. Because of this, this would lead to snooping
> > bridges/switches not being able to learn of multicast listeners in the
> > mesh and wrongly shutting down ports for multicast traffic to the mesh,
> > leading to packet loss.
> 
> I am not quite clear on what the patch does. It helps to support a feature 
> that is yet to come (upcoming bridge integration) or improves the situation 
> today ?

The former. It's not fixing or improving anything for the current
implementation.

> 
> 
> >  /**
> >   * batadv_mcast_forw_mode_check - check for optimized forwarding potential
> > @@ -376,9 +434,11 @@ static int batadv_mcast_forw_mode_check(struct
> > batadv_priv *bat_priv, case ETH_P_IP:
> >  		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
> >  							 is_unsnoopable);
> > +#if IS_ENABLED(CONFIG_IPV6)
> >  	case ETH_P_IPV6:
> >  		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
> >  							 is_unsnoopable);
> > +#endif
> >  	default:
> >  		return -EINVAL;
> >  	}
> 
> This hunk seems not really related to the patch itself ?

I think it's necessary for the new ipv6_mc_check_mld() which isn't
there if building a kernel without any IPv6 support.

> 
> 
> >  /**
> > - * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv
> > container + * batadv_mcast_tvlv_ogm_handler_v2 - process incoming multicast
> > tvlv container * @bat_priv: the bat priv with all the soft interface
> > information * @orig: the orig_node of the ogm
> >   * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
> >   * @tvlv_value: tvlv buffer containing the multicast data
> >   * @tvlv_value_len: tvlv buffer length
> >   */
> > -static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
> > +static void batadv_mcast_tvlv_ogm_handler_v2(struct batadv_priv *bat_priv,
> >  					     struct batadv_orig_node *orig,
> >  					     u8 flags,
> >  					     void *tvlv_value,
> 
> By removing mcast v1 you effectively are breaking compatibility with all nodes 
> running v1 and require everyone to upgrade to v2.

No, no v1 nodes are required to upgrade. v1 and v2 nodes are still
able to communicate. v1 nodes (like any pre v1 node) might downgrade the mesh
to a mcast-optimizations-disabled state for now though, yes.

> Is there a good reason for that ? The multicast optimizations can't easily
> work with v1 and v2 ?
> 
> By reading your patch it does not become clear why v2 is needed in the first 
> place. The tvlv's content seems to be identical ?

We cannot safely use the multicast optimizations with bridges if
there are nodes which do not handle reports properly. The bump
isn't needed for any packet changes but the internal, local behaviour
of a node.

I haven't heard of anyone using the multicast optimization feature
in practice yet (that is, a setup without bridges), so I think it
is safe to do a version bump?

> 
> 
> > @@ -206,6 +206,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
> >  	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
> >  		goto dropped;
> > 
> > +	skb_set_network_header(skb, ETH_HLEN);
> > +
> >  	soft_iface->trans_start = jiffies;
> >  	vid = batadv_get_vid(skb, 0);
> >  	ethhdr = eth_hdr(skb);
> 
> Why is this change part of the patch ?

Hm, good question :). Need to recheck, I vaguely remember having
had issues with the IP header parsing due to unset skb network
headers.

> 
> Cheers,
> Marek
> 

Cheers, Linus
