Return-Path: <andrew@lunn.ch>
Date: Fri, 14 Feb 2014 18:38:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140214173841.GH17451@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch> <52FCA639.9080204@meshcoding.com>
 <20140213114449.GI7193@lunn.ch> <52FDD2CB.70104@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FDD2CB.70104@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
 determine link characteristics
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> Hi Andrew,
> 
> This morning I've been trying to dig into the tg3 Ethernet driver to get
> an idea of what happens before the NETDEV_UP event is fired.
> 
> The network stack invokes the ndo_open() callback implemented by the
> driver and, as far as I can see, this function does not return until
> having set speed and half/full_duplex state.
> Thus it looks like that when NETDEV_UP is fired the speed and the
> full_duplex attribute have already a meaningful value.
> 
> Of course this may vary depending on the driver, so this may not be the
> case everywhere.

Hi Antonio

I just looked at mv643xx_eth.c, the ethernet driver for my NAS box.
Its ndo_open() function calls phy_start(), but does not wait around
for the auto-negotiation to complete.

I hacked together a quick test.

#!/bin/bash
ifconfig eth0 down
sleep 2
ifconfig eth0 up
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed
sleep 0.5
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed
sleep 0.5
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed
sleep 0.5
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed
sleep 0.5
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed
sleep 0.5
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed
sleep 0.5
cat /sys/class/net/eth0/duplex
cat /sys/class/net/eth0/speed

Which when run gives:

half
1000
half
1000
half
1000
half
1000
half
1000
half
1000
full
1000

So it is taking 3 seconds after ifconfig returns before it has the
right duplex mode.

> I think that your NAS might also be a good testing platform, assuming
> that the owner is willing to insmod batman-adv on that machine :-)

I've no problems with batman on this NAS box. It is a box dedicated to
kernel hacking and experienced many an opps. I currently have 3.13-rc1
on it, which happens to break the ethernet PHY on reboot :-(

   Andrew
