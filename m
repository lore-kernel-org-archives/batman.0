Return-Path: <abolletta@netter.io>
MIME-Version: 1.0
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
 <CADJ1cUSum9bHHBZB3gKdXukoqqDxk_f2nO38YKEDjvyHs0=qXA@mail.gmail.com>
 <38142483.hY40ij8To5@ripper> <2590739.vkdJLyYtQh@ripper>
In-Reply-To: <2590739.vkdJLyYtQh@ripper>
From: Alessandro Bolletta <abolletta@netter.io>
Date: Fri, 11 Sep 2020 15:46:17 +0200
Message-ID: <CADJ1cUSZoW_ik=AFm8+LHY2eavo+i00=TFWmDKZnjXkbz6_JGg@mail.gmail.com>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

I see.
Ok for transmission purposes, but what if I want to receive a tagged
ethernet frame coming from the batman network?
Should I must only rely to the related 802.1q interface (eg. bat0.1)
or can I receive the whole traffic (untagged and tagged) from the
plain bat0 interface, just listening for the incoming traffic on it?
If the answer is the first choice, is it possible to have an approach
where I can receive coming from bat0 leveraging on a single interface
anyway? Could a linux bridge br0 on the top of bat0 interface make it
possible?
For example, if I connect an openvswitch port configured as trunk to a
linux bridge br0 that enslaves bat0, could I expect to see the whole
traffic inside the batman-adv mesh network (so I mean, both tagged and
untagged traffic) also flowing inside the OvS switch?
Is there also a wait to get rid of the linux bridge br0?

Thank you.

Il giorno ven 11 set 2020 alle ore 14:50 Sven Eckelmann
<sven@narfation.org> ha scritto:
>
> On Friday, 11 September 2020 14:48:19 CEST Sven Eckelmann wrote:
> > On Friday, 11 September 2020 14:19:59 CEST Alessandro Bolletta wrote:
> > > So you mean that it is not feasible to create a (single) linux network
> > > interface that let me send traffic on the batman-adv network in an
> > > untagged or tagged way, though the same interface I mean?
> >
> > batman-adv is depending on the Linux code telling it what VLAN it should
> > handle (through ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid). So something
> > like the 8021q driver or the bridge code for vlans. Only when this was done,
> > it will also handle the addresses in TT. So no, bat0 is not enough to
> > transport something like an ethernet frame tagged as vlan1. You also need
> > bat0.1 (assuming this is the vlan interface for VID 1). But it is then not
> > really relevant for it whether the data was send through bat0.1 or was somehow
> > else tagged and then put into bat0.
>
> Btw. why are you now using VLANs on top of bat0 - weren't you trying before to
> have multiple mesh clouds by using VLAN (or VLAN-like) technologies below
> bat0?
>
> Kind regards,
>         Sven
