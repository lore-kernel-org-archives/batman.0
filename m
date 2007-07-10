From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] originator timeout
Date: Tue, 10 Jul 2007 11:10:37 +0200
References: <59806.85.41.146.90.1183999326.squirrel@krisma.oltrelinux.com>
In-Reply-To: <59806.85.41.146.90.1183999326.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707101110.37087.axel@open-mesh.net>
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

Hello,

Before a batman configures a host route towards another node (and  
batmand -c -d 1 -b should tell you about all succesfull configured routes) it 
must learn about the existence of the other node via a bidirectional link.
Thus actually two things are checked:
1. the link (via which it received a message from the new node) must be 
bidirectional.
2. Receive an originator message from the new node (OGM).

In your case the node 6.17.190.172 (A) has not yet confirmed the first issue.
It received an OGM from node 6.17.0.1 (B) but not via a validated 
bidirectional link (not yet).
In order to consider a link bidirectional, node A checks if it has 
successfully received one of its self-initiated OGMs back from node B.
I suppose this has not happened so fare but (if the link between A and B is 
bidirectionsl) should happen within the next seconds. The line:
> ath0 Orginator timeout: originator 6.17.0.1, last_valid 0
which you are concerned about indicates exactly this fact. Recevied messages 
from another node are only valid if (besides other checks) they have been 
received via a bidirectional link. This one was not so its not valid. 
Otherwise last_valid should indicate the timestamp of the last validly 
recevied OGM from node B. 
Another line:
> Forward packet: rebroadcast neighbour packet with direct link and
> unidirectional flag
Indicates that node A rebroadcasts node Bs OGM anyway but with the 
unidirectional flag (UDF) set which tells all other neighbors except node B 
to ignore the message. Just node B now has the possibility to consider node A 
as a bidirectional neighbor because node A has successfully rebroadcasted its 
own OGM. Does that make sense?

ciao,
axel


On Monday 09 July 2007 18:42, a.anselmi@oltrelinux.com wrote:
> I'm testing batmand 0.2 in two hardware-different nodes:
> 6.17.0.1/8 is a Fonera running its standard firmware
> 6.17.190.172/8 is a Fonera running Kamikaze
>
> >From kamikaze(d) node I see:
>
> Received BATMAN packet via NB: 6.17.0.1, IF: ath0 6.17.190.172 (from OG:
> 6.17.0.1, seqno 926, TTL 50, V 3, UDF 0, IDF 0)
> Creating new originator: 6.17.0.1
> schedule_forward_packet():
> Forward packet: rebroadcast neighbour packet with direct link and
> unidirectional flag
> Forwarding packet (originator 6.17.0.1, seqno 926, TTL 49) on interface
> ath0 Orginator timeout: originator 6.17.0.1, last_valid 0
> update_routes()
>
> but the same node, issuing the command "batmand -c -d 1 -b" tells me "No
> batman nodes in range".
> I'm afraid of the message "Orginator timeout: originator 6.17.0.1" in the
> above lines... is this the problem?
>
> --
> Antonio
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
