Return-Path: <andrew@lunn.ch>
Date: Fri, 6 Apr 2012 09:17:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120406071729.GA10020@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120324081407.GA30000@ritirata.org>
	<20120324202117.GH5662@lunn.ch>
	<201204052311.09200.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201204052311.09200.lindner_marek@yahoo.de>
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

> > I have been thinking about this a bit more, and also about this bit of
> > code:
> > 
> > +       elp_packet = (struct batman_elp_packet
> > *)skb_push(hard_iface->elp_skb, +                                         
> >                BATMAN_ELP_HLEN); +       memset(elp_packet, 0,
> > BATMAN_ELP_HLEN);
> > +
> > +       elp_packet->header.packet_type = BAT_V_ELP;
> > +       elp_packet->header.version = COMPAT_VERSION;
> > +       elp_packet->header.ttl = 0;
> > 
> > Marek, what are your plans for COMPAT_VERSION? Will there be a
> > COMPAT_VERSION_IV and COMPAT_VERSION_V sometime soon?
> 

> Currently, that is not planned. We hoped to keep the compat numbers
> in sync across the various protocols. Otherwise we all could end up
> in compat hell.

Can they be kept in sync? I would assume that IV is becoming more and
more stable, with more effort going into V. So IV is less probable to
need an COMPAT increment than V. The three month kernel cycle helps
with the sync, but it would be a PITA to have to upgrade an entire IV
net because V have forced a COMPAT increment, but IV has not changed
and is compatible.

> > Maybe when registering a receive function, you can pass both the
> > packet_type and version. So a received ELP packet with
> > COMPAT_VERSION_IV would automatically get tossed away, and an ELP with
> > COMPAT_VERSION_V would get dispatched.
> 

> What would be the use case of ELP COMPAT_VERSION_IV vs ELP
> COMPAT_VERSION_V ?  BATMAN IV does not have ELP at all .. maybe I
> misunderstand ?

The COMPAT_VERSION effectively becomes an indicator of the protocol,
assuming they are different. However, this is the opposite to your
idea of keeping them in sync.

Since there would be no ELP registered for COMPAT_VERSION_IV, the
packet would be discarded by the dispatcher. However,
COMPACT_VERSION_V would register an ELP function and the dispatcher
would use it.

Making the dispatcher aware of these two dimensions, (MSG_Type,
Version), puts all the checking in one place and makes the individual
message handlers simpler.

Anyway, just an idea...

	Andrew
