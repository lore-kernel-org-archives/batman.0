Return-Path: <ordex@autistici.org>
Date: Fri, 27 Jan 2012 15:45:10 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120127144509.GC7367@ritirata.org>
References: <9AAB212A-A9C6-41CD-BACA-0BA1542FA8F5@net-forces.com>
	<201201270313.19652.lindner_marek@yahoo.de>
	<53319420-548B-407C-94EA-AD8BA1B3F73C@net-forces.com>
	<201201270445.50388.lindner_marek@yahoo.de>
	<4210BF92-C0BC-4862-9711-6F8214494082@net-forces.com>
	<20120127133529.GA7367@ritirata.org>
	<559EA128-76CA-4431-80B7-8ECB37D3CEB5@net-forces.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <559EA128-76CA-4431-80B7-8ECB37D3CEB5@net-forces.com>
Subject: Re: [B.A.T.M.A.N.] ap_isolation issue
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Jan 27, 2012 at 09:30:05AM -0500, Andre Courchesne wrote:
> Hi Antonio,
> 
>   Thanks for the reply. I will attempt these tests today and provide you as much feedback as possible.

Thank you. 

> 
>   We are using loop avoidance because in some (if not all) installations we will be doing there will be multiple AP wired to the same network to provide redundancy. And if we move to LoopAvoidance-II if I understand correctlt if should also provide bandwidth balancing correct ?
> 

it depends on what you mean. Incoming traffic will enter the LAN through the "best"
(depending on the TQ) node. While the current implementation, IIRC, provides
only one fixed entry point. But please, don't mix topic :)


Cheers,

> 
> On 2012-01-27, at 8:36 AM, Antonio Quartulli wrote:
> 
> > Hello Andre,
> > 
> > On Thu, Jan 26, 2012 at 04:46:44 -0500, Andre Courchesne wrote:
> >> Ok, did a bit of tcpdump and my test was the following:
> > 
> > [cut]
> > 
> >> 
> >> 
> > 
> > Thank you for reporting this issue and sending us the dumps.
> > Actually it is very hard to link the ap isolation mechanism to this problem.
> > 
> > First of all I would like to make a simple test. Please, could you use dump
> > packets received on T003 and see if the ARP request (the first one that receives no reply)
> > reaches the node (T003)?
> > 
> > In particular I would
> > suggest you to use wireshark (it can parse batman packets) and to sniff at the
> > same time packets either from the physical interface used by the mesh (I'd say wlan0)
> > and bat0.
> > 
> > Then tell us if you see the ARP request on both interfaces, on wlan0 only or on none 
> > of them.
> > 
> > 
> > Another question, why are you using the bridge loop avoidance? If possible I
> > would like you to disable any optional feature you have in order to have the
> > cleanest testbed possible. I know that you already tried to disable it without
> > effect, but it is better to perform test without any other "noise".
> > 
> > Cheers,
> > 
> > -- 
> > Antonio Quartulli
> > 
> > ..each of us alone is worth nothing..
> > Ernesto "Che" Guevara

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
