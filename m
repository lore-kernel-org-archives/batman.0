Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 15 Feb 2019 18:45:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190215174544.GC1472@otheros>
References: <20190214155100.10070-1-linus.luessing@c0d3.blue>
 <2119814.DADNbvlFmJ@rousseau> <20190214174913.GB1602@otheros>
 <1b6712e2-92a2-06c1-6545-47dedea57065@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b6712e2-92a2-06c1-6545-47dedea57065@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: allow snooping gratuitous
 ARP Replies
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
Cc: Daniel Ehlers <sargon@toppoint.de>

Hi Antonio,

On Fri, Feb 15, 2019 at 04:36:08PM +1000, Antonio Quartulli wrote:
> Is there any situation where an OS would reject a gracious ARP? Or are
> they always blindly accepted and processed accordingly?
> If they have any protection against any misuse, I guess batman-adv
> should try to do the same.

I have played some more with gratuitous ARPs and this is what I
could find out:

sysfs, /proc/sys/net/ipv4/conf/<iface>/*arp*:

drop_gratuitous_arp = 0 (default)
arp_accept = 0 (default)
-> no new address added via gratuitous ARP
   cmp.: https://elixir.bootlin.com/linux/v4.20.10/source/net/ipv4/arp.c#L872
-> but existing entries are updated

drop_gratuitous_arp = 1:
-> grat. ARP ignored completely
   cmp.: https://elixir.bootlin.com/linux/v4.20.10/source/net/ipv4/arp.c#L776

drop_gratuitous_arp = 0 (default)
arp_accept = 1
-> grat. ARP Reply updates existing entries and creates new ones


Also, I noticed that using a zero MAC address for the ethernet header
destination did not work. Even if setting promisc-mode on the veth
in its extra network namespace interface, the neighbor table would
not be populated. Using the broadcast MAC for the ethernet header
(and arp_accept = 1) worked, though. But would defeat the idea
of using gratuitous ARP to populate the DHT without flooded
messages. I wasn't able to spot where the ethernet destination is
checked yet.

Regards, Linus
