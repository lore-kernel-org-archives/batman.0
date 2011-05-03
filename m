Return-Path: <ordex@autistici.org>
Date: Tue, 3 May 2011 19:07:11 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110503170710.GB6649@ritirata.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<20110430084226.GM21883@lunn.ch>
	<20110503155007.GA6649@ritirata.org>
	<201105031756.45985.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201105031756.45985.lindner_marek@yahoo.de>
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

On Tue, May 03, 2011 at 05:56:45PM +0200, Marek Lindner wrote:
> On Tuesday 03 May 2011 17:50:07 Antonio Quartulli wrote:
> > > I think this is the information bisect uses to look for routing loops
> > > etc. Do you plan to extend bisect to look for TT problems? Does it
> > > make sense to add a new DBG_TT which dumps the adds and removes in the
> > > OGM?
> > >
> > >   
> > 
> > I don't think we really need a new log "channel". Till now all the hna
> > operations were printed on DBG_ROUTE, so I think we could continue using
> > it..
> 
> Actually, I liked Andrew's suggestion. So far the HNA handling did not have 
> its own debug "channel" because it was plain simple - nothing much to debug 
> there. The advanced handling we are going to add might require debugging in 
> the future ...
> 
> Even if you don't plan to extend bisect at the moment, extra TT debug info 
> would make it easier to add it later on. I'd be surprised if the current 
> concept / code "just works". Bugs tend to hide in unexpected places.  ;-)
> 

Definitely :)

At this point I think it is better to introduce this new log "channel":
BAT_TT. I'll redirect all the TT related messages to this new channel.

Thank you

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
