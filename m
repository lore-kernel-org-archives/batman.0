Return-Path: <linus.luessing@web.de>
Date: Sun, 20 Oct 2013 11:21:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20131020092100.GD13550@Linus-Debian>
References: <1380030033-11533-1-git-send-email-linus.luessing@web.de>
 <20130924134650.GP3911@neomailbox.net>
 <20130924145723.GN18530@Linus-Debian> <1680806.MqrY0WE4J8@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1680806.MqrY0WE4J8@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce 'no_rebroadcast'
 option
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Wed, Sep 25, 2013 at 11:03:48PM +0800, Marek Lindner wrote:
> On Tuesday 24 September 2013 16:57:24 Linus Lüssing wrote:
> > On Tue, Sep 24, 2013 at 03:46:50PM +0200, Antonio Quartulli wrote:
> > > On Tue, Sep 24, 2013 at 03:40:33PM +0200, Linus Lüssing wrote:
> > > > 
> > > >
> > > > Using this option wrongly will break your mesh network, use this option
> > > > wisely and at your own risk!
> > >
> > > 
> > >
> > > Exactly for this reason (As we discussed on IRC) I think this mechanism
> > > should be reasoned a bit more.
> > 
> > Hm, my personal reason to want such a feature is included, the VPN
> > example. And since I know that using batman-adv over VPNs is not
> > uncommon, I'd love to have this feature upstream.
> 
> Admittedly, I haven't followed the entire discussion but what speaks against 
> setting the rebroadcast count define for non-wireless to 0 ? Matthias (if I am 
> not mistaken) provided a patch for the wireless / non-wireless distinction not 
> too long ago. 
> Seems way easier as we are looking for a quick and temporary solution ?
> 

Just to summarize the IRC discussion for the archive: For our case
(and about half a dozen other Freifunk communities) this wouldn't work
because we'd want to have it to 0 for some VPN interfaces but not all. (*)

The bar for introducing new configuration / tuning options is a
high one for batman-adv because ease of use is a high priority for
the batman team. Therefore things should be automized as much as
possible or configuration options should only be introduced if
there is a high demand for it. Also if it is easy to misuse such an
option and if misuse causes havoc then such patches are not very
welcome, too.

Since this option can generally be automized (with some, but
doable effort) we decided to apply this patch in our project
locally and agreed on not bringing the patch posted here upstream
now.

Cheers, Linus


(*) We have a VPN topology with a few, fully meshed master servers
and several more clients which are connected to two random master
servers. The VPN software we are using, fastd, does not provide
any mesh routing / forwarding capabilities (so it kind of behaves
like OpenVPN in bridged mode without the client-to-client option or
tinc with Mode=switch,Broadcast=no,Forwarding=off).
