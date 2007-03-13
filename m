Message-ID: <45F69EA5.6020505@gmx.net>
Date: Tue, 13 Mar 2007 13:52:53 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] protocol performance
References: <200703131145.07614.atis@mikrotik.com>
In-Reply-To: <200703131145.07614.atis@mikrotik.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello Atis -
> After studying the source code, I understand that HNA information is included 
> in every originator message. Isn't such excessive amount of routing 
> information bad for typically limited-capacity wireless links? 
A packet carrying a HNA 0.0.0.0/0 anouncement doesn't cost extra data. 
Well, one bit actually in one reserved byte that we use for different 
flags. This is the most common case in our networks. So the size 
(without MAC-header) is 10 Byte, the typical size of a 
B.A.T.M.A.N.-packet. Announcing a different subnet or host route will 
cost 5 Bytes extra.

> What are the 
> results of real-world tests - there isn't much info in open-mesh.net about 
> that. What is the largest network in which B.a.t.m.a.n. have been tested?
> Is there some actual evidence that B.a.t.m.a.n. outperforms OLSR?
>   
We couldn't test it on such a big deployment that we have with OLSR 
here. So it is hard to really compare it. We are running it parallel to 
Freifunk-OLSR.  OLSR has 450 nodes, B.A.T.M.A.N has 25. What I can say 
is that it works well. It quickly populates the routing table, routing 
selections are reasonable and it doesn't loop. A notorious problem of 
OLSR. Bandwidth consumption on my mesh node is 250 Bytes/second. No 
gateway-switching. I can select my gateway and it will negotiate it. 
OLSR does sometimes select slightly better routes than mark III  - if it 
isn't busy creating loops. See below. Overall the routing performance 
seems to be similar. This is in comparison to Freifunk-OLSR. RFC3626 
isn't usable. Would be interesting to see it running on all 450 nodes - 
but migration will take time and further experiments.


> And if you concerned about its performance, too -  have you considered using 
> Fish-eye to improve the algorithm? 
Fish-Eye doesn't work for the B.A.T.M.A.N. algorithm. B.A.T.M.A.N. is 
designed for networks with packet loss. The packet-loss of Originator 
messages that are selectively flooded in B.A.T.M.A.N. is huge. If you 
use it you will see it.

> It could be either periodical TTL 
> modifications or not including all HNA information in each originator message 
> (i.e. include them in only, say, every 10-th). 
This is a valid suggestion - but so far we are happy with the redundancy 
of HNA announcements. If we run into problems with the sheer amount of 
traffic we may consider saving a few bytes here.

> The second approach could work 
> if there some kind of route-request message.
We are not on the way to redesign a reactive routing protocol. I doubt 
it would actually safe traffic in this case.

>  Another approach I can think of 
> would be to introduce some kind of delay in forwarding as the originator 
> packet get farther away from its originator. Or introduce random probability 
> of not forwarding it. 
>   
The hot-potato-principle is one of the core elements of B.a.t.m.a.n.
> Have you thought of adding some re-active components (like in Hazy Sighted 
> Link State protocol)?
>   
No.
> What about handling of asymmetrical links? Currently BATMAN appears to have an 
> implicit assumption of symmetry. 
B.A.T.M.A.N.-III and II are checking for bidirectional links. They don't 
assume them. B.A.T.M.A.N.-I did assume symmetric links without checking. 
Which was an obvious design flaw that we didn't bother about for our 
first experiments.

>  Is there any plans to incorporate 
> asymmetrical link support? 'Neighbor Link Quality' field perhaps? Or do you 
> feel that this is something unnecessary for real world setups?
>
>   
This will be an improvement of B.A.T.M.A.N.-IV. B.A.T.M.A.N.-III is 
routing asymmetrically if bidirectional-link checking is not strict 
enough in dropping packets. If it is strict enough it will behave like 
ETX. At the moment we accept forwarded originator messages from 
neighbors as long as they send us one out of three of our own originator 
messages back. Which isn't very strict. Mark III will choose to route 
asymmetrically in the wrong direction under some circumstances. Mark IV 
will route asymmetrically in the right direction.
> And, finally, what exactly is batman-experimental? 

Basically Batman with layer 2.5 routing.  The very first implementation 
is already available in SVN.  It will use algorithm mark IV. Mark IV 
will also be available for layer 3.
> A prototype for 
> B.a.t.m.a.n.-IV implementation?
>   
Cheers,

cu elektra

