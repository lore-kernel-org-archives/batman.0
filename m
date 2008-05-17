From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] using gateway of other node, instead local gateway
Date: Sat, 17 May 2008 08:39:35 +0200
References: <20080515144048.ckex6mdmv40ogoo4@webmail.ddmesh.de>
In-Reply-To: <20080515144048.ckex6mdmv40ogoo4@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805170839.35773.axel@open-mesh.net>
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

I am am not sure if i understand correctly and if this can work at all. 
Wouldn't this cause a tunnel loop because you cause the vpn packets to be 
entunnelled into the bat tunnel which then would be entunnelled into the vpn 
tunnel,...

ciao,
axel

On Donnerstag 15 Mai 2008, Freifunk Dresden wrote:
> Hi,
>
> I have a node that uses its own internet connection to establish a vpn
> connection to another node. Therefore the node has a local default route.
> I have setup my policy routing in that way that all public wifi packets
> should be routed through the vpn connection. These packets should not go
> through the local gateway.
>
> The wifi interface and vpn interface are under control of batmand.
> (batmand -r 1 vpn eth1)
>
> When I call batmand -cd2 I see the gateway that is offered by the other
> node behind the vpn connection. But no default route (bat0) is present and
> I also can not use the parameter "-p" to select the gateway.
>
> How can I tell batmand to use the best gateway when the current node
> has a local
> gateway that should not be used by batmand or the batman-network?
>
> I'm running batman-exp rev1066.
> Regards
>   /Stephan
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


