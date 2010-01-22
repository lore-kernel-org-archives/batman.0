Return-Path: <andrew@lunn.ch>
Date: Fri, 22 Jan 2010 11:02:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100122100238.GL24649@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] State of batman-adv in mainline
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Hi Folks

Here is a quick summary of the state of batman in mainline.

First a quick summary of how code gets into mainline in general. When
Linus released a kernel version, eg 2.6.33, he opens the merge window
for the next kernel version. This merge window is normally two weeks
long. During these two weeks, all new development work which is
intended for 2.6.34 is merged into his tree. At the end of the two
weeks the first rc kernel is released, in this case 2.6.34-rc1. At
this point no more development work can be merged, just bug
fixes. Generally there is a new -rc kernel every week, for about 8 or
9 weeks. So after about three months, the kernel is released, and it
all starts again.

This two week merge window is a busy period with all sorts of patches
come together. In the past this did not always go too well, patches
collided and conflicted. To try to find out about such problems early,
before the merge window, the linux-next tree was created. linux-next
is roughly all the patches which will be merged in the next merge
window. It contains ongoing development work from all over the
place. If patches are going to clash, they will likely clash in
linux-next and then developers know about such problems early.

O.K. so what is the status of batman-adv?

Our first patch landed by GregKH just before the merge window for
2.6.33 opened. This patch made it into 2.6.33-rc1. So at around the
end of march when 2.6.33 is released, we will be in mainline.

All patches submitted after this first big one was after the merge
window closed. So they are currently queued up by GregKH. They appear
in linux-next and should be accepted during the 2.6.34 merge window.

So we have a few issues to address in the next couple of weeks.

1) We should make it clear on www.open-mesh.org which version of
   batctl should be used with 2.6.33. The trunk version will not work
   correctly, an older version is needed. Probably we want to make a
   tarball release and put it somewhere prominent on the website.

2) We still have the chance to get bug fixes into 2.6.33. Is there
   anything in 2.6.33-rc5 which can cause oopses, deadlocks, etc?

3) It would be nice if the community actually downloaded 2.6.33-rc5
   and tested it. Please report any problems you find.

4) We should review what is currently in subversion but not yet pushed
   to GregKH ready for 2.6.34. eg gateway support, vis server startup
   fix, bonding, etc. In another email i will produce a list of
   patches we should consider.

All this work is currently happening in staging. Once 2.6.33 is
released we will get a bit more exposure and hopefully trigger some
discussion. 2.6.34-rc1 will be a big step forward and i think at that
point we should approach the linux networking guys and ask for a
review. That would be one of the first steps of getting out of staging
and somewhere under the net directory.

    Andrew
