From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
Date: Tue, 6 Nov 2007 09:15:59 +0100
References: <000b01c81ff0$d7ed14b0$87c73e10$@com>
In-Reply-To: <000b01c81ff0$d7ed14b0$87c73e10$@com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711060915.59594.axel@open-mesh.net>
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
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello

On Montag 05 November 2007, Predrag Balorda wrote:
> My test setup comprises 3 dual-radio (a and bg) units running openwrt
> kamikaze 7.09.
>
> For some reason (or another?) my middle unit keeps re-creating the gate0
> every few seconds. Sometimes it loses it completely and sometimes it keeps
> it for 10 seconds or so. The furthest node from the gw keeps it's tunnel
> permanently configured (which is nice).

One question, does the middle-unit batman operate on two interfaces while the 
futhest node (with the stable tunnel) operates on one interface only?

Can you give some more informations about your setup? It sounds like you have 
three nodes with the middle unit having two interfaces and the others maybe 
only one. All are operating in the same netmask but have individual IP 
addresses for each interfaces?

>
> Basically, node-to-node traffic is ok, very stable and very nice but
> node-through-gw is flaky.
>
> This above is with bg-only radios.
>
> Also I have tried using a dual-radio setup. I have tried to set bg-radios
> to one subnet and a-radios to a different one, I have also
> Tried setting them all on the same subnet but all hell breaks loose.
The latter configuration is the usual one. All interfaces in the same 
subnet/netmask. This is the default setup which "should?!" work out of the 
box.

The non-usual setup: you have different parts of your mesh operating in 
different subnets you need an additional ip rule to make the nodes in the 
non-homed subnet reachable from a node which has no interface in that subnet. 
So for example, if your setup looks like:
     A---------------------B1_B2---------------C
10.0.0.1/24       10.0.0.2/24 10.0.1.2/24  10.0.1.3/24   

the easiest way to do achieve that at A and C is:
$ ip rule add from all pref 6500 t 66

$ ip rule
at A should then show (among others) the following line:
6500:   from all lookup 66


Also check if you can see any 
$ ip rule 
output at all. The (actually obligatory) advanced routing capabilities are NOT 
enabled in all linux systems. 


> I 
> don't know if it's loops or what but it doesn't seem usable to me.
>
>
> Yes I know I'm playing with 0.3beta and exp 
Is exp showing up the same problems?

> but I believe this would be a 
> far more usable setup than olsr 5.3 that I also tried.
maybe check 5.4. Because I think that the improvements from 5.3 to 5.4 are 
huge, but also because I am always interested in the concrete pros and cons 
that people observe between the latest olsr/batman state-of-the art.


ciao,
axel

>
> Any help appreciated in solving this issue.
>
> Pele
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


