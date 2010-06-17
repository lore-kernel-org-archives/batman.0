Return-Path: <linus.luessing@web.de>
Date: Thu, 17 Jun 2010 17:19:52 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100617151952.GA23827@Sellars>
References: <201006171018.47209.clemens-john@gmx.de>
	<201006171220.03431.clemens-john@gmx.de>
	<20100617120708.GA23608@Sellars>
	<201006171619.49916.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201006171619.49916.clemens-john@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] MTU/connection problem
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

Hi Clemens,

wow, you're quick and eager, great spirit (woops, guess there is
too much soccer talking around here during these days again :D)!
Well, anyway, we'll get your setup fitting your needs, no worries
:). Therefore, what are your plans for 20.00 tonight yet?
It might be easier to discuss these things then via irc. Your goal
might also not be 100% clear yet and from my guesses so far 
at least three possible ways come to my mind and others might have
even different ideas for solutions :) (which are simpler than the
ones I usually come up with :P).
So chatting would be great to avoid misunderstandings. Marek
and me and probably some more would be there then.
> We tried tinc now, but the problem does still exist.
> Our Tinc config looks like this:
> 
> ----------
> root@OpenWrt:~# cat /etc/tinc/batvpn/tinc.conf 
> Hostnames=yes
> Mode=Switch
> name=floh1111
> ConnectTo=batgw
> #ConnectTo=harlingen
> -----------
> 
> Normal ping over vpn till package size 1453 works.
> If I increase the package size to 1454 ping fails.
> 
> All devices have an mtu of 1530 except bat0 and br-mesh which have an mtu of 
> 1500.
> Batman is running on the tinc device tap0 and our bridge looks like this:
> 
> ---------
> config 'interface' 'mesh'
>         option 'type' 'bridge'
>         option 'ifname' 'ath0 bat0'
>         option 'proto' 'static'
>         option 'ipaddr' '10.18.1.101'
>         option 'netmask' '255.255.128.0'
>         option 'mtu' '1500'
>         option 'dns'   '10.18.0.1 10.18.0.254'
> --------------
This feature of tinc only works on IP packets, not batman-adv
ethernetframes. Sorry for not stating that before, thought you'd
have a different / easier setup: sending ip packets over the vpn
and just bridging the clients into the same subnet (so bridging
ath0 + bat0 + tap0 and not adding tap0 into batman-adv). I think
in version 1.0.12 of tinc, you also still had to enable
PMTUDiscovery in the tinc.conf explicitly, also only 1.0.13 has a
working implementation of the TCP mss tempering.

Anyway, this or your current setup, they both have pros and cons
which we should talk about on irc, I guess :).

Cheers, Linus
> 
> If I decrease the mtu on the client that has no batman advanced to 1481, 
> everything works fine.
> 
> Think we need help again^^
> Clemens


