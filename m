Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 27 Apr 2019 04:38:49 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190427023848.GK6201@otheros>
References: <20190426171231.18156-1-linus.luessing@c0d3.blue>
 <1906609.VMlLDzDynG@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1906609.VMlLDzDynG@rousseau>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce "noflood"
 broadcast flood prevention option
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sat, Apr 27, 2019 at 05:56:03AM +0800, Marek Lindner wrote:
> On Saturday, 27 April 2019 01:12:31 HKT Linus Lüssing wrote:
> > With DAT DHCP snooping, the gateway feature and multicast optimizations
> > in place in some scenarios broadcast flooding might not be strictly
> > necessary anymore to be able to establish IPv4/IPv6 communication.
> > Therefore this patch adds an option to disable broadcast flooding.
> > 
> > Larger mesh networks typically filter a variety of multicast packets via
> > ebtables/netfilter to clamp on overhead. With this option such firewall
> > rules can be relaxed so that such multicast packets are only dropped
> > if they cannot be handled by multicast-to-unicast, for instance.
> 
> Could you outline the use-case for this specific noflood option in more detail ?
> The description above is not entirely clear to me. Especially, the 'might not 
> be strictly necessary anymore' to 'firewall rules can be relaxed'. How are 
> these things connected ? Is this option implemented only, so that some firewall 
> rules don't need to be set anymore ?

The main use-case I currently have in mind is safely enabling multicast in
larger, public mesh networks:

Currently we have firewall rules in Gluon to drop most multicast.
With multicast-to-multi-unicast we could in theory use multicast
without creating broadcast overhead for the whole mesh. However
only until we hit the multicast_fanout threshold. Then things
would get flooded again.

The desired behaviour in this case would be to let multicast packets pass
unless they would be flooded. A firewall does not know which
mechanism batman-adv would choose. Hence this option within
batman-adv to create this desired behaviour.


With "might not be strictly necessary anymore" I ment that if
certain requirements are met that address assignments and address
resolution can now be achieved without needing broadcast flooding.


> What happens if a user enables 'noflood' but does not fall into the 'might not 
> be strictly necessary anymore' category ?

Well, broken connectivity. Typing "ip link set dev eth0 multicast off"
in a setup which still needs multicast to function would be an
analogy then :).

Regards, Linus
