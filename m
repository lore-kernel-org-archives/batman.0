Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 30 Dec 2018 15:51:33 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181230145133.GA4150@otheros>
References: <20181229031040.7207-1-linus.luessing@c0d3.blue>
 <1976755.cJCZaRukfj@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1976755.cJCZaRukfj@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v7] batman-adv: Snoop DHCPACKs for DAT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sun, Dec 30, 2018 at 02:51:12PM +0100, Sven Eckelmann wrote:
> On Saturday, 29 December 2018 04.10.40 CET Linus Lüssing wrote:
> > +#define BATADV_DHCP_YIADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
> > +#define BATADV_DHCP_CHADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->chaddr)
> 
> Why do you use chaddr to calculate the size of yiaddr? yiaddr is only 4 byte 
> and chaddr is 16 byte. Looks to me like you have a potential stack overflow in 
> batadv_dat_dhcp_get_yiaddr because of that.

Urgh... three memory issues fixed, one new one introduced, yaiy...
thanks!

> And you have a lot of code which calls skb_header_pointer again and again + a 
> lot of offset calculations. So it has to potentially traverse all the 
> fragments again and again. I have seen:
> 
> * op
> * htype
> * hlen
> * magic
> * TLV options parts
> * yiaddr
> * chaddr
> 
> Do you see any potential in combining some of them in batadv_dat_check_dhcp 
> (e.g. op, htype, hlen)?

Good question. The advantage of the current approach is that the
extra buffers _op, _htype and _hlen actually would not be used because a
single byte itself has no fragmentation or alignment issues. So no
copying needed, we should always get a pointer right into the
skb data/fragments.

On the other hand, a few copying instructions is probably less
overhead than traversing fragments multiple times. I'll change that.

[...]
> There seems to be a missing "*" in the line before the line "Caller needs to 
> ensure that the skb network header"

ok

> 
> 
> Missing header in distributed-arp-table.c:
> 
> * asm/unaligned.h

ok

> 
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> [...]
> > @@ -42,9 +43,11 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/stddef.h>
> >  #include <linux/string.h>
> > +#include <linux/udp.h>
> >  #include <linux/workqueue.h>
> >  #include <net/arp.h>
> >  #include <net/genetlink.h>
> > +#include <net/ip.h>
> >  #include <net/netlink.h>
> >  #include <net/sock.h>
> >  #include <uapi/linux/batman_adv.h>
> 
> And "net/ip.h" also doesn't seem to be used in distributed-arp-table.c

Right, not needed anymore after replacing ip_hdrlen(skb) with
iphdr->ihl * 4 in v7.

> 
> 
> 
> But the biggest problem is that it doesn't build:
> 
>     /usr/bin/make -C /home/build_test/build_env/linux-build/linux-4.9.148 M=/home/build_test/build_env/tmp.9CjwRXIj4f PWD=/home/build_test/build_env/tmp.9CjwRXIj4f REVISION= CONFIG_BATMAN_ADV=m CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_TRACING=y CONFIG_BATMAN_ADV_BATMAN_V=y INSTALL_MOD_DIR=updates/  modules
>     [...]
>     /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c:1046:17: error: undefined identifier 'batadv_dat_snoop_incoming_dhcp_ack'
>     /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c:1283:9: error: undefined identifier 'batadv_dat_snoop_incoming_dhcp_ack'
>     /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c: In function ‘batadv_recv_unicast_packet’:
>     /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c:1046:3: error: implicit declaration of function ‘batadv_dat_snoop_incoming_dhcp_ack’ [-Werror=implicit-function-declaration]
>        batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
> 
> Looks like distributed-arp-table.h is missing a stub function for 
> batadv_dat_snoop_incoming_dhcp_ack when CONFIG_BATMAN_ADV_DAT is not set.

ok
