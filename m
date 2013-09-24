Return-Path: <linus.luessing@web.de>
Date: Tue, 24 Sep 2013 16:57:24 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130924145723.GN18530@Linus-Debian>
References: <1380030033-11533-1-git-send-email-linus.luessing@web.de>
 <20130924134650.GP3911@neomailbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130924134650.GP3911@neomailbox.net>
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

Hi Antonio,


On Tue, Sep 24, 2013 at 03:46:50PM +0200, Antonio Quartulli wrote:
> On Tue, Sep 24, 2013 at 03:40:33PM +0200, Linus Lüssing wrote:
> > 
> > Using this option wrongly will break your mesh network, use this option
> > wisely and at your own risk!
> 
> Exactly for this reason (As we discussed on IRC) I think this mechanism should be
> reasoned a bit more.

Hm, my personal reason to want such a feature is included, the VPN
example. And since I know that using batman-adv over VPNs is not
uncommon, I'd love to have this feature upstream.

I believe such a feature would be more commonly used than a
non-default hop penalty for example, therefore I think it is
suitable to be considered for upstream.


> As I told you, it would be nice to have a self-activating
> mechanism which is able to switch it on or off when really needed.

I totally agree that a self-activating mechanism would be nice
indeed. Maybe even with a self-adjusting number of rebroadcasts.
But since that is all non-trivial I'm not going to work on
such an automatic feature before my queued multicast patches and
the ones to follow are upstream. I'd prefer not hopping between
multiple feature patchsets again to spare everyone a déjà vu.

So since such an automatic feature is not going to be available
upstream within the next one or two years at least, I guess,
I don't see why the easy, manual option which could be added to
a release relatively quickly, should be spared from the
interested users.


> 
> The common network administrator will probably not have enough knowledge to
> understand when this is useful or when this is breaking things.

That's why I added the extra warning at the end.


> 
> 
> Moreover, with this patch you are adding a userspace API that we won't be able
> to remove anymore (!)

So we should have never added a hop-penalty sysfs option either?
That one could have been automized, too.


> and since the feature needs some more time before being
> mature I'd rather to suggest to avoid this.

I'm sorry, I currently fail to see in which regards this would
need a considerable amount of time to mature. To me this option
seems easy and straightforward, especially as other routing
protocols like babel for instance have such a manual option
available, too. If you have certain, specific maturity concerns,
things I might have overlooked, I'd be happy if you could share
them.


> 
> 
> Cheers,
> 
> -- 
> Antonio Quartulli

Cheers, Linus
