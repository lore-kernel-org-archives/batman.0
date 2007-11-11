From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] routing problem?  / Changes in exp rv790
Date: Sun, 11 Nov 2007 18:16:18 +0100
References: <2bda28cd0711090623r2e7b8750g558aebab35247da0@mail.gmail.com>
	<200711101243.28980.axel@open-mesh.net>
	<2bda28cd0711110755u7d78282x169f21e2698b5af1@mail.gmail.com>
In-Reply-To: <2bda28cd0711110755u7d78282x169f21e2698b5af1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711111816.18242.axel@open-mesh.net>
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

Hi

> Now I have other question about routing...
>
> I have 4 nodes: A,B,C and D
>
>
> A-------B-------D
>  \-------C-------/
>
> fromA> D via B dev ath0 proto static
> fromD> A via C dev ath0 proto static
I have difficulties to clearly understand the last two lines.
Is this what routing table 66 or table 65 tells you at node A and D. Perhaps 
its easier if you just paste the command and output of the command which 
revealed this information, might also simplify to find other reasons for 
strange behavior.

In this sense, one question? Do you use different networks/netmasks for the 
different links. Because this might be one reason for problems. 

The thing is:
when the batman network of node A is different from the batman networks used 
by node D then D will not search its routing table 66 for the appropriate 
route to node A. Even if the correct route form D to A is listed by the 
command: ip r ls t 66

The problem are the rules which are configured by the batman daemon.
The command: "ip rule" on node D might show something like:
0:      from all lookup local
6599:   from all lookup 65
6600:   from all to x.y.D.0/24 lookup 66
32766:  from all lookup main
32767:  from all lookup default

while on node A it might show the same except for one line:
6600:   from all to x.y.A.0/24 lookup 66

Rule 6600 tells the network layer to only search table 66 for certain 
destinations. And if D is searching for a destination in x.y.A.0/24 it will 
not fit :-(. 

Anyway, because there has been so much confusion about this, i changed this 
with exp 0.3 revision 790. The daemon now configures the critical rule as:
6600:   from all lookup 66
No more restrictions for table 66. This should always fit.

Since revision 790, also the unreachable rule is omitted by default, which has 
been another reason for confusion.

If you (or others) want to have back the old unreachable rules or the 
restrictive mask for table 66, the daemon may be started with the 
--more-rules switch.


>
> When A talk to D choose B while when D talk to A choose C.
> In this scenario node D can't talk to A for example with ping.
does ping really not work?
>
> Is correct this type of routing?
Why not? According to your setup, both routes would work. This would be a 
typical case for asymmetric routing. But generally nothing speaks against 
such a route.

ciao
/axel

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


