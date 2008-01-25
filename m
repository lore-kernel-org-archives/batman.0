From: Acinonyx <acinonyxs@yahoo.gr>
Subject: Re: [B.A.T.M.A.N.] Quagga zebra API client for BATMAN
Date: Fri, 25 Jan 2008 22:50:48 +0200
References: <200712271148.14121.holger@layer-acht.org>
	<200801181816.35869.acinonyxs@yahoo.gr>
	<200801200852.41541.axel@open-mesh.net>
In-Reply-To: <200801200852.41541.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200801252250.49055.acinonyxs@yahoo.gr>
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
To: b.a.t.m.a.n@open-mesh.net

Στις Sunday 20 January 2008 09:52:41 ο/η Axel Neumann έγραψε:

Hello Axel,

> Assuming information about the latency is available. I guess you would like
> to use it as a secondary input when calculating the metric. Do you know (or
> have any feeling) how problematic it can become if the indicated latency
> for a given route is changing very frequently (definitely much more often
> than the best next hop and related TTL).

I would like to use it as primary input for metric calculation. The reason I 
wrote quagga zebra client is to be able to use B.A.T.M.A.N. as IGP in a BGP 
Confederation. BGP minimum route advertisement interval is by default 30 
seconds and updating route metric more frequently than that isn't necessery. 
I haven't given this step much thought since I realised that there is no way 
to compare latency between different originators but I think I could 
calculate the average latency from an originator and update metrics every x 
seconds interval (30 secs in my case).

> I am not familiar with quagga. Why is it problematic to have several routes
> with the same metric. Or asked another way: There could also be several
> routes (to the same destination) with the same TTL. Why does this problem
> not exist in this case?
>

In a BGP Confederation, best path selection is based on IGP metric since all 
the other criteria are always equal. If IGP metrics are also equal, then path 
selection falls to the rule: 'Prefer the route that comes from the BGP router 
with the lowest router ID'. This creates a major problem when all metrics are 
equal because it always favors the selection of paths that come from one 
specific BGP router. 

> what is your definition of a standard broadcast subnet ?
> is it "POINTOPOINT,MULTICAST,NOARP,..." and /32 ?

A subnet on an interface flaged as BROADCAST with a prefix length < /32

Best Regards,
Vasilis

