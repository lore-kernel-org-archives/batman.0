Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Sun, 11 Nov 2007 12:41:24 -0800
Message-ID: <840E3F681DF3D043B353C0FDD4A6C353ABFC97@ex9.hostedexchange.local>
In-Reply-To: <200711111816.18242.axel@open-mesh.net>
From: "Michael Burmeister-Brown" <mike@netequality.org>
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batmand crash / core dump
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

We are seeing a crash in batmand (beta, rv767-792) on kamikaze 7.09 /
atheros 2.6 / mips.

I am trying to get a core dump for Marek, but no file is created despite
doing ulimit -c 20000.

Does anyone know what must be done to get a core dump on this platform?

Thanks!

-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] On Behalf Of Axel Neumann
Sent: Sunday, November 11, 2007 9:16 AM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: Re: [B.A.T.M.A.N.] routing problem? / Changes in exp rv790

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
Is this what routing table 66 or table 65 tells you at node A and D.
Perhaps 
its easier if you just paste the command and output of the command which

revealed this information, might also simplify to find other reasons for

strange behavior.

In this sense, one question? Do you use different networks/netmasks for
the 
different links. Because this might be one reason for problems. 

The thing is:
when the batman network of node A is different from the batman networks
used 
by node D then D will not search its routing table 66 for the
appropriate 
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
destinations. And if D is searching for a destination in x.y.A.0/24 it
will 
not fit :-(. 

Anyway, because there has been so much confusion about this, i changed
this 
with exp 0.3 revision 790. The daemon now configures the critical rule
as:
6600:   from all lookup 66
No more restrictions for table 66. This should always fit.

Since revision 790, also the unreachable rule is omitted by default,
which has 
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
Why not? According to your setup, both routes would work. This would be
a 
typical case for asymmetric routing. But generally nothing speaks
against 
such a route.

ciao
/axel

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@open-mesh.net
https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

