Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 6 Aug 2009 22:15:23 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200908031821.22497.lindner_marek@yahoo.de>
	<OFC1B28E77.E7123900-ONC125760A.0028654D-C125760A.00300451@CHASCOM.INT>
In-Reply-To: <OFC1B28E77.E7123900-ONC125760A.0028654D-C125760A.00300451@CHASCOM.INT>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OWueKu9/ffqds+S"
Message-Id: <200908062215.42266.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman goes looping...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--Boundary-00=_OWueKu9/ffqds+S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 06 August 2009 16:44:28 Yang Su wrote:
> - You are right. Under certain circumstance, this approach may lead to less
> optimal route selection. Just to understand batman algorithm better, I try
> to make an example (please correct me if something's wrong here): There are
> two direct neighbors via which a sender communicates with a receiver. Via
> the good neighbor, their is a single good route with long delay. Between
> the bad neighbor and the receiver there are many parallel bad routes. Each
> bad route has high packet loss rate but very short delay. The receiver's
> OGMs arrive at the sender first via the bad neighbor. Although there is
> substantial OGM loss on each individual bad routes, by aggregation over
> those parallel bad routes, the bad neighbor is still able to relay most of
> sender's OGM to the receiver. As a result, if the sender already chooses
> the bad neighbor as the next hop, it will stick to it for quite long time
> and does not switch to the good neighbor.

It is possble to simplify your example more to clearly illustrate the problem. 
Scenario: Host A wants to send data to host B. Consider the beautiful graphic 
I attached. ;-)
The link between A and B is quite asymetric. No packet loss from B to A but 
heavy packet loss the other way round. Now, B periodically sends its OGMs and 
all OGMs will arrive at A directly and via the neighbor whereas the OGMs via 
the neighbor always be slower than the directly received ones. A should choose 
the longer path via the neighbor because it has no packet loss but the 
"fastest sequence number wins" algorithm won't allow that. 


> - This approach achieves the similar goal as the seqno-based one: switch to
> a neighbor only when this neighbor is better and has more up-to-date
> information than the current best route. But this approach is less
> constrained and seems not to suffer from the above problem for the
> seqno-based approach. I have tested the patch on our test environment. It
> works pretty well on the test cases.

Great! I comitted the patch immediately. Thanks again for your thorough 
analysis and ideas. :-)


> - The problem might happen when the neighbor thinks that I am his best
> neighbor (his good number is actually from me). In this case, my estimation
> of that neighbor's TQ is actually decided by my own TQ (my TQ minus one hop
> penalty). When my TQ drops down, the correct behavior should be that my
> estimation of that neighbor's TQ also drops down accordingly. However, when
> echo cancellation steps in, my estimation of that neighbor's TQ will not be
> updated and remains to be the stale value. This might cause problems (e.g.
> looping) in corner cases even with the new patch.  Does this analysis make
> sense or I miss some details of the echo cancellation?

Unless you found another bug the echo cancellation should not hinder the 
propagation of our own TQ value. Once we (uml2) received a packet we will 
rebroadcast it. Our neighbor (uml1) will receive it (unless the packet got 
lost) and update its routing tables accordingly. Now, he will rebroadcast the 
packet as well which will be killed by the echo cancellation on uml1 as this 
packet does not contain new information. 
But even if the TQ received via uml2 is worse uml1 might still have a good TQ 
from uml3 in its routing table which might get rebroadcasted.

Regards,
Marek


--Boundary-00=_OWueKu9/ffqds+S
Content-Type: image/png;
  name="fast_seqno_problem.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fast_seqno_problem.png"

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
vSZwRoG0eAAAAABJRU5ErkJggg==

--Boundary-00=_OWueKu9/ffqds+S--
