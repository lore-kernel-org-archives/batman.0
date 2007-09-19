From: elektra <onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] batman routing clarification
Date: Wed, 19 Sep 2007 19:07:41 +0200
References: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com>
	<200709191525.12422.onelektra@gmx.net>
	<17196.85.41.146.90.1190212517.squirrel@krisma.oltrelinux.com>
In-Reply-To: <17196.85.41.146.90.1190212517.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709191907.41922.onelektra@gmx.net>
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




> What above is well right using that bandwidht values (6Mb) but with
> poor/lossy links we have also to consider the IP datagrams loss at network
> layer ---> which will cause TCP retransmits at higher layers (think to
> http connection) just based on that links.
> For this reason maybe a kind of "bandwidth threshold" can help in
> preferring a 500_Kb per link mulit-hop path rather than a 300_Kb link
> direct path.

Well, you certainly have a point here. The goal of a routing protocol should 
be to achive the maximum achievable bandwidth for all nodes using the 
network. There is a fancy word for this condition that one can use to brag 
around and sound like a scientist: equilibrium.

A route can consist of a large number of very good links - this would be one 
extreme. Or consist of a minimum of lousy links with maximum packet loss. 
The first option would consume a very high amount of available bandwidth since 
there will be many retransimissions disturbing others and it is likely to be 
relatively slow if your machines use one wireless interface only. The latter 
is likely to be completely unusable for anything more than transfering a few 
bytes.

The protocol should find the most effective compromise, of course.

With OLSR and ETX a two hop route with ETX=1,1 on each link won't be used if 
there is a direct link with ETX=2,1. The idea of ETX is to find the best 
compromise regarding loss and retransmissions. One has to note that this 
approach is only useful for wireless networks. ETX on wired connections 
sucks.

We are doing basically the same with Batman, but it is inherit in the 
algorithm. Usually a shorter route has a smaller propagation delay - so 
packets are approaching faster at the node that is counting. Only if the 
longer - and slower - route looses significant less packets Batman will 
choose the longer path. Batman has a small benefit on wired connections 
because they are usually much faster than wireless links and thus tend to be 
preferred.

In the previous example OLSR will prefer a single hop route with more than 50% 
packetloss, rather than the two-hop path with approx. 17% packetloss. 

There are some people suggesting that Batman preferres shorter routes too 
much, so it is interesting to collect such reports. But misconfigurations 
have to be ruled out when collecting such data. 

Something that could help to improve the situation as a workaround in this 
case is to increase the broadcast rate in the wireless settings of the cards. 
This will reduce the range of broadcasts and can improve the result, because 
the number of OGMs on stretched links will decrease.

cu elektra
