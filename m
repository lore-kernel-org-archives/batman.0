Return-Path: <linus.luessing@web.de>
Date: Thu, 16 Dec 2010 09:41:31 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101216084131.GA15105@Sellars>
References: <1292228705.21378.13.camel@chris-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1292228705.21378.13.camel@chris-desktop>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Alternative Multicast Optimizations
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
To: clang@gateworks.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Chris,

thanks a lot for publishing your patches here. It's obvious, that you also put quite some work into this. I don't really wanna discuss how you've implemented things here, but I'm more interested in the conceptual part for now, so more the "what" and not the "how". Let me try to describe first how I'm understanding your concept and please correct me if I understood something wrong or if I'm missing important parts.

It looks like the basic idea is similar to Simon's and my approach so far: You are also sending packets to mark the path so that a node knows if it has to forward a certain multicast data packet later or not. You're also sending one bundled packet with the originator's adresses to the according next-hop nodes which are responsible for forwarding the traffic. You are doing this proactively, too, currently at an interval of once per second.

What looks different to me is that you are so far non-group specific: You are building up a single tree for each originator towards all other nodes. Because an originator's mcast-discovery packet (usually) reaches every other node in the network, you are not using timeouts for invalidating the marking, but a new mcast-discovery packet deletes are adds the marking. Another thing that seems different is, that you are always sending any multicast/broadcast packet via unicast directly to each next hop router in charge.

One thing I didn't quite get from the code is, why are you memorizing a next hop router's TQ value? Could you explain that a little more?


Finally I'd have some questions about your conceptual decisions and would like to explain, why we decided to do things differently in those ones and what our point of view was.
 
As Simon already pointed out in response to Andrew, we've mainly been focussing on networks which are sparse in terms of multicast nodes in relation to all nodes. We wanted to minimize the amount of traffic in this case where only a few of all nodes really want to receive certain multicast packets for one thing, and only a few nodes sending multicast data for another. And I also especially have large scale metropolitan area (community) mesh networks in mind, where it is usually very unlikely that for instance all participants in the mesh would like to listen to the same radio station at the same time - or would like to listen to the radio station of all other mesh nodes all at once. May I ask what kind of scenario/topology you had in mind for your case? How many nodes will want to receive the same multicast stream, how many senders do you expect (relatively to all nodes in the mesh)?

From the resarch we had done previously, we came to the conclusion, that in case of more then 50% of all nodes wanting to receive the data, local optimization schemes seemed to be more suitable. We even planned to maybe do simple flooding and skip the tree-building in such a case with a further patch. As such mcast-discovery packets are introducing a squared amount of overhead, we wanted to keep the nodes where we'd have to send a tracker packet to very small, and wanted to later also get rid of the symmetric "group" membership requirements, to only have a linear amount of overhead in relation to the number of multicast receivers for one multicast sender.

Your event-based marking compared to our timeout-based approach for marking forwarding nodes sounds interesting. We had been argueing about how large to set such timeouts in our case, but of course that can depend on the scenario, too and therefore could need extra effort for tweaking for the user in some (special) scenarios, which usually is not desirable. What I was wondering, do you think the event based approach could make the multicast transimission less reliable? How likely do you consider the following: A node is on the edge of being a node for forwarding mulicast data for a certain originator, the path qualities of this node and another one are very similiar, resulting in frequent route flapping. Couldn't it happen quite often, that in such a case a node might get mcast-discovery packets disabling the forwarding, but miss the enabling packets? How likely do you think that could be?

For the unicast vs. broadcast forwarding, we were actually peeking at the olsr-bmf a little. They are also using this mcast-fanout to dynamically decide on how to forward the packet, depending on the number of receiving next hop nodes. Ok, I think you are right that in the case of the default 1/2 mbit/s multicast rate, it does not make that much sense to forward packets via broadcast (unless you have >20 neighbours that'd like to receive it on the next hop). For our use-case however we had decided on using higher multicast rates, as that should usually be reliable enough with our 3x broadcast but still needing less airtime, even if there were just a few neighbours interested in the packets.



I'm very interested in hearing your point of view on these aspects. Please correct me if I misunderstood something about your concept or if I'm missing something important. I'd also be curious about what you think how similar/different our approaches are and where you see the advantages and disadvantages of each.

Cheers, Linus
