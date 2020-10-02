Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Message-ID: <7bf217ced62816b1bd3404bcfe279082347fb265.camel@sipsolutions.net>
Subject: Re: WARNING in cfg80211_connect
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 02 Oct 2020 08:26:50 +0200
In-Reply-To: <0000000000000a954d05b0a89a86@google.com> (sfid-20201002_063111_703712_8FE82506)
References: <0000000000000a954d05b0a89a86@google.com>
	 (sfid-20201002_063111_703712_8FE82506)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: syzbot <syzbot+5f9392825de654244975@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, david@fromorbit.com, dchinner@redhat.com, hch@lst.de, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

On Thu, 2020-10-01 at 21:31 -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 16d4d43595b4780daac8fcea6d042689124cb094
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Jul 20 01:38:55 2016 +0000
> 
>     xfs: split direct I/O and DAX path
> 

LOL!

Unlike in many other cases, here I don't even see why it went down that
path. You'd think that Christoph's commit should have no effect
whatsoever, but here we are with syzbot claiming a difference?

I mean, often enough it says something is "caused" by a patch because
that caused e.g. generic netlink family renumbering, or because it
emitted some other ioctl() calls or whatnot that are invalid before and
valid after some other (feature) patch (or vice versa sometimes), but
you'd think that this patch would have _zero_ userspace observable
effect?

Which I guess means that the reproduction of this bug is random, perhaps
timing related.

johannes
