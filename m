Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 12 Mar 2014 14:51:09 +0100
References: <20140310212525.GU24339@pengutronix.de>
 <201403121136.16430.sw@simonwunderlich.de>
 <20140312125329.GJ1629@pengutronix.de>
In-Reply-To: <20140312125329.GJ1629@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201403121451.09760.sw@simonwunderlich.de>
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
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hey Robert,

> > > - Could the short distance be a problem?
> > 
> > well you have interference between the nodes and the typical
> > throughput limitations because of the half-duplex nature of WiFi. But
> > if you take that into consideration and don't expect the same
> > throughput as on a single link, 3-4 meter should be fine.
> 
> Do you have any good literature/link recommendation where I could learn
> more about the low level WiFi mechanics?
> 

Mhm, I'd generally recommend the Matthew Gast books on 802.11, these are very 
good.

The throughput limitation I'm talking about is a mesh-network specific problem 
when you use single radios only: as a wifi radio can only transmit or receive 
at the same time, the throughput will be cut to 50% with the first hop, and 
will decrease furhter with more hops. I don't know if there are books about 
such effects, but there are certainly papers ...

> > It also depends on what kind of data you will send (many industrial
> > applications use broadcast, for example).
> 
> Broadcast is not necessary, all traffic is generated somewhere on the
> line and sent out to the Gateway. The datasets are in the 500 KiB range,
> it could be UDP or TCP, not decided yet. But it's definitely unicast.

OK, then you can use high datarates too.

> > > - Is it possible to regulate the transmission power in order to avoid
> > > 
> > >   disturbance?
> > 
> > There are WiFi driver which allow that, yes.
> 
> Can you give me a hint which feature I need to search for in the kernel
> drivers?

ath9k supports that for example. you can set the txpower using "iw wlan0 set 
txpower 1500" for example to set to 15dBm output pwoer

> 
> As the stations will be built from scratch (SoC+RAM+Flash+Wifi-Chipset),
> we can chose the right chipsets, as long as it's possible to buy them
> somewhere.
> 

I'd definitely recommend to buy WiFi modules (e.g. pci-e) or off-the-shelf 
boards with WiFi SoCs on it. If you don't have experience in building WiFi 
routers, you might have a lot of fun otherwise. :)


> > However I'd recommend to keep it as it is and change the broadcast
> > rate to something higher (e.g. 18M or more) to force to only use good
> > links, even if they are a little shorter.
> 
> Ok. I'll setup a bunch of prototype devices in the first place anyway,
> so we can try it out then.
> 
> Thanks for the infos!

Good luck!
    Simon
