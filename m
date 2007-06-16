From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] dynamic network annoucments
Date: Sat, 16 Jun 2007 11:05:23 +0200
References: <4672C430.1020208@poelzi.org>
In-Reply-To: <4672C430.1020208@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200706161105.23131.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Friday 15 June 2007 18:54, Daniel Poelzleithner wrote:
> Hi,
>
> another feature i forgot in the last mail :)
>
> It would be great if batman allows to dynamic add and remove announced
> networks via the unix socket interface.
>
> for example
> # adds new announced network
> batmand -c -a someip/mask
> # removes some announced network
> batmand -c -A someip/mask

I agree, and in terms of implementation complexity it shouldnt be too 
difficult. At least less painfull than dynamically adding and removing 
network interfaces.
BTW: you can issue a ticket in TRACK ( 
https://dev.open-mesh.net/batman/newticket ) so that its not forgotten too 
fast and somebody is using this fancy tool.


>
> why ?
> we are working on the posibility to give a computer in the mesh a unique
> ip, besides the network the node is serving. if you assign a unique ip
> to a computer, and get a dhcp lease of another node, the node would then
> add your ip as a hostroute announcement to batman, which would overwrite
> the default place: your home network. this would mean real mobile ip
> without the overhead of sending the traffic to your home router and then
> forward to your actual position.
Thats interesting but seems too complex for me, can you explain the approach 
in more detail.

From my understanding, Mobile ip means that a node is reachable by a unique 
and not-changing IP address and independent from the current point of 
attachment to an access network. I do not understand how your mobile node can 
maintain TCP scessions with corresponding nodes in the GBI while switching 
the MESH-GBI GW. 

ciao,
axel

>
> besides this, it would allow better integration into bgp by simply
> spawning a script to add/remove routes via zebra.
>
> kindly regards
>   daniel
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

