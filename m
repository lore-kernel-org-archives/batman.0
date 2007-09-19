From: elektra <onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] batman routing clarification
Date: Wed, 19 Sep 2007 15:25:12 +0200
References: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com>
In-Reply-To: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709191525.12422.onelektra@gmx.net>
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

Hi -

which version of batman are you using? And you should provide us with more 
details. Just saying Link is 'poor' or 'good' is very unprecise. Remember: A 
direct route with 6 Megabit performs similar to a two-hop link with 12 
Megabits on each link, since no retransmissions have to be made.

If you set the routes manually, it would be interesting to know the transfer 
performance of the following: 

A->C
A->B
A->B->C
C->A
C->B
C->B->A
 

How many OGMs does A count directly from C and via B? (And vice versa)
By the way: -o 3000 is quite slow for sending Originator messages if you have 
20 nodes only. The default should be fine.

cu elektra
 


> I am switching a 20 mesh node from olsrd but I have some problem in
> routing. I have no gateway node because I use openvpn to have a tunnel with
> PC. All nodes have:
>   batman -g 0 -r 3 -o 3000 <interface>
>
> node C has:
>   batman -g 0 -r 3 -o 3000 -a 10.0.0.0/24 <interface>
>
> I have several case like this:
>
> A----good----B----good-----C-----10.0.0.0/24----PC
> \---------------poor-------------/
>
> three node can communicate with all others but radio link from A to C is
> poor.
>
> When node A want to communicate to node C it goes directly to C because
> batman calculate a direct route to it.
> But if I manually set routes to use node B connection from A to C is good.
>
> What is my mistake?
>
> -r parameter in batmand daemon works only in searching gateway node? ...or
> it works every time, also with normal node?


