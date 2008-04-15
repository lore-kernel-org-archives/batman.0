Message-ID: <4805198F.8080705@gmx.net>
Date: Tue, 15 Apr 2008 23:09:35 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>	<a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>	<018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>	<200804160202.23971.lindner_marek@yahoo.de>	<C2223079-2ACE-4EA6-BB82-C9B4A1547149@philippeapril.com>	<4804FC55.3010407@gmx.net>
	<A46801E6-B4A6-452F-A1DE-C787A4E947D5@philippeapril.com>
In-Reply-To: <A46801E6-B4A6-452F-A1DE-C787A4E947D5@philippeapril.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi -

>
> With your tests with massive traffic streams, can you confirm that 
> (for example) a user who's downloading something big (or an 
> interactive ssh session) should not see a difference and the flow 
> should stay constant, even though the traffic switches to another path 
> several times during the session? 

If two routes have similar quality it is no wonder that the protocol may 
switch because self-inflicted interference from payload degrades the 
route metric. If the alternative route is 10 % worse, the protocol may 
occasionally use the latter for a short time if the best route is fully 
saturated. As soon as the superior route has no payload anymore the 
metric improves again, while the metric of the inferior route drops. So 
the protocol will switch back quickly.

In such a scenario the superior route may be used most of the time, 
while the inferior route may be chosen less often. This may have a minor 
affect on the throughput - if one route has 10% less throughput than the 
other, but is only used 20% of the time, the negative effect is very 
limited. I'd prefer this behavior over adding hysteresis, which may 
introduce new and more severe headaches.

What is important to me is that the protocol is responsive to changes, 
and while it changes often, doesn't produce any routing errors.

When I was working on OLSR in 2004 and 2005 for Freifunk, we had the 
problem that OLSR started producing routing loops under such conditions 
in our mesh. We saturated a route (transferring high speed data traffic 
at 200 kByte/sec for 10 seconds) and then the route would break down 
completely for 40 seconds and come back at a speed of something like 8 
kByte/sec and 'stabilize' itself there... We solved the problem for OLSR 
(not entirely, but to about 95%) by making its responsiveness slower and 
slower and introducing Fisheye into OLSR (send topology information more 
redundant and more often without drowning the network with protocol 
overhead).

I have made some rough tests to see how much a fully saturated link 
degrades the metric value measured by Originator messages. I have found 
that a fully saturated link does reduce the metric values of Batman a 
bit, but in my tests it was less than 10%.

If the protocol would switch between a miserable route and a good route, 
and utilize each one half of the time this would have a significant 
effect on the throughput, and it was one of my worries in the early days 
of the protocol design. As far as I have seen in practice this is not 
the case.

> That'd be great (and I'll test that tonight!)
Yes, please test it.

cu elektra
