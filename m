Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 23 Apr 2012 15:17:41 +0800
References: <1334743210-12338-1-git-send-email-ordex@autistici.org>
	<201204231318.25768.lindner_marek@yahoo.de>
	<20120423064324.GZ6871@ZenIV.linux.org.uk>
In-Reply-To: <20120423064324.GZ6871@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204231517.42218.lindner_marek@yahoo.de>
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

On Monday, April 23, 2012 14:43:24 Al Viro wrote:
> Other GFP_* allocations fail only when system is in a really lousy state -
> killing processes, etc.  GFP_ATOMIC can fail in much milder conditions;
> note that they can't e.g. swap a page out or write a dirty page out and
> free it, etc.  _Any_ allocation failures need to be dealt with, of course,
> but with GFP_ATOMIC ones failures are just a fact of life - it's not even
> an emergency situation.

Ok, that is what I thought.


> > Replacing kmalloc() with kzalloc() should do, right ?
> 
> *shrug*
> That would do it, all right, but since you memcpy() over all but the last
> element, I'd suggest cleaning that last element explicitly.  Hell knows -
> depends on how large your arrays are...

Don't think that is worth the hassle. The index of these arrays is the number 
of interfaces batman is running on. In 90% of all cases it will be a single 
interface. Have yet to encounter a system with more than 3 interfaces.


> > Thanks for catching this. I agree that this is not properly protected.
> > All functions accessing orig_node->bcast_own(_sum) use
> > orig_node->ogm_cnt_lock to lock each other out. Obviously we would need
> > a global lock for the interface renumbering which will be as ugly as the
> > current array resizing is. You don't happen to have a good example of a
> > resizable array at hand ?
> 
> Depends...  How large those arrays realistically get?  I would probably
> consider allocating these guys separately and hashing them by
> orig_node/hwif pair, but feasibility of that depends on how many of each
> do you expect to see and how often do their numbers change...

As I explained above: The index is not big and does not change often (when an 
interface is added or removed).
Can you explain the "hashing them by orig_node/hwif pair" part in greater 
detail ?

Thanks,
Marek
