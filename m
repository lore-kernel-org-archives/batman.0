Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 Apr 2012 11:32:42 +0200
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<201204020032.37555.lindner_marek@yahoo.de>
	<CAA_JP8VhdK__mRZoL6DY+vPth9wOE6=BqLE5EDpV5rC0RB2kCQ@mail.gmail.com>
In-Reply-To: <CAA_JP8VhdK__mRZoL6DY+vPth9wOE6=BqLE5EDpV5rC0RB2kCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204021132.42284.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

On Monday, April 02, 2012 00:23:36 dan wrote:
> I am making some assumptions.  I assume that the link will at some
> point become saturated.  If we simply track the maximum then we can
> advertise an available amount.

This will result in a metric optimizing paths for the highest throughput ever 
recorded. In reality one can easily observe many links with variable 
throughput. Sometimes you get a spike of high throughput although the average 
speed is lower. Or your wifi environment changes with a negative impact on the 
throughput.
 

> How do we identify this? Well, if the C radio has historically
> transfered 10Mb (on the interface closest to the gateway) and we have
> tracked it, we can take the current 5Mb away from that an see that
> there is 5Mb remaining.  This does also assume that a specific
> interface has a consistent speed.

That is not a safe assumption.


> I don't suggest making throughput the #1 route selection method, only
> what would be used if similar quality links where available.  in this
> case, A<>B and A<>F are very similar quality so we would use
> available throughput in the decision making.  Have a tunable threshold
> for TQ vs TQ before this load balancing is taken into account.

Interesting idea. Have to think about this a little bit.


> I have another though on how to determine maximum speed but it is more
> 'destructive'
> Have batman-adv do a test on each link for tx, rx, and bi-directional
> and store the results and consider these the interfaces potential.
> Also identify if an interface is FD or HD.  retest on an interval,
> and/or when the TQ on a link is consistently worse than when tested
> last.  If the test was thorough enough, it would be able to identify
> at what throughput ping times and packet loss spike and have an
> effective 'safe' maximum vs absolute maximum.

Yes, we still have the "costly" way of detecting the link throughput 
ourselves. What do you think about the idea of asking the wifi rate algorithm 
for the link speed ?

Regards,
Marek
