Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 18 Mar 2018 15:39:07 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180318143907.GO2681@otheros>
References: <20180318093429.18752-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180318093429.18752-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
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

On Sun, Mar 18, 2018 at 10:34:29AM +0100, Sven Eckelmann wrote:
> All tools which were known to the batman-adv development team are
> supporting the batman-adv netlink interface since a while. Also debugfs is
> not supported for batman-adv interfaces in any non-default netns. Thus
> disabling CONFIG_BATMAN_ADV_DEBUGFS by default should not cause problems on
> most systems. It is still possible to enable it in case it is still
> required in a specific setup.

I'm wondering, could this lead to some confusion if package
maintainers of a Linux distro were upgrading the kernel before
upgrading batctl?

Since this patch is not urgent, would it make sentence to delay
this patch for after the next release maybe? That should give
maintainers at least a two months window to upgrade batctl.

And should avoid users being confused of "batctl dc" or
"batctl mf" not working with the batman-adv version their
distro might already ship.

Cheers, Linus
