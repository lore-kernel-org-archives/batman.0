Return-Path: <linus.luessing@web.de>
Date: Tue, 15 Jul 2014 00:28:13 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140714222812.GU2675@Linus-Debian>
References: <538314FE.9020808@mindeye.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <538314FE.9020808@mindeye.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Init and use batman
 interface with correc netns.
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

On Mon, May 26, 2014 at 12:18:38PM +0200, Daniel Ehlers wrote:
> Enables us to use batman-adv inside of network namespaces.
> Unfortunately it does not enable us to use multiple batX interfaces
> in different namespaces. This limitation results from using
> debugfs and its unawareness of namespaces.
> 
> Signed-off-by: Daniel Ehlers <danielehlers@mindeye.net>

The two patches are indeed doing what they are saying.

PATCH 1/2 fixes the issue I had in #179, no more kernel panics
with that one - by disallowing the scenario I was using. But not
allowing to have the slave interfaces in one and the master
interface (batX) in the other seems like a sane solution and the
way to go. The bridge does the same, compare:

"netns bridge: allow bridges in netns!"
(4aa678ba44aa35759c04f300afbc97d3dab5faa2)

Maybe reference that one in the commit message, too?

If you'd change the commit message like Marek suggested as well
(e.g. don't name the ticket number within the commit message - the
netdev folks don't know it; specifically name the kernel panic
this prevents) and make it appliable (see later), I'd give it a
Tested-by + Acked-by.


PATCH 2/2 correctly initializes the batX interface in the same
namespace in my tests. And again, straight forward when comparing
it to the bridge-patch referenced above. PATCH 1/2 + PATCH 2/2 are
logically the same as the bridge patch.

But there's one more issue I'm having with PATCH 2/2, I'm getting
the following warning when doing an "init 0" in the LXC host:

---
[  248.679142] batman_adv: bat1: Removing interface: eth1
[  248.685206] ------------[ cut here ]------------
[  248.688746] WARNING: CPU: 0 PID: 2694 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x5c/0x68()
[  248.692551] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/net/eth1/batman_adv'
...
---

Going to add the full calltrace to #179.

So it looks like next to PATCH 1/2 and PATCH 2/2 (and potentially
a third patch $later for the debugfs limitation you named) another
patch for the sysfs seems to be necessary to get netns support
working correctly.

-----

Also, your MTA seems to break your patches. I can't apply them
(for instance see PATCH 2/2, there's a whitespace added before the
final '-- 1.9.2', PATCH 1/2 has an extra newline at the end). The
patches you sent me privately as attachments apply fine though.

If I recall correctly, you were using "git imap-send". Maybe try
using "git send-email" instead.

Cheers, Linus
