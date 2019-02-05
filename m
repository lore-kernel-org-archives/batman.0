Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 5 Feb 2019 20:24:10 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190205192409.GF777@otheros>
References: <20190119155626.6414-1-sven@narfation.org>
 <1895931.G10psR3j26@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1895931.G10psR3j26@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
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
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>

On Sat, Jan 26, 2019 at 11:47:20AM +0100, Sven Eckelmann wrote:
> On Saturday, 19 January 2019 16.56.07 CET Sven Eckelmann wrote:
> [...]
> > There were also two topics which were not yet really discussed and thus
> > these requests (from Linus) were not yet implemented:
> 
> @Jiri, @Linus maybe you can discuss these topics further and select the 
> correct solution.
> 
> > * convert BATADV_ATTR_MULTICAST_MODE_ENABLED to an u32 and let don't handle
> >   it like a boolean. Instead use it to select how multicast traffic has to
> >   be handled:
> >   
> >   - 0: ignore multicast optimization and just flood it like broadcast
> >     traffic
> >   - 1: enabled multicast optimization
> >   - 2: undefined but also some kind of multicast optimization
> >   - 3: undefined but also some kind of multicast of optimization
> >   - ...
> 
> Multicast mode is currently defined.
> 
> * according to batctl manpage:
> 
>     multicast_mode|mm [0|1]
>            If no parameter is given the current multicast mode set‐
>            ting is displayed. Otherwise the parameter is used to en‐
>            able or disable multicast optimizations (i.e. disabling
>            means always sending own multicast frames via classic
>            flooding).
> 
> * according to sysfs ABI:
> 
>    What:           /sys/class/net/<mesh_iface>/mesh/multicast_mode
>    Date:           Feb 2014
>    Contact:        Linus Lüssing <linus.luessing@web.de>
>    Description:
>                    Indicates whether multicast optimizations are enabled
>                    or disabled. If set to zero then all nodes in the
>                    mesh are going to use classic flooding for any
>                    multicast packet with no optimizations.
> 
> Both define it as boolean value and therefore it was converted to a boolean 
> value (via u8) in netlink.
> 
> But Linus now suggested that it is actually an u32. Most likely 0 == to 
> something like BATADV_MULTICAST_MODE_FLOODING. But I have no idea what 1 is or 
> what 2, 3, 4, .. would be. So I need some input here.

Right, 0 would be flooding. 1 is the current multicast-aware multi-to-single-unicast
conversion mechanism, which would be extended to a multi-to-multi-unicast mechanism
with the last multicast related patch to the batman mailing list.

In this particular case there is no need to assign a new
multicast_mode == 2, because the old approach can be achieved
again by setting multicast_fanout to 1.


After the multi-to-(multi-)unicast conversion mechanism the next
simple step I would have in mind would be adding a "struct
batadv_mcast_packet". Which would basically behave similar to a
normal batadv_unicast_packet, but would be able to hold a flexible
amount of destination addresses.


And then there was the old tracker packet idea which could come
after that.

And then, recently a source-specific-multicast, reverse tracker
packet approach was discussed. Which would have yet another magnitude
of complexity. But would have very compelling scalability properties.


From a user perspective, once someone relies on some degree of
multicast capabilities and if a new mechanism somehow fails for
the user (for instance a bug or special topology properties), it
might not be feasible to go back to flooding. For instance, let's
say with multicast-to-multi-unicast a Freifunk-like network were now
able to scale to 1500 nodes. And now we introduce some new
enhancements/mechanisms for multicast and things break. Then
flooding would likely leave a broken/unusable network for them
too, due to congestion.

Maybe seeing "multicast_mode" as a gear shift would be an analogy?


> And Jiri said that it should be renamed to BATADV_ATTR_MULTICAST_ENABLED -
> which seems to suggest that he doesn't like the idea of a u32 for some reason
> and prefers to use a boolean value.
> 
> And now Linus even said that it should be a bit field - which makes it even 
> more vague to me and I have now absolutely no idea what should be implemented.
> 
> * BIT 0 for flooding vs ?

Flooding would always be available.

BIT 0: Enable multicast-to-(multi-)unicast
BIT 1: Enable multicast-packet-type
BIT 2: Enable multicast-tracker-packets
BIT 3: Enable ssm-multicast-tracker-packets
...

The thing is, these mechanisms do not necessarilly have to be
exclusive. For instance, the tracker packet mechanism needs to
propagate the tracker packets for a second or so first before it
can be safely used for multicast data packets. In the mean time we
could either flood or buffer the packet. Or we could send them via
multicast-to-multi-unicast.

Hm, but maybe this is getting too flexible. If multicast_mode == n
would mean that all features 0 <= n are available would be fine,
too, I think.


Another thought, if all this is too vague for now... what about
ommiting the BATADV_ATTR_MULTICAST_(MODE)_ENABLED for now and use
a reverse logic instead? Like
BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, defaulting to false.
That still leaves the opportunity to add a BATADV_ATTR_MULTICAST_MODE
option or BATADV_ATTR_MULTICAST_FEATURES bitset later when we have
actual code needing it.

(btw., is there a general preference in netlink towards either
grouping things in bitfields or individual _ENABLED attributes?)

Regards, Linus
