Return-Path: <russell@personaltelco.net>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com>
From: Russell Senior <russell@personaltelco.net>
Date: Tue, 21 Jan 2014 22:04:44 -0800
In-Reply-To: <86mwipch0u.fsf@coulee.tdb.com> (Russell Senior's message of
 "Tue\, 21 Jan 2014 10\:43\:29 -0800")
Message-ID: <86lhy8pn5v.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
	computation
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

>>>>> "Russell" == Russell Senior <russell@personaltelco.net> writes:

>>>>> "Antonio" == Antonio Quartulli <antonio@meshcoding.com> writes:
Antonio> The current MTU computation always returns a value smaller
Antonio> than 1500bytes even if the real interfaces have an MTU large
Antonio> enough to compensate the batman-adv overhead.

Antonio> Fix the computation by properly returning the highest
Antonio> admitted value.

Antonio> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com> ---

Russell> This seems to fix the bat0-MTU-unnecessarily-small problem I
Russell> observed last night and reported on the IRC channel.  I
Russell> haven't actually passed any traffic over it yet, but the
Russell> interface is up with the expected MTU value with the patch.

Antonio> This patch is missing a Reported-by clause because I did not
Antonio> have "russell"'s email address at hand.

Russell> Reported-by: Russell Senior <russell@personaltelco.net>

Followup, as requested, I tried setting a smaller MTU (1400) on the
adhoc0 interface.  When fragmentation was enabled, this resulted in no
change to MTU (still 1500) for bat0.  When I disabled fragmentation,
the bat0 MTU dropped, as expected, to 1368.  Interestingly, the MTU on
the bridge that bat0 was a member of remained 1500 despite the lower
bat0 MTU.  Should that be?

Also, for testing actual traffic over the batman-adv link, I build
OpenWrt r39354 with the patch on a Soekris net4526, so that there were
two nodes with the same revision (different architecture):
ubnt-bullet-m with ath9k; net4826 with ath5k.  I first noticed that I
was losing about 100k of memory every couple seconds and pretty soon
(with 20 minutes) the net4826 started oopsing on out-of-memory.

I removed the patch, rev'd OpenWrt to r39365 and confirmed that the
net4826 build was also leaking at a substantial rate.

I am seeing a similar, though possibly slower, leak on the ubiquiti
bullet m2hp.  Right before rebooting, top shows kworker/u2:$N (where
$N is 0 or 3) chewing up some cpu cycles.

Has anybody else seen this memory leak?  Leads on where it's coming
from?  Not a runaway process, at least not that top shows up.  Just a
gradual disappearance from MemFree that /proc/sys/vm/drop_caches
doesn't fix.  It isn't adhoc mode, and I can associate the two devices
over adhoc and move a bunch of data with no memory lost, but turning
on batman-adv seems to sink it.



-- 
Russell Senior, President
russell@personaltelco.net
