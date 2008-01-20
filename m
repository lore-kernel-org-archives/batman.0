From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Quagga zebra API client for BATMAN
Date: Sun, 20 Jan 2008 08:52:41 +0100
References: <200712271148.14121.holger@layer-acht.org>
	<200712310201.49542.acinonyxs@yahoo.gr>
	<200801181816.35869.acinonyxs@yahoo.gr>
In-Reply-To: <200801181816.35869.acinonyxs@yahoo.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801200852.41541.axel@open-mesh.net>
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

Hello Vasilis,

cool work.
I have some questions:

> I've also tried to calculate a metric based on link quality. Unfortunately,
> I wasn't able to find a way to compare latency between two different
> originators. 

Assuming information about the latency is available. I guess you would like to 
use it as a secondary input when calculating the metric. Do you know (or have 
any feeling) how problematic it can become if the indicated latency for a 
given route is changing very frequently (definitely much more often than the 
best next hop and related TTL). 


> Originators could only be compared based on packet loss which 
> isn't what we want because it would lead to having the same metric (1) for
> all nodes if there isn't some packet loss present. So, we are staying for
> the moment with the TTL approach with some adjustment to make it safer with
> different TTL settings.

I am not familiar with quagga. Why is it problematic to have several routes 
with the same metric. Or asked another way: There could also be several 
routes (to the same destination) with the same TTL. Why does this problem not 
exist in this case?

>
> I also want to point out an issue with batmand host routes and Quagga.
> Although Quagga succesfully installs host routes, it doesn't treat them as
> valid gateways if the associated interface isn't flaged as P-t-P. I don't
> know if this is a bug or a feature but it renders all batmand second level
> routes inactive. I added a workaround in zebra client which disables host
> route installation. This means that you can use quagga zebra client only if
> you have standard broadcast subnets.

what is your definition of a standard broadcast subnet ?
is it "POINTOPOINT,MULTICAST,NOARP,..." and /32 ?

>
> The attached patch is against latest stable BATMAN release (revsion 502).
copied to http://downloads.open-mesh.net/batman/patches/quagga/

>
> Regards,
> Vasilis



ciao,
axel
