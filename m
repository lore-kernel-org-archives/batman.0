Return-Path: <andrew@lunn.ch>
Date: Sat, 24 Mar 2012 21:21:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120324202117.GH5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
	<1332453075-27999-2-git-send-email-lindner_marek@yahoo.de>
	<20120323212233.GG5662@lunn.ch>
	<20120324081407.GA30000@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120324081407.GA30000@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
 structures, updating LQs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Sat, Mar 24, 2012 at 09:14:08AM +0100, Antonio Quartulli wrote:
> On Fri, Mar 23, 2012 at 10:22:33 +0100, Andrew Lunn wrote:
> > > +static int bat_v_elp_packet_recv(struct sk_buff *skb,
> > > +				 struct hard_iface *if_incoming)
> > > +{
> > > +	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
> > > +	struct batman_elp_packet *elp_packet;
> > > +	struct hard_iface *primary_if;
> > > +	struct ethhdr *ethhdr;
> > > +	bool ret;
> > > +
> > > +	ret = check_management_packet(skb, if_incoming, BATMAN_ELP_HLEN);
> > > +	if (!ret)
> > > +		return NET_RX_DROP;
> > > +
> > > +	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
> > > +	 * that does not have B.A.T.M.A.N. V ELP enabled ? */
> > > +	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_v_ogm_emit)
> > > +		return NET_RX_DROP;
> > 
> > Hi Marek
> > 
> > I've not looked at the code, but i assume this can happen because
> > there is not a per algorithm receive handler? Maybe it makes sense to
> > have a receive handler in algo structure, which can handle per
> > algorithm receive functions? The common PDUs can be handled first and
> > then a call into the algo receive function made to dispatch algo
> > specific PDUs.
> 
> Does this mean that you want to support multiple algorithms at the
> same time?  I don't think it is a good idea..

I'm assuming the choice of algorithm is linked to the soft interface,
i.e, bat0 could be using a different algorithm to bat1. So i think
multiple algorithms are possible at the same time.

I have been thinking about this a bit more, and also about this bit of
code:

+       elp_packet = (struct batman_elp_packet *)skb_push(hard_iface->elp_skb,
+                                                         BATMAN_ELP_HLEN);
+       memset(elp_packet, 0, BATMAN_ELP_HLEN);
+
+       elp_packet->header.packet_type = BAT_V_ELP;
+       elp_packet->header.version = COMPAT_VERSION;
+       elp_packet->header.ttl = 0;

Marek, what are your plans for COMPAT_VERSION? Will there be a
COMPAT_VERSION_IV and COMPAT_VERSION_V sometime soon?

Maybe when registering a receive function, you can pass both the
packet_type and version. So a received ELP packet with
COMPAT_VERSION_IV would automatically get tossed away, and an ELP with
COMPAT_VERSION_V would get dispatched.

	 Andrew
