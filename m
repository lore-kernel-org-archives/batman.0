Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 13 Oct 2010 00:22:01 +0200
Message-Id: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] Simplifying sysfs code
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi there,

thanks for all the feedback for the changes I wanted to make to the sysfs code base.
I tried to address bugs and suggestions. The macros are now a bit smaller than
in the beginning, the missing static has been added (thanks Andrew and Sven).

Due to Marecs comment on the issues with changing sysfs file names in the kernel
(which I was not aware of, thanks for explaining) and comments about old sysfs
filenames being more descriptive, I changed the bat_priv names instead now.
I don't really see a good reason yet why they should not be equal.


The hop_penalty and num_bcasts patches will follow later. There've been some
discussions about what the limit and rules for exposing defines in sysfs
should be.

Of course, having a good set of default values and not that many options configurable
during runtime at all or most parameters just being adjusted automatically,
makes the routing protocol itself much more stable and reliable, and less
complex and easy to use for the user. However, certain assessable scenarios might
benefit from certain parameters being tweakable during runtime, making optimizations
and tests with different values quick and easy without having to rebuild and install
the kernel module or even firmware images.

Simon's idea so far was, to introduce a debug/ folder in sysfs which is hidden by
default and could be enabled with a KConfig option, so that tinkerers still have a
chance for their needs for tweaking parameters. num_bcasts would probably be one of
the first candidates as a debug-parameter.

If I forgot any very important points from the discussions so far, please don't hesitate
to add them here.

And as always, any comments and suggestions highly appreciated :).

Cheers, Linus
