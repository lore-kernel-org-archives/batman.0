Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 11:29:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161219102951.GK6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-4-linus.luessing@c0d3.blue>
 <1616382.Ux6hIh5e6R@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616382.Ux6hIh5e6R@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
 independent TVLV handler API
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

On Wed, Dec 14, 2016 at 03:50:38PM +0100, Sven Eckelmann wrote:
> On Donnerstag, 6. Oktober 2016 08:41:40 CET Linus Lüssing wrote:
> > @@ -1842,8 +1844,12 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
> >  
> >                 packet_pos = skb->data + ogm_offset;
> >                 ogm_packet = (struct batadv_ogm_packet *)packet_pos;
> > +
> > +               skb_set_network_header(skb, ogm_offset);
> >         }
> >  
> > +       skb_reset_network_header(skb);
> > +
> >         kfree_skb(skb);
> >         return NET_RX_SUCCESS;
> >  }
> 
> Why must we skb_reset_network_header before the kfree?

Technically, yes, there's no need for it.

Usually I would have prefered keeping the skb network header
pointer just after the ethernet header just like anything else on the
receive path does right now. Would be messy if you could never be
sure where that pointer actually points at.

On the other hand it was too convenient to use it here :).


What do you think about wrapping the WARN_ON, while loop and
skb_reset_network_header() into a new function with a functional,
non-modifying touch regarding the input skb?

Or do you think I should just remove the
skb_reset_network_header() here?
