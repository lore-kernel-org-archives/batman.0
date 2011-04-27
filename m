Return-Path: <linus.luessing@web.de>
Date: Wed, 27 Apr 2011 18:02:58 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110427160258.GA32614@Sellars>
References: <1302891882-11246-1-git-send-email-linus.luessing@web.de>
	<201104160954.49563.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201104160954.49563.sven@narfation.org>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix crash on module shutdown
 with multiple ifaces
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sat, Apr 16, 2011 at 09:54:48AM +0200, Sven Eckelmann wrote:
> Linus Lüssing wrote:
> > hardif_remove_interfaces() removes all hard interfaces from the
> > hardif_list before freeing and cleaning up any device. However the clean
> > up procedures in orig_hash_del_if()
> > (hardif_remove_interface()->hardif_disable_interface()->
> > orig_hash_del_if())
> > need the other interfaces still to be present in the hardif_list.
> > Otherwise it won't renumber any preceding interfaces, which leads to an
> > unhandled kernel paging request in orig_node_del_if()'s "/* copy second
> > part */" due to wrong hard_if->if_num's.
> > 
> > With this commit the interface removal on module shutdown will be down
> > in the same way as removing single interfaces from batman only: One
> > interface will be removed and cleaned at a time.
> > 
> > Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> 
> 
> Please use --patience as requested in
>  http://www.open-mesh.org/wiki/open-mesh/Contribute
> 
> Please show us (as part of the commit message) why the information in
>  http://www.open-mesh.org/projects/batman-adv/repository/revisions/132b776c22c9b71962a3ed9a33e5b6f9218dae1b
> isn't valid anymore and explain why it is save to use the spin_lock only
> inside the loop (but it would have to protect the loop in normal situations).
> 
> Kind regards,
> 	Sven

Hi Sven,

Ah, oki doki, didn't know about commit 5d4b5a4d and yes, a revert
of that commit looks kind of similar to my patch.

Commit 5d4b5a4d together with your statement confuse me a little. The
commit message does not say anything about a locking dependancy
issue, but seems to be a performance patch (which does not seem as
such a severe problem to me, as removing/adding interfaces /
removing the batman-adv module does not happen that frequently in
common setups ;) ). Could you explain a little further which
combinations of locks could introduce a problem?

Hmm, for the "and explain why it is save to use the spin_lock
only" part, aggreed, I think it was initially a mistake of mine.
And usually this would not protect us from a new interface being
added or an interface being removed from batman during a
NETDEV_REGISTER/UNREGISTER event while we are trying to flush the
if_list.
However, just before calling hardif_remove_interfaces(), we are
calling unregister_netdevice_notifier(&hard_if_notifier).
So as far as I know, no hardif_add_interface() or
hardif_remove_interface() and according list_add/del_rcu for the
if_list should be called anymore.

Cheers, Linus

PS: And it's actually not an "unhandled kernel paging request" but
a "Null pointer dereference". Also see this ticket:
http://www.open-mesh.org/issues/147

I'm also wondering why we'd actually need the rtnl_lock() in
hardif_remove_interfaces() then with that reasoning. What
operation in hardif_remove_interface() (without the 's') needs to
be protected with the rtnl_lock(), could be place the rtnl_lock a
little tighter instead to also fix the issue from here?
http://www.open-mesh.org/issues/145
