Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 23 Apr 2012 13:18:25 +0800
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120419134854.GA6871@ZenIV.linux.org.uk>
	<20120419140955.GA2408@ritirata.org>
In-Reply-To: <20120419140955.GA2408@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204231318.25768.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-18
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
Cc: Al Viro <viro@zeniv.linux.org.uk>


Hi,

> Haven't found any, but
> 
> 	* you do an awful lot of GFP_ATOMIC allocations and those can and
> do fail from time to time.  What's worse, you ignore some of those
> failures - e.g. failing allocation in orig_hash_{add,del}_if() will be
> ignored by the caller.  I haven't looked into that code enough to tell
> if it could be exploited, but I really don't like the look of it...

other GFP_* allocations can't fail ?
This whole resizing isn't escpecially beautiful and asks for some love.


> 	* orig_node_add_if() leaves junk in added array elements.  You do
> kmalloc() followed by memcpy(), but leave the last element uninitialized.
> May be safe if you assign it soon enough, but I'd suggest checking that.

Replacing kmalloc() with kzalloc() should do, right ?


> 	* orig_node_del_if() looks odd - it removes element #hard_iface->if_num
> and shifts all subsequent ones down; then it renumbers interfaces to
> match that.  So far, so good, and there's even a plausible comment about
> locking:
>    /* renumber remaining batman interfaces _inside_ of orig_hash_lock */
> except that no such lock exists since commit d007260.  What protects us
> from the obvious race in there?

Thanks for catching this. I agree that this is not properly protected. All 
functions accessing orig_node->bcast_own(_sum) use orig_node->ogm_cnt_lock to 
lock each other out. Obviously we would need a global lock for the interface 
renumbering which will be as ugly as the current array resizing is. You don't 
happen to have a good example of a resizable array at hand ?

Cheers,
Marek
