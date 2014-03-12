Return-Path: <rsc@pengutronix.de>
Date: Wed, 12 Mar 2014 15:25:07 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
Message-ID: <20140312142507.GO1629@pengutronix.de>
References: <20140310212525.GU24339@pengutronix.de>
 <201403121136.16430.sw@simonwunderlich.de>
 <20140312125329.GJ1629@pengutronix.de>
 <201403121451.09760.sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201403121451.09760.sw@simonwunderlich.de>
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

Hi Simon,

On Wed, Mar 12, 2014 at 02:51:09PM +0100, Simon Wunderlich wrote:
> Mhm, I'd generally recommend the Matthew Gast books on 802.11, these
> are very good.

Thanks, sounds good! Is "802.11 Wireless Networks: The Definitive Guide"
recent enough? Seems to be from 2005.

> The throughput limitation I'm talking about is a mesh-network specific problem 
> when you use single radios only: as a wifi radio can only transmit or receive 
> at the same time, the throughput will be cut to 50% with the first hop, and 
> will decrease furhter with more hops. I don't know if there are books about 
> such effects, but there are certainly papers ...

Will search.

Would having a 2nd transmitter help?

> > Can you give me a hint which feature I need to search for in the kernel
> > drivers?
> 
> ath9k supports that for example. you can set the txpower using "iw wlan0 set 
> txpower 1500" for example to set to 15dBm output pwoer

Thanks, txpower is a good hint.

> > As the stations will be built from scratch (SoC+RAM+Flash+Wifi-Chipset),
> > we can chose the right chipsets, as long as it's possible to buy them
> > somewhere.
> > 
> 
> I'd definitely recommend to buy WiFi modules (e.g. pci-e) or off-the-shelf 
> boards with WiFi SoCs on it. If you don't have experience in building WiFi 
> routers, you might have a lot of fun otherwise. :)

The issue is that the stations need to be very low power, so I'd like to
leave everything out which draws power but isn't absolutely needed. The
HF part should be solvable, that's something the hardware developers
have experience with. I'm aiming for a low power ARM cpu, which
basically rules out anything that needs PCIe and leaves us with SDIO or
USB for the connection of the transmitters.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
