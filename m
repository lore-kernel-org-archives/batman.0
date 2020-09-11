Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
 <CADJ1cUSum9bHHBZB3gKdXukoqqDxk_f2nO38YKEDjvyHs0=qXA@mail.gmail.com>
 <38142483.hY40ij8To5@ripper> <2590739.vkdJLyYtQh@ripper>
In-Reply-To: <2590739.vkdJLyYtQh@ripper>
From: dan <dandenson@gmail.com>
Date: Fri, 11 Sep 2020 07:25:17 -0600
Message-ID: <CAA_JP8URSGzzCRqG4wrOB585PqXyMud2AA8w0W1SAstxeHtYhg@mail.gmail.com>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I see value in both methods, but for my use case I'm most interested
in bat0 as the 'fabric' so the batman-adv nodes don't need any
additional configuration to carry the VLANs.

so, based on the previous statement, is the way to make bat0 agnostic
about VLANs to create a bridge br0 and put bat0 in br0 and then make a
br0.10 vlan interface?


On Fri, Sep 11, 2020 at 6:50 AM Sven Eckelmann <sven@narfation.org> wrote:
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
