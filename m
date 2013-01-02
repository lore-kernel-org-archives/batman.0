Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 2 Jan 2013 19:44:21 +0800
References: <1355570082-19574-1-git-send-email-ordex@autistici.org>
 <201212261808.51135.lindner_marek@yahoo.de>
 <20130102074813.GB27589@ritirata.org>
In-Reply-To: <20130102074813.GB27589@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301021944.21367.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: postpone OGM preparation
	to sending time
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, January 02, 2013 15:48:13 Antonio Quartulli wrote:
> > > @@ -468,6 +442,7 @@ static void batadv_iv_ogm_aggregate(struct
> > > batadv_forw_packet *forw_packet_aggr, memcpy(skb_buff, packet_buff,
> > > packet_len);
> > > 
> > >  	forw_packet_aggr->packet_len += packet_len;
> > >  	forw_packet_aggr->num_packets++;
> > > 
> > > +	forw_packet_aggr->own |= own_packet;
> > > 
> > >  	/* save packet direct link flag status */
> > >  	if (direct_link) {
> > 
> > Using "|= own_packet" isn't strictly necessary because
> > "forw_packet_aggr->own" isn't a bit field.
> 
> Well the point is that here own_packet could be false, but
> forw_packet_aggr->own might already be true, so I didn't want to destroy
> the original value.

Good point. However, your "solution" is far from obvious. Either you make it 
more obvious or you should add a comment.


> > Did you vigorously test this code ? Especially, multi-node with multiple
> > interface setups are of interest. Also use different orig intervals to
> > ensure it still works everywhere.
> 
> I will try more topologies and in particular different orig intervals as
> soon as I have the possibility

Ok.


> > The thing is: Throughout the code you can find the implicite assumption
> > of the first aggregated packet being an "own packet" (if
> > forw_packet_aggr->own is set). Therefore, you have to be very careful
> > changing that logic. One function you definitely overlooked is
> > batadv_iv_ogm_send_to_if() but there might be others.

You did not comment this section. Hopefully it wasn't overlooked ?


> > > +/**
> > > + * batadv_iv_ogm_send - prepare an send an own OGM
> > > + * @work: kernel work struct
> > > + *
> > > + * Prepare the OGM and immediately enqueue it for sending
> > > + */
> > 
> > prepare and send an own OGM
> > 
> >         ^^^
> 
> well, technically it is enqueued, not sent..

Your kernel doc states:
batadv_iv_ogm_send - prepare an send an own OGM

Therefore I proposed a fix:
batadv_iv_ogm_send - prepare and send an own OGM

If you wish to reword it altogether that's also ok for me.

Cheers,
Marek
