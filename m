From: Axel Neumann <neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs
Date: Wed, 17 Dec 2008 21:14:43 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812121146.26579.neumann@cgws.de> <4942F8FA.4040600@ddmesh.de>
In-Reply-To: <4942F8FA.4040600@ddmesh.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200812172114.43427.neumann@cgws.de>
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

On Samstag 13 Dezember 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> Hi,
>
> I'm not so deep involved in batman routing to find a solution. I hope
> you can find a way. But for now it is not so important.
> But if one node announces a HNA and a different node that just has fun to
> "turn off" this node can simply send the same HNA. If you say the first
> HNA is the right one, then what happens when this node gets the forced
> disconnection after 24 hours by its internet provider?

Theoretically, if the node can reestablish a new connection after its forced 
disconnection within the dad timeout (100secs by default) then it should not 
be kicked out. But, the preliminary for this is that: the node must re-appear 
using the same primary IP for its primary interface and continuing with the 
foreseen sequence-number range.



best,
axel
>
> I think it is difficult to find a solution for this. The best is to keep
> all nodes active but kill the HNA if not reachable?
>
> /Stephan
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


