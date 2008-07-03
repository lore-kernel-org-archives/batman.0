From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN Gateway
Date: Thu, 3 Jul 2008 16:47:14 +0200
References: <4864DD02.20209@csp.it> <20080702130116.GA28427@hrz.tu-chemnitz.de>
	<486CD741.3050008@csp.it>
In-Reply-To: <486CD741.3050008@csp.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200807031647.18156.sven.eckelmann@gmx.de>
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

On Thursday 03 July 2008 15:42:25 cipollone wrote:
> I want to know how work and what I have to configure the kernel module
> of BATMAN Gateway.
Hm, I am not really sure if I understood it right - you want to use batman 
advanced to access another network (internet....), correct?
Just insmod it everywhere, add  outgoing interface to /proc/net/batman-
adv/interfaces and let one machine (router to the internet for example) play 
the dhcpd. This machine should only deliver new ip addresses to the other 
machines and inform everyone else that they should use his ip as default 
router. Then you must know if you want to use it as nat or as normal router ( 
just enable ipv4_forward).
So it is just the same procedure as building a normal openwrt router/gateway 
with the small difference that all "clients" are talking over the bat0 
interface instead of the wlanX/ethY interface. It is nearly the same as 
configuring a normal openwrt. So parts of 
http://wiki.openwrt.org/OpenWrtDocs/Configuration can be used.

Setting up the wifi should be the same as always:
wlanconfig ath0 create wlandev wifi0 wlanmode adhoc
iwconfig ath0 essid testnet
iwconfig ath0 ap 02:00:de:ad:be:ef
iwconfig ath0 channel 10
ifconfig ath up
insmod batman-adv-core
echo "ath0" > /proc/net/batman-adv/interfaces

(maybe I got it right... don't have the hardware to test it now).

> I'm using OPENWRT and I haven't found paper that
> describe this kernel module (usage, configuration, how work).
http://tinyurl.com/6dbws8
But I am relative sure that you have read it because you have reported a bug 
when somebody tries to add new interfaces to /proc/net/batman-adv/interfaces.

Please ask a little more specific if I didn't answer your question. And feel 
free to write your setup down (small howto or so) so other people can access 
you knowledge afterwards (maybe marec can add it to the trac wiki).

Sven
