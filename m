Return-Path: <onelektra@gmx.net>
Message-ID: <4B0D3815.9020104@gmx.net>
Date: Wed, 25 Nov 2009 14:58:45 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <4B0D0DD2.1040107@rsm-freilassing.de> <4B0D106F.40404@lo-res.org>
In-Reply-To: <4B0D106F.40404@lo-res.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] What routingprotocol is similar to B.A.T.M.A.N ?
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

Hello Michael -


this question frequently pops up on this list.

You can use layer 3 Batman to announce a default route, but this is not 
recommended. Default routes in a large mesh are a pain in the ****. 
Which is something we quickly realized in the Freifunk community as soon 
as we had more than one gateway or malfunctioning gateways  - those will 
act as black holes and effectively interrupt your service.

You can circumvent the 0.0.0.0/0 check in Batman, by announcing two 
HNA's of 0.0.0.0/1 and 128.0.0.0/1 with the -a option. If you don't 
define a gateway class on the gateway the Batman gateway clients can't 
select a gateway.

Disadvantages: Other than the fact that I personally consider the 
announcement of 0.0.0.0/0 routes as sabotage - none that I know of, 
really. A few bytes overhead in the OGMs of the gateway, thats it.

We have occasional OLSR advertisement fade-ins on this list - I guess 
the Babel/OLSR/Batman quarrel will become proverbial one day ;-)

Cheers,
Elektra


