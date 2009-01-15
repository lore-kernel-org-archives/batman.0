From: Axel Neumann <neumann@cgws.de>
Date: Thu, 15 Jan 2009 15:24:53 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812191115.20610.neumann@cgws.de> <4963633D.2020306@dd19.de>
In-Reply-To: <4963633D.2020306@dd19.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901151524.53433.neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs / certificates
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

On Dienstag 06 Januar 2009, Alexander Morlang wrote:
> Axel Neumann schrieb:
> > We wanted batmand (and especially its core routing algorithm) to be
> > decentral and simple. So no central point of control/failure and
> > therefore also no HNA server. Of course there are many potential attack
> > vectors in a community mesh and probably there will always be until you
> > completely restrict the access. Therefore IMHO the preferable security to
> > be solved should be:
> >
> > - detect and protect against (usually accidental) misconfigurations like
> > duplicate addresses.
>
> sure, a duplicate address is something the routingprotocoll has to
> detect and to react on, but:
> duplicate HNA are very importand and widely accepted in the internet
> community, they are called anycast and are a vital instrument in network
> design and deployment.
>
> as an example, anycast ist used for dns root servers, 6to4 tunnel and
> many other usecases.
>
> i am still not understanding why you are discussing about removing such
> important thing as anycast.
I think nobody wants to remove it. I wanted to point out that real anycast 
routing has never been supported by batman/bmx and that our features for HNA 
should NOT be confused with anycast routing. The problem is that the concept 
of anycast-routing does not easily fit into the batman routing algorithm 
which relies on a single-source of originator messages (OGMs) for any given 
destination.


I agree that the lack of anycast routing support is a problem and not a 
feature. Especially when talking about quagga/zebra like route exchange 
between different autonomous systems.

ciao,
axel

>
> anycast is a way to use distributed services, as you can announce an
> anycast address on every node, providing a specific service and packets
> will get routed to the nearest service provider.
>
> > - find mechanisms to limit the impact of denial of service or other
> > attacks to the local environment (neighborhood).
>
> <removed>
>
> Gruss, Alex
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


