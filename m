Return-Path: <linus.luessing@web.de>
Date: Mon, 23 Nov 2009 15:21:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091123142151.GA21537@Sellars>
References: <20091109190206.GA2642@Linus-Debian>
	<200911101834.41970.lindner_marek@yahoo.de>
	<20091112005149.GA2879@Linus-Debian>
	<87fx8fvhpg.fsf@trurl.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fx8fvhpg.fsf@trurl.pps.jussieu.fr>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

> > Hmm, yes, true, IPv6 does not support fragmentation at all...
> 
> It does, but it's done end-to-end, not at intermediate routers.  See
> Section 5 of RFC 2460.
Ah, ok, yes, you're right, forgot about the fragmentation header
in IPv6 :).

If BATMAN were just doing transparent link fragmentation towards
its neighbours as a "fall-back" mechanism despite header
compression, would it be better to also do something like
"aggregation"? So for example if we were receiving a packet of
1500 bytes, which does not fit through a bat0 interface with an MTU
of 1476, we could wait for a maximum of maybe 5ms for another
packet and send a packet fragment of (1476 - (fragmentation
information overhead)). A second packet fragment would be send with
the rest of the first and the beginning of the second packet.
Wouldn't that cause a lot less loss of throughput compared to
splitting it in two packets of equal size as done in fragmentation
in IPv4 (in fact, only the additonal fragmentation header
overhead of a couple of bytes, especially in lossy environments
like wifi, right?). Any concerns about such an approach?

Cheers, Linus
