Return-Path: <linus.luessing@web.de>
Date: Fri, 18 Jun 2010 14:39:27 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100618123927.GB25419@Sellars>
References: <201006171018.47209.clemens-john@gmx.de>
	<4C1B4F52.2020002@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4C1B4F52.2020002@rsm-freilassing.de>
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

On Fri, Jun 18, 2010 at 12:49:54PM +0200, Michael Rack wrote:
>  I've read the complete topic, but dont't know if your problem is solved.
> 
> You're right. The MTU is your Problem. And when i read your post, it
> was clear for me, that your problems results on your VPN Connection.
> 
> You need to do some MSS stuff on your OpenWRT Router.
> 
> /sbin/iptables -t mangle -A forward -i tap0 -p tcp -m tcp
> --tcp-flags SYN,RST SYN -m tcpmss --mss 1381:65535 -j TCPMSS
> --set-mss 1460
> /sbin/iptables -t mangle -A forward -o tap0 -p tcp -m tcp
> --tcp-flags SYN,RST SYN -m tcpmss --mss 1381:65535 -j TCPMSS
> --set-mss 1460
Actually, this is pretty much what tinc is doing in switch mode
with pmtu-discovery enabled in the config on tap0 automatically,
dynamically - no need for iptables then. There are three problems
with this: a) it only affects TCP and does not help with UDP yet
(though tinc is desipte the mss tempering also faking "ICMP packet
too big" messages). And b), I think he's bridging at the moment
(though this needs to / should be clarified tonight) and not doing
any routing over tap0, so simple iptables won't be enough for that.
And c), I think at the moment he's not actually sending pure IP
packets over tap0, so no tcp mss to temper with (again, should
check that tonight and avoid playing ping pong with throwing
guesses over the mailing list :) ).

Despite that, thanks for your suggestions (no offense ment :) ). I
agree with you, it's definitely a MTU problem.

Cheers, Linus
> 
> And all your problems are gone :-D
Unfortunately, usually a little more tricky when dealing with
layer 2 ;).
> 
> Liebe Grüße aus Freilassing,
> 
> Michael Rack
> RSM Freilassing
> -- 
> RSM Freilassing                 Tel.: +49 8654 607110
> Nocksteinstr. 13                Fax.: +49 8654 670438
> D-83395 Freilassing            www.rsm-freilassing.de
> 
> 
> Am 17.06.2010 10:18, schrieb Clemens John:
> >Hi,
> >
> >I have a problem to connect to the Internet. We are using Batman advanced
> >0.2.1 and IPv4 here in oldenburg. Our setup looks like this:
> >
> >Laptop-[wifi]->Fonera-[wifi]->Dir300-->OpenVPN-->
> >virtual OpenWrt machine-->internet.
> >
> >The default route of the laptop goes to the virtual OpenWrt machine wich
> >provides an Internet connection.
> >
> >I can acces google (wget google.de) but not heise.de or golem.de. I´m not
> >verry familar with network configurations but I heared that this might be an
> >mtu problem.
> >
> >All devices in the network (tap0, ath0, ath1, wifi0) have an mtu of 1524 except
> >bat0 and br-mesh which have an mtu of 1500.
> >
> >Our routers are configured to bridge connections from non batman devices (like
> >the laptop) to bat0. This is done in the device "br-mesh".
> >
> >Everythink works fine, except I can´t connect to internet websites that are not
> >google.de.
> >
> >When I decrease the mtu of the wireless device of the laptop to 1476
> >everything works fine.
> >But I have to do this by hand and on a client this is bad.
> >
> >Does anybody know what I´m doing wrong?
> >
> >Greetings
> >Clemens
> 
