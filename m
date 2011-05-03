Return-Path: <ordex@autistici.org>
Date: Tue, 3 May 2011 17:50:07 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110503155007.GA6649@ritirata.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110430084226.GM21883@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110430084226.GM21883@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
 announcement mechanismy
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

On sab, apr 30, 2011 at 10:42:26 +0200, Andrew Lunn wrote:
> >  	bat_dbg(DBG_BATMAN, bat_priv,
> >  		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
> > -		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
> > -		"TTL %d, V %d, IDF %d)\n",
> > +		"(from OG: %pM, via prev OG: %pM, seqno %d, ttvn %u, "
> > +		"crc %u, changes %u, td %d, TTL %d, V %d, IDF %d)\n",
> >  		ethhdr->h_source, if_incoming->net_dev->name,
> >  		if_incoming->net_dev->dev_addr, batman_packet->orig,
> >  		batman_packet->prev_sender, batman_packet->seqno,
> > -		batman_packet->tq, batman_packet->ttl, batman_packet->version,
> > +		batman_packet->tt_ver_num, batman_packet->tt_crc,
> > +		batman_packet->tt_num_changes, batman_packet->tq,
> > +		batman_packet->ttl, batman_packet->version,
> >  		has_directlink_flag);
> 
> I think this is the information bisect uses to look for routing loops
> etc. Do you plan to extend bisect to look for TT problems? Does it
> make sense to add a new DBG_TT which dumps the adds and removes in the
> OGM?
>   

I don't think we really need a new log "channel". Till now all the hna
operations were printed on DBG_ROUTE, so I think we could continue using
it..

The bisect TT extension is not currently planned, but at least it is now
supported :)

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
