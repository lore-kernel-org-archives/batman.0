Return-Path: <andrew@lunn.ch>
Date: Fri, 9 Mar 2012 17:21:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120309162137.GF16608@lunn.ch>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<74A4488FAEEC56408507A6FECA69099101221874@SC000647.CHASCOM.INT>
	<CANjd3nczdfd5XvNevVUtWJCP4J=ieUseSX85DVPrZcHV2ZExKg@mail.gmail.com>
	<201203092236.51812.lindner_marek@yahoo.de>
	<CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
	<20120309154311.GE16608@lunn.ch>
	<CANjd3ncNvz=QY+QiFqLh=KNXWHO_LYJMgM1G9mv0WJYbQs-jJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjd3ncNvz=QY+QiFqLh=KNXWHO_LYJMgM1G9mv0WJYbQs-jJg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]  Diversity in BATMAN
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
Cc: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

On Fri, Mar 09, 2012 at 05:07:37PM +0100, Benjamin Henrion wrote:
> On Fri, Mar 9, 2012 at 4:43 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> >> With such metric, you don't make any difference between a 56K
> >> telephone line and a 10Ge NIC.
> >>
> >> If you 10Ge has 5pc packet loss and your 56K line has 0pc, your TQ
> >> will be prefer the 56k link.
> >
> > If my 10Ge has 5% packet loss, its broken. I don't want to use
> > it. Falling back to the 56K link is the right thing to do.
> >
> > There is a general rule of thumb. The higher the bandwidth, the less
> > packet loss there is. This is because high bandwidth links are
> > generally not wireless and so don't suffer high packet loss.
> >
> > As a side effect, BATMAN will tend to favor wired links over wireless
> > links, because wired links tend to be reliable, wireless links drop
> > packets.
> 
> So compare a 1Mbits wireless link with a 54Mbits one.

The 54Mbps link probably has a very low packet error rate. Otherwise
it would not be running at 54 Mbps. The automatic rate selection
algorithm would take it down to a lower rate if it had high packet
loss.

On the other hand, any link running at 1Mbit probably has quite a high
packet error rate. It must be a bad link, otherwise it would not be
using the lowest possible coding rate.

So when comparing a 1Mbps and a 54Mbps link, probably the TQ for the
54Mbps link will be better than the 1Mbps link.

       Andrew
