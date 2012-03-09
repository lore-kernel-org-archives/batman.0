Return-Path: <gabriel@kerneis.info>
Date: Fri, 9 Mar 2012 17:38:46 +0100
From: Gabriel Kerneis <kerneis@pps.jussieu.fr>
Message-ID: <20120309163846.GM15059@kerneis.info>
References: <201203070156.51341.lindner_marek@yahoo.de>
	<74A4488FAEEC56408507A6FECA69099101221874@SC000647.CHASCOM.INT>
	<CANjd3nczdfd5XvNevVUtWJCP4J=ieUseSX85DVPrZcHV2ZExKg@mail.gmail.com>
	<201203092236.51812.lindner_marek@yahoo.de>
	<CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
	<20120309154311.GE16608@lunn.ch>
	<CANjd3ncNvz=QY+QiFqLh=KNXWHO_LYJMgM1G9mv0WJYbQs-jJg@mail.gmail.com>
	<20120309162137.GF16608@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120309162137.GF16608@lunn.ch>
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

Andrew,

On Fri, Mar 09, 2012 at 05:21:37PM +0100, Andrew Lunn wrote:
> The 54Mbps link probably has a very low packet error rate. Otherwise
> it would not be running at 54 Mbps. The automatic rate selection
> algorithm would take it down to a lower rate if it had high packet
> loss.
> 
> On the other hand, any link running at 1Mbit probably has quite a high
> packet error rate. It must be a bad link, otherwise it would not be
> using the lowest possible coding rate.
> 
> So when comparing a 1Mbps and a 54Mbps link, probably the TQ for the
> 54Mbps link will be better than the 1Mbps link.

That was our intuition too, but experiments we did in Brussels using 802.11n
multiradio routers, with Benjamin and Juliusz, seemed to show that packet loss
(as measured by babel at least) is not always correlated to throughput.  I do
not claim to understand how this is possible.

It was in a limited setup, however, and we would be glad to get more results
proving or disproving this hypothesis.  Do you have any actual experimental
results to share on this topic?

Best regards,
-- 
Gabriel
