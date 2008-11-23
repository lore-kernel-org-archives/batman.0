Message-ID: <53187.149.5.32.200.1227469817.squirrel@www.rivertowermail.com>
In-Reply-To: <20081123121627.GA15419@pandem0nium>
References: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
	<200811230035.05534.lindner_marek@yahoo.de>
	<35921.149.5.32.200.1227387936.squirrel@www.rivertowermail.com>
	<200811231137.11082.lindner_marek@yahoo.de>
	<20081123121627.GA15419@pandem0nium>
Date: Sun, 23 Nov 2008 19:50:17 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] BATMAN routing (via gate0)
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi guys,

How does the routing work for inter-node communications for > 1 hop
neighbors?

If the gate0 tunnel is the default route for Internet communications how
does a node know how to talk to a node two hops (or more) away (that
doesn't go though the gate0 tunnel)?

This is the bit I don't understand - I thought that range mentioned by
Marek did mean radio range for local (one hop) neighbors.

I can understand how it works with OLSRd because each node has a big
routing table but I'm still confused about how BATMAN does it

Derek

On Sun, November 23, 2008 12:16 pm, Simon Wunderlich wrote:
> Hey,
>
>
> On Sun, Nov 23, 2008 at 11:37:10AM +0800, Marek Lindner wrote:
>
>> On Sunday 23 November 2008 05:05:36 Derek C wrote:
>>
>>> Does this mean that the mesh nodes cannot ping all the other nodes?
>>> This
>>> is if there is no routing to allow the nodes talk to "far-away" nodes
>>> not within their own AdHoc single-hop network?
>>
>> May be I was not clear enough:
>> * You can ping every batman node in range.
>> * Too far away nodes (out of range) obviously can't be pinged.
>> * If you have multiple subnetworks which could ping each other but are
>> routed differently you just have to make sure the routing is ok. Using
>> HNA is one
>> possible solution.
>
> just a note so we don't confuse the terms:
>
> Marek means with "range" where the communication can practically succeed,
> even over multiple hops. As you have some probablity to lose packets on
> each hop, the communication becomes "practically" unusable over very long
> distances, e.g. >10 hops (depending on your network setup and environment
> ...).
> Note that this range is not the single-hop range.
>
>
> regards, Simon
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

