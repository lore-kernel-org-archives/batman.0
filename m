Return-Path: <andrew@lunn.ch>
Date: Fri, 9 Mar 2012 17:57:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120309165729.GG16608@lunn.ch>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<74A4488FAEEC56408507A6FECA69099101221874@SC000647.CHASCOM.INT>
	<CANjd3nczdfd5XvNevVUtWJCP4J=ieUseSX85DVPrZcHV2ZExKg@mail.gmail.com>
	<201203092236.51812.lindner_marek@yahoo.de>
	<CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
	<20120309154311.GE16608@lunn.ch>
	<CANjd3ncNvz=QY+QiFqLh=KNXWHO_LYJMgM1G9mv0WJYbQs-jJg@mail.gmail.com>
	<20120309162137.GF16608@lunn.ch>
	<20120309163846.GM15059@kerneis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120309163846.GM15059@kerneis.info>
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

> > So when comparing a 1Mbps and a 54Mbps link, probably the TQ for the
> > 54Mbps link will be better than the 1Mbps link.
> 
> That was our intuition too, but experiments we did in Brussels using 802.11n
> multiradio routers, with Benjamin and Juliusz, seemed to show that packet loss
> (as measured by babel at least) is not always correlated to throughput.  I do
> not claim to understand how this is possible.

How do you define throughput? Do you mean the coding rate the wifi
driver has chosen to use, or iperf/netperf measurements of throughput?
Also, does babel perform its measurements using unicast or
broadcast/multicast packets/frames?
 
> It was in a limited setup, however, and we would be glad to get more results
> proving or disproving this hypothesis.  Do you have any actual experimental
> results to share on this topic?

I've got no results on 11n. I've done most of my work on 11g.  I will
see if i've got any results for 11g which might be appropriate.

Maybe 
