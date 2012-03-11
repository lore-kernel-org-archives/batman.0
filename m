Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<74A4488FAEEC56408507A6FECA69099101221874@SC000647.CHASCOM.INT>
	<CANjd3nczdfd5XvNevVUtWJCP4J=ieUseSX85DVPrZcHV2ZExKg@mail.gmail.com>
	<201203092236.51812.lindner_marek@yahoo.de>
	<CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
	<20120309154311.GE16608@lunn.ch>
	<CANjd3ncNvz=QY+QiFqLh=KNXWHO_LYJMgM1G9mv0WJYbQs-jJg@mail.gmail.com>
	<20120309162137.GF16608@lunn.ch> <20120309163846.GM15059@kerneis.info>
Date: Sun, 11 Mar 2012 02:21:52 +0100
In-Reply-To: <20120309163846.GM15059@kerneis.info> (Gabriel Kerneis's message
	of "Fri, 9 Mar 2012 17:38:46 +0100")
Message-ID: <7ieht0c4pb.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]    Diversity in BATMAN
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
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> That was our intuition too, but experiments we did in Brussels using
> 802.11n multiradio routers, with Benjamin and Juliusz, seemed to show
> that packet loss (as measured by babel at least) is not always
> correlated to throughput.  I do not claim to understand how this is
> possible.

It's not magic, and I don't think it's due to .11n.

We currently measure using multicast, which in 802.11 is sent at a low
rate.  Minstrel, the rate adaptation algorithm used by Linux, uses
unicast probes at the higher data rates to find out the optimum rate.
What we have shown is that under some conditions, the multicast packet
loss is zero, while Minstrel detects data loss at the higher data rates.

As Benjamin rightly noted, this implies that, for that particular class
of links, multicast packet loss rate is a poor predictor of link
quality.  (Duh.  It's constant zero.)

We've got various ideas about how to solve this issue.  Dave suggested
hooking into the data structures that Minstrel is using.  For Babel,
that'd be a cross-layer indication, which is something that makes me
nervous, but it should be no problem for a layer 2 protocol.  While
I like Dave's suggestion, I also like to keep Babel lower-layer
agnostic, and I'm considering the use of a different predictor which has
the advantage of also making sense on wired links.  I'm not telling more
right now, I want to implement and test first.

-- Juliusz
