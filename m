Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 20 Jun 2016 19:58:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160620175803.GB16638@otheros>
References: <1465939183-17868-1-git-send-email-linus.luessing@c0d3.blue>
 <5707464.HeWq3LKJdl@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5707464.HeWq3LKJdl@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Introduce forward packet
 creation helper
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

On Sun, Jun 19, 2016 at 01:00:18PM +0200, Sven Eckelmann wrote:
> And I would have written it slightly different. I don't want to say that your
> way is worse or my version is better but just add a slightly different way
> into the discussion

Looks good to me, I like all your suggestions for
forw_packet_alloc() :).

> > @@ -478,20 +546,16 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
> >  	struct batadv_bcast_packet *bcast_packet;
> >  	struct sk_buff *newskb;
> >  
> > -	if (!batadv_atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
> > -		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > -			   "bcast packet queue full\n");
> > -		goto out;
> > -	}
> > -
> >  	primary_if = batadv_primary_if_get_selected(bat_priv);
> >  	if (!primary_if)
> > -		goto out_and_inc;
> > -
> > -	forw_packet = kmalloc(sizeof(*forw_packet), GFP_ATOMIC);
> > +		goto out;
> 
> I think you can return here directly
> 
> >  
> > +	forw_packet = batadv_forw_packet_alloc(primary_if, NULL,
> > +					       &bat_priv->bcast_queue_left,
> > +					       bat_priv);
> > +	batadv_hardif_put(primary_if);
> >  	if (!forw_packet)
> > -		goto out_and_inc;
> > +		goto out;
> 
> Same here

Regarding these two goto's, usually using a "return" directly instead of a
"goto out" is better, I agree. For these two cases I think I would
prefer keeping it that way, because it's not a simple return but a
return of a macro value. Having NETDEV_TX_OK and NETDEV_TX_BUSY
each only once in a function makes it easier to spot the good or
bad cases, I think?

Or maybe I could rename "out" and "packet_free" to "err" and
"err_packet_free" to make the error cases even more visible?

Regards, Linus
