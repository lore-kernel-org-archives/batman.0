Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Feb 2014 12:44:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140213114449.GI7193@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch> <52FCA639.9080204@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FCA639.9080204@meshcoding.com>
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

> it is invoked every time the interface is brought up. So if you
> disconnect and then reconnect the cable (e.g. to connect the NIC to a
> faster switch) this function is invoked again and the bandwidth is updated.
> 
> > Are we sure that auto-negotiation has
> > finished? It can take a few seconds to complete after the interface is
> > brought up. It would not be good to have batman use 10Mbps/Half Duplex
> > on my gigabit links...
> 
> So it can take up to "few" seconds? I did not expect such a delay!

It varies a lot between devices. I have a NAS box which i use for
kernel hacking. I TFTP boot the kernel, using u-boot configuration
variables. I found that for a cold boot it works great, but a warm
boot seems to be faster and the TFTP GET command is sent while the phy
is still auto-negotiating, and it gets lost. This then triggers a bug
in u-boot, it never re-transmits the GET command, and then whole TFTP
boot times out eventually.

So i'm just cautious about making assumptions here, especially
assumptions which might be mostly true, but in some odd edge case turn
out to be false.

> However this function if invoked when the NETDEV_UP event is issued by
> the underlying system. I expect the event to be thrown when the
> interface is ready to be used, not when the auto-negotiatin is still
> going on. I will double check.

I had a quick look at the code. It seems like NETDEV_UP is issued
directly after the device is opened. There does not seem to be any
waiting around for auto-neg.

	Andrew
