Return-Path: <linus.luessing@web.de>
Date: Mon, 4 Jan 2010 22:45:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100104214544.GA20853@Sellars>
References: <201001042344.02273.lindner_marek@yahoo.de>
	<591bc9931001041223m13d96837o4d4f95afa08e42e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <591bc9931001041223m13d96837o4d4f95afa08e42e2@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi,

despite the general, internal filtering rules it would be great to
be able to fetch the best gateway (the gateway with the best
BTM-TQ value) via /proc. So people would have the chance to use
the basic gatewaying feature with just a switch in batman-adv,
while people that want to do more complex filtering could fetch it
from /proc and use ebtables on top for example. Maybe even a
sorted list of all gateways in /proc would be nice to be able to
set up some more advanced (fall-back) scenarios with other
measuring methods/tools. And on the other hand we'd have the
possibility of batman-adv not interfering too much with the other
layers, instead tools explicitly designed for layer 2, 3, ...
have an interface to fetch the gateway information then which only
batman-adv knew before.
I think I've been talking about this partly with Marek a couple of
weeks ago before.

Cheers, Linus

On Tue, Jan 05, 2010 at 09:23:42AM +1300, Donald Gordon wrote:
> Hi
> 
> On Tue, Jan 5, 2010 at 4:44 AM, Marek Lindner <lindner_marek@yahoo.de>wrote:
> 
> >
> > * The third patch checks whether locally received packets are DHCP queries
> > and
> > forwards them via uncicast to the best gateway instead of broadcasting
> > them.
> >
> > Would it be possible to decide via a more general mechanism, maybe via a
> BPF filter, which packets get sent to the gateway?  For instance, it would
> be nice to be able to say that all ARP requests for *.*.*.1 also got sent to
> the gateway direct :-)  This would also make adding IPv6 support trivial,
> it'd just be another (or a more complex) BPF filter.
> 
> donald

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

