Return-Path: <ordex@ritirata.org>
MIME-Version: 1.0
Date: Thu, 13 May 2010 16:38:37 +0000
From: Antonio Quartulli <ordex@ritirata.org>
In-Reply-To: <21142356.1006178.1273698170378.JavaMail.fmail@mwmweb072>
References: <20100508170755.GA27599@ritirata.org>
	<201005100147.59454.lindner_marek@yahoo.de>, 
	<20100510115755.GA2510@ritirata.org>
	<21142356.1006178.1273698170378.JavaMail.fmail@mwmweb072>
Message-ID: <f31ad2968a9884d5bda6eebde3a01b21@localhost>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [B.A.T.M.A.N.] Blocking OGMs from a node for testing purpose
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


Hi Linus,

thank you for your time spent on my problem :)

The problem seems to be that iptables filters only packets that are sent
to IP layer and over..so any packet
intended for a protocol living on a layer lower than IP is not recognized
(e.g. batman frame).

Ebtables instead works only on eth bridges...I tried it because I thought
that bat0 was acting like a bridge indeed
but this is not the case...The only solution I thought could be this:
create a bridge-if br0, attach wlan0 to it and then 
attach br0 to bat0 and then you could let ebtables work between wlan0 and
br0....maybe it could work...
But attaching a wlan-if to a eth-bridge-if is not actually possible.

So it seems that batman-adv is too clever for us :P

Regards,

On Wed, 12 May 2010 23:02:50 +0200 (CEST), Linus Lüssing
<linus.luessing@web.de> wrote:
> Hi Antonio,
> 
>>Then I tried to block any kind of packets from a known mac (say MACa).
>>
>># ebtables -A INPUT -s MACa -j DROP
>>
>>After this I checked with "battctl o" if I was still able to see the
>>other host, and even waiting a few minutes, the host was still in the
>>list.
> 
> I tried it on two routers with ebtables and iptables here, too. I fired
> away all (redundant and like the forwarding stuff usually even useless)
> commands that came to my mind that could possibly block ANY traffic at
all:
> ---
> ebtables -A INPUT -j DROP
> ebtables -A OUTPUT -j DROP
> ebtables -A FORWARD -j DROP
> ebtables -t broute -A BROUTING -j DROP
> ebtables -t nat -A PREROUTING -j DROP
> iptables -I INPUT -m physdev --physdev-is-in -j DROP
> iptables -I OUDPUT -m physdev --physdev-is-out -j DROP
> iptables -I FORWARD -m physdev --physdev-is-brigded -j DROP
> ---
> Of course, no ssh connection and stuff like that and basically no other
> communication got through... despite batman-adv's OGMs and batping
packets,
> looking at that over a serial console! So it looks like batman-adv is
> getting hold of the OGMs before any filtering rules of the
> iptables/ebtables modules can get hold of them.
> 
> Additionally, the iptables/ebtables packet counts didn't seem to
recognise
> any packets. 
> 
> So it looks like either this is intended and batman-adv is also a very
> stealthy super-trojan (but couldn't find any proof for this in the
source
> code yet ;) ) or batman-adv is just mistakenly catching them (and maybe
> even dropping them although the skb-copy should prevent this?) before
the
> kernel or any other (filtering) kernel modules could have a glance at
them.
> 
> I'm sorry having said that this should work on IRC before, but filtering
> (even bridged) arp/ip-packets over bat0 works like a charm - hadn't
tried
> filtering raw batman-adv ethernet frames yet.
> 
> Cheers, Linus
> ___________________________________________________________
> GRATIS: Movie-Flat mit über 300 Top-Videos. Für WEB.DE Nutzer
> dauerhaft kostenlos! Jetzt freischalten unter http://movieflat.web.de

-- 
Antonio Quartulli

Ognuno di noi, da solo, non vale nulla
Ernesto "Che" Guevara
