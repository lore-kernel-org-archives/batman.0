From: elektra <onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] a proposal
Date: Fri, 14 Sep 2007 13:51:43 +0200
References: <002d01c7f5cc$825d8910$0cdbe29f@happy0bc06a65b>
	<001401c7f6ba$3ab9e600$0cdbe29f@happy0bc06a65b>
	<32455.85.41.146.90.1189767047.squirrel@krisma.oltrelinux.com>
In-Reply-To: <32455.85.41.146.90.1189767047.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709141351.43182.onelektra@gmx.net>
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

Hi Antonio -

your suggestion sounds reasonable and is worth thinking about. However I think 
this issue will become less important with B.A.T.M.A.N.-IV since it will 
massively improve the routing metric. I think it is fair enough that a 
gateway client will unilaterally choose the gateway - the number of OGMs 
received should provide enough information for the client to choose the right 
gateway. 

cu elektra


> A client node take its decision about chosing a gateway in a unilateral
> way, that is chosing gateway on a ranking basis (or wathever else)
> checking the path "node-->gateway" or "node-->hop-->gateway" (also if the
> second is not always preferred, chosing a poor link "node-->gateway"
> rather then best links "node-->hop-->gateway").
>
> Presuming the node has a bouquet of canditate gateways: we can think to
> use an udp packet polling the candidate gateways and asking them "how you
> see me?" so the the node itself can obtain a path evaluation computed at
> gateway side and not only at node side.
> For example
> presuming node A can chose among gateways G1 and G2 (the candidate
> gateways) it will make its choice upon path evaluation:
>
> A --> hops --> G1
> A --> hops --> G1
> where [hops] can be also 0 (no hops between A and Gn)
>
> and computing OGMs coming from neighboors.
>
> Well, node A can send two udp packet (same format as OGM but different
> op-code in payload||different dest port) to G1 and G2 asking to send their
> path evaluation like "G1 --> hops --> A" evaluation (received from
> candidate G1) and "G2 --> hops --> A" evaluation (received from candidate
> G2). In this way node A has a more clear vision about the entire path A
> <--> G_candidate and can take a more serious decision.
>
> Using udp requests we introduce low latency than tcp and with a separate
> thread on gateway (with a poor resources consumpion) we can manage this
> task without effetcing the main.
>
> What are you thoughts about?
>
> --
> Antonio
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


