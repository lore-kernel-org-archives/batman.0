Return-Path: <rsc@pengutronix.de>
Date: Wed, 12 Mar 2014 13:53:29 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
Message-ID: <20140312125329.GJ1629@pengutronix.de>
References: <20140310212525.GU24339@pengutronix.de>
 <201403121136.16430.sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201403121136.16430.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Line of Nodes
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Mar 12, 2014 at 11:36:16AM +0100, Simon Wunderlich wrote:
> >   Gateway - A1 - A2 - A3 - A4 - A5 - ... - A120
> >   Gateway - A9 - A17 - A1 - A47 - A9 - ... - A6
> > [...]
> > 
> > - What do you think, could B.A.T.M.A.N be a solution?
> 
> Yes, BATMAN could help in this situation - its better than doing it
> statically at least, since batman can decide how many intermediate
> hops to skip.

That's what I hoped.

> > - Could the short distance be a problem?
> 
> well you have interference between the nodes and the typical
> throughput limitations because of the half-duplex nature of WiFi. But
> if you take that into consideration and don't expect the same
> throughput as on a single link, 3-4 meter should be fine.

Do you have any good literature/link recommendation where I could learn
more about the low level WiFi mechanics?

> It also depends on what kind of data you will send (many industrial 
> applications use broadcast, for example).

Broadcast is not necessary, all traffic is generated somewhere on the
line and sent out to the Gateway. The datasets are in the 500 KiB range,
it could be UDP or TCP, not decided yet. But it's definitely unicast.

> > - Is it possible to regulate the transmission power in order to avoid
> >   disturbance?
> 
> There are WiFi driver which allow that, yes.

Can you give me a hint which feature I need to search for in the kernel
drivers?

As the stations will be built from scratch (SoC+RAM+Flash+Wifi-Chipset),
we can chose the right chipsets, as long as it's possible to buy them
somewhere.

> However I'd recommend to keep it as it is and change the broadcast
> rate to something higher (e.g. 18M or more) to force to only use good
> links, even if they are a little shorter.

Ok. I'll setup a bunch of prototype devices in the first place anyway,
so we can try it out then.

Thanks for the infos!

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
