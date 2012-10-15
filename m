Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
References: <CADP5dB6JgRxvUK_3OzC8E9tpBXxwzPPC5uh31QDpEjozEdf7_w@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Mon, 15 Oct 2012 12:33:48 -0300
Message-ID: <CAHD-aq+sdGMx67Wq4QFW==EBoWifHvCC_HgUHWFPsC0e2Ox8dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] How to detect gateway mode in openwrt?
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

> The problem is that if I bridge the wan port, I can't use
> hotplug.d/iface feature because the whole bridge is declared up wether
> or not the internet port is connected.
Hey Sophana,
Don't bridge the wan, as you won't be able to route then.

> Anyone have an idea on how I could do this?

we solved that "missing piece" with a few scripts

https://bitbucket.org/guidoi/batmesh/src/tip/packages/batman-adv-auto-gw-mode
https://bitbucket.org/guidoi/batmesh/src/tip/packages/watchping

Disclaimer (?)
watchping suffers some race conditions in corner cases (watching on
usb interfaces that take long to be detected at boot time, sometimes
fails), and <wishlist> the hook environment could definitely be
improved by some bash loving geek.</wishlist>
On the other hand, i don't think batman-adv-auto-gw-mode could get any
simpler than currently is. (since it offloads the work to watchping)

All in all, they work well, we've been using them on 4 different
networks for the past 6 months, with no major hiccups.

you can add the repo as a feed to your openwrt build environment,
$ grep batmesh feeds.conf
src-hg batmesh https://bitbucket.org/guidoi/batmesh

and compile them yourself.

Given that it's all posix ash (no binaries), you can probably grab our
precompiled packages as well.
http://openwrt.altermundi.net/snapshots/current/ar71xx/packages/batman-adv-auto-gw-mode_2.3-1_ar71xx.ipk
http://openwrt.altermundi.net/snapshots/current/ar71xx/packages/watchping_1.1-1_ar71xx.ipk

if you give them a try , any feedback will be appreciated!

Cheers,

Gui

pd. Note that you need a relatively recent openwrt build , since it
depends on netifd.
If you're still on backfire, you can dig the repo for rev be69dc644a4b
, it's a hacky no-netifd version
