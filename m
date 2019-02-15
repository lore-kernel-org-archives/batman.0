Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 15 Feb 2019 18:20:07 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190215172007.GB1472@otheros>
References: <20190214124301.6222-1-linus.luessing@c0d3.blue>
 <1687264.beubBEU3KB@bentobox> <20190214134452.GA1602@otheros>
 <11497659.iQavgr9jVl@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11497659.iQavgr9jVl@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>, David Bauer <mail@david-bauer.net>

On Thu, Feb 14, 2019 at 03:04:54PM +0100, Sven Eckelmann wrote:
> On Thursday, 14 February 2019 14:44:52 CET Linus Lüssing wrote:
> [...]
> > > No new sysfs config files.
> > 
> > Why? The bridge for instance does the same.
> 
> https://patchwork.open-mesh.org/patch/16763/ - here the quote
> 
> On Samstag, 29. Oktober 2016 12:33:01 CEST Jiri Pirko wrote:
> > I strongly believe it is a huge mistake to use sysfs for things like
> > this. This should be done via generic netlink api.
> 
> We don't need to configuration interfaces - we only need the preferred one. If 
> this is sysfs for you guys then we should not have started with generic 
> netlink at all. And why wasn't this brought up now *after* the stuff was 
> merged by David. It isn't the first time that I've stated clearly that there 
> should be no new sysfs configuration files when we switch to genl.
> 
> If it now preferred to have sysfs again for configuration then please discuss 
> it with the netdev folks and find out how the new generic netlink interface 
> can be removed again before the next release.
> 
> Kind regards,
> 	Sven

Sorry, then this is all my misunderstanding. I have no issue with
removing the sysfs part from this patch (I liked sysfs for
prototyping/testing/scripting, but as we have all configuration
options available in batctl that works for me, too).

Thanks for the clarifications.

Regards, Linus
