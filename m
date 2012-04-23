Return-Path: <viro@ftp.linux.org.uk>
Date: Mon, 23 Apr 2012 07:43:24 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120423064324.GZ6871@ZenIV.linux.org.uk>
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<20120419134854.GA6871@ZenIV.linux.org.uk>
	<20120419140955.GA2408@ritirata.org>
	<201204231318.25768.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201204231318.25768.lindner_marek@yahoo.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Apr 23, 2012 at 01:18:25PM +0800, Marek Lindner wrote:
> 
> Hi,
> 
> > Haven't found any, but
> > 
> > 	* you do an awful lot of GFP_ATOMIC allocations and those can and
> > do fail from time to time.  What's worse, you ignore some of those
> > failures - e.g. failing allocation in orig_hash_{add,del}_if() will be
> > ignored by the caller.  I haven't looked into that code enough to tell
> > if it could be exploited, but I really don't like the look of it...
> 
> other GFP_* allocations can't fail ?
> This whole resizing isn't escpecially beautiful and asks for some love.

Other GFP_* allocations fail only when system is in a really lousy state -
killing processes, etc.  GFP_ATOMIC can fail in much milder conditions;
note that they can't e.g. swap a page out or write a dirty page out and
free it, etc.  _Any_ allocation failures need to be dealt with, of course,
but with GFP_ATOMIC ones failures are just a fact of life - it's not even
an emergency situation.

> > 	* orig_node_add_if() leaves junk in added array elements.  You do
> > kmalloc() followed by memcpy(), but leave the last element uninitialized.
> > May be safe if you assign it soon enough, but I'd suggest checking that.
> 
> Replacing kmalloc() with kzalloc() should do, right ?

*shrug*
That would do it, all right, but since you memcpy() over all but the last
element, I'd suggest cleaning that last element explicitly.  Hell knows -
depends on how large your arrays are...

> > 	* orig_node_del_if() looks odd - it removes element #hard_iface->if_num
> > and shifts all subsequent ones down; then it renumbers interfaces to
> > match that.  So far, so good, and there's even a plausible comment about
> > locking:
> >    /* renumber remaining batman interfaces _inside_ of orig_hash_lock */
> > except that no such lock exists since commit d007260.  What protects us
> > from the obvious race in there?
> 
> Thanks for catching this. I agree that this is not properly protected. All 
> functions accessing orig_node->bcast_own(_sum) use orig_node->ogm_cnt_lock to 
> lock each other out. Obviously we would need a global lock for the interface 
> renumbering which will be as ugly as the current array resizing is. You don't 
> happen to have a good example of a resizable array at hand ?

Depends...  How large those arrays realistically get?  I would probably
consider allocating these guys separately and hashing them by orig_node/hwif
pair, but feasibility of that depends on how many of each do you expect to
see and how often do their numbers change...
