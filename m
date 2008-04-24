From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Date: Thu, 24 Apr 2008 10:09:05 +0200
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<200804230954.37620.axel@open-mesh.net>
	<20080424035553.GA22613@apoderado.ometepe.net>
In-Reply-To: <20080424035553.GA22613@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804241009.05448.axel@open-mesh.net>
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

Hi,

On Donnerstag 24 April 2008, Jan Hetges wrote:
> and something completely different: i think, .4.1 should choose the
> direkt link to .4.162 instead of going through .4.160 (and vice versa)
I experienced the same. Sometimes, from the end2end throughput point of view, 
it would be better to choose the direct route and sometimes not. I played a 
lot with the metric in charge of the final route. But in the end I am unsure 
which parameters are responsible for that or whether the better path can be 
identified over several hops at all (perhaps if we take hop-by-hop bandwidth, 
interference, load, and other stuff into account). You could twist the metric 
so that it always prefers end2end routes with less hops but I think in the 
end it is most important to have a general and unique metric applied to every 
routing instance in your mesh. 

Don't know if you want to hear it? You can play with --dups-ttl-degradation X 
(current default is X=2). This degrades the preference for a path by 2 
percent with every additional hop (relative to the shortes path). So if you 
use 50 instead, a node with two alternative paths (one single-hop and one 
two-hop path) to a given destination will ignore 50% of the OGMs received via 
a two hop path. Then it will probably choose the single-hop path.
And of course, if you find a value which works general better for all your 
nodes then let us know.

ciao,
axel

>
> cheers
>
>   --Jan


