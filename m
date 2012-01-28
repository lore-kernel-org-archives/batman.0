Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Jan 2012 04:57:58 +0800
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<201201272354.26055.lindner_marek@yahoo.de>
	<20120127191334.GF27169@lunn.ch>
In-Reply-To: <20120127191334.GF27169@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201290457.58976.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
	shorter routes by changing the default hop penalty
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Saturday, January 28, 2012 03:13:34 Andrew Lunn wrote:
> When iperf was used to measure the traffic from one end of the chain
> to the other. With the default hop penalty we got poor
> performance. With the traceroute facility of batctl, we could see it
> was route flipping between 3 hops and 4 hops. When it used 3 hops, the
> packet loss was too high and we got poor bandwidth. Then it went up to
> 4 hops, the packet loss was lower, so we got more bandwidth.
> 
> This was repeatable, with each deploy we made.
> 
> Then we tried with a lower hop penalty. I think it was 5, but i don't
> remember. BATMAN then used 5 hops and there was no route flipping. We
> also got the best iperf bandwidth for end to end of the chain.

I have a hard time understanding this because the hop penalty has less 
influence on bad links. As you can see in my previous mail below a TQ of 100 
the default penalty of 10 make less then a 4 TQ points difference.

Did you try setting a higher multicast rate ? This tends to also eliminate 
flaky direct connections.


> The fact BATMAN was route flipping with a hop penalty of 10 suggests
> to me the links had similar TQ. So OGMs are getting through at the
> lowest coding rate. But data packets are having trouble, maybe because
> they are full MTU, or because the wifi driver is using the wrong
> coding rate.

Actually, in most of my setups the connection all neighboring nodes is 
perfect. Maybe that is another corner case ?  :-)


> I suspect the TQ measurements as determined by OGMs are more
> optimistic than actual data packets. Linus's played with different NDP
> packet sizes, and i think he ended up with big packets in order to
> give more realistic TQ measurements.
> 
> Unfortunately, this project is now finished. I do have access to the
> hardware, but no time allocated to play with it :-(

It was a good idea and is not forgotten. Hopefully I have the code ready by 
the time of the WBMv5. Then we can play a bit with that.


> > Nevertheless, this patch was intended to get a discussion going.
> 
> Well, i'm happy to take part in the discussion. I've no idea if our
> use case is typical, or an edge case. So comments, and results from
> other peoples networks would be useful.
> 
> If this change it to help 11n, maybe some more intelligence would be
> better, to ask the wireless stack is the interface abg or n, and from
> that determine what hop penalty should be used?

It is not directly related with 11n. The pain level grows with 11n as the gap 
between packet loss and throughput grows. This setting is more intended for 
setups in which all nodes have rather good connections to all other nodes. 
Then the direct TQs and the "hop" TQs are too similar and batman starts using 
multi-hop connections.

Regards,
Marek
