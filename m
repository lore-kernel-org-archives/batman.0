Message-ID: <49F98E54.5030602@gmx.net>
Date: Thu, 30 Apr 2009 13:41:08 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>	<49F5E0D3.208@gmx.net>
	<49F96044.4070207@informatik.haw-hamburg.de>
In-Reply-To: <49F96044.4070207@informatik.haw-hamburg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Masters thesis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello Maik!


> Was the protocol implemented yet on a simulation platform like omnet?
> For comparing purposes (for example with OLSR) it could be interesting
> to simulate the protocol.
>   


There is no implementation of Batman for NS2 or Omnet, as far as I'm 
aware of. However there is a paper about the simulation of Batman-0.1 
(Mark I of the Batman algorithm without bidirectional link check) and 
Batman-0.2 (Mark II of the Batman algorithm with bidirectional link 
check): http://www.olsr.org/~aaron/olsr/batman_report.pdf

Note: The paper is nice, the results were encouraging but the study is 
dated. The lack of a bidirectional link check was a known limitation of 
Mark I when we just wanted to do a quick and dirty test to prove the 
feasibility of the Batman idea. So the first version we expected to work 
well in the real world was Mark II. Mark II was replaced quickly by Mark 
III because as Axel Neumann has pointed out there was a bug in the 
algorithm in both Mark I and Mark II which can cause routing loops.

Addressing this problem in Mark III also had the benefit to reduce 
protocol overhead. Mark III works nice, but we found that the link 
metric we used still had a flaw. All Batman algorithms can route 
asymmetric, which is great. However Mark I-III tend to prefer routing 
paths from which they *receive* protocol messages well as paths in the 
opposite direction to *transmit* payload. This can be unfortunate, 
because there could be an alternate routing path which works better in 
transmit direction than the path which works better in receive 
direction. In Mark II and III we tried to address this via the 
bidirectional link check, to achieve a symmetric ETX like routing 
behavior. This mitigated the problem but didn't solve it completely. 
Also it was not what we really were aiming for: Routing asymmetric in 
the transmit direction if this is the best routing path to go. Hence 
Mark IV was introduced.

We have tested and compared Olsrd 0.5.0 and Batman-Experimental (Mark IV 
) in the "Massive Mesh" wireless indoor grid at the Meraka institute of 
the CSIR in Tshwane (aka Pretoria) in South Africa. At the time we ran 
the tests Batman-0.3 was pretty much in its alpha state so we were 
concentrating on the Batman-Experimental branch because the 
implementation was more mature. (Batman-0.3.X and Batman-Experimental 
represent two different ideas for Mark IV of the Batman algorithm.)

http://researchspace.csir.co.za/dspace/bitstream/10204/3035/1/Johnson3_2008.pdf


Note that time has passed over this study as well. Olsr fans will point 
out that they have improved the code much since the study and fixed at 
least one crucial bug (ETX was not only calculated based on Hello packet 
loss in Olsrd, as I had suggested it to Thomas Lopatic when we were both 
designing the ETX/LQ implementation in Olsr in 2004. Thomas had decided 
to use all protocol messages to calculate TQ/NLQ in the implementation 
of olsr-0.4.8, so the LQ/NLQ values would change quicker than I expected 
- depending on the number of TC messages floating around in the network)

However some general conclusions still remain the same if you compare 
both protocol ideas:

* Batman-IV floods protocol messages selectively i.e. only on paths 
following the best route for each destination. Olsr has to flood all 
topology messages everywhere - the only optimization being the idea of 
multipoint relays. (MPR redundancy was set to 7 MPRs per node, since I 
tried my best to avoid routing loops).  However - enabling multi-point 
relays or not - Olsr tries to sync every topology update with all nodes. 
Since the grid has thousands of alternate propagation paths to 
redundantly flood messages the protocol overhead is drastic, because 
there is not much protocol message loss.

* Olsr needs more protocol information (topology data) to operate than 
Batman.

* We did the best to stop Olsr from looping payload packets - i.e. send 
topology updates redundant - however this comes at a price. In order to 
avoid loops the topology information has to be synced with all OLSR 
nodes. Despite the high level of redundancy less than 70% of the routes 
used were symmetric. This is a clear indication that the topology data 
bases were not in sync, because ETX would route symmetric at all times 
if the topology data is in sync. Despite the great deal of of effort to 
sync topology information Olsr still had transient routing loops under 
heavy payload. It would be interesting to see how a current Olsr behaves 
today, since the fix of the fore mentioned issue.

* Batman-IV didn't loop, no matter how hard we saturated the network 
with payload traffic. This is not a surprise because it was the main 
goal of the algorithm design. Transient routing loops were the main 
motivation for Thomas and me to drop development of Olsr.


> In respect to IPv6: What is the problem with IPv6? 


No problem regarding the protocol - we are just missing IPv6 support so 
far in the OSI-Layer 3 implementations of Batman (both Experimental and 
0.3.X). Batman-Advanced doesn't have this problem, as a Layer 2 protocol 
it can carry any protocol you like.


> The batman protocol
> self should work with ipv6? 

Absolutely.

> As payload it could be realized by an tunnel
> too.

Yes. As a side-note: Batman uses tunnels for Internet connectivity to 
address the problem of gateway switching when NAT is used on the 
gateway. With IPv6 NAT on gateways should become superfluous one sunny 
day :-)


Cheers,
elektra
