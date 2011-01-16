Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 16 Jan 2011 12:35:53 +0100
References: <201012130118.14949.lindner_marek@yahoo.de>
	<20101230020917.GA4707@pandem0nium>
In-Reply-To: <20101230020917.GA4707@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201101161235.54223.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: protect bonding with rcu
	locks
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

On Thursday 30 December 2010 03:09:17 Simon Wunderlich wrote:
> bonding / alternating candidates need to be secured by rcu locks
> as well. This patch therefore converts the bonding list
> from a plain pointer list to a rcu securable lists and references
> the bonding candidates.

Thanks for your patch! As the bonding / alternating candidate list is the last 
item on the way to an orig_hash_lock free kernel module this patch is a very 
welcome one. However, first tests revealed some memory leaks due to misbehaving 
reference counters. Therefore I took the time to dive deeper into this code 
section and propose an addition to your patch. The changes include:

* The bonding / alternating candidate list is not destroyed & re-created with 
each incoming OGM but candidates are added & deleted in a dynamic fashion.
* The memory leaks have been fixed / a workaround has been found. The "free 
neighbors when an interface is deactivated" patch is also required to get the 
full benefit of these memory leak fixes. 
* I introduced some style changes which are meant to increase readability & 
maintainability. Feedback is welcome.  ;-)

Note: One of the memory leaks turned out to be part of a bigger problem which 
we may or may not have in other code sections as well. purge_orig_neighbors() 
called call_rcu() on the same struct more then once in a short time period, so 
that each consecutive call overwrote the previous one. We have to look into 
this.

While reorganizing the code I stumbled over these lines which are part of the 
interference check:

/* we only care if the other candidate is even considered as candidate. */
if (!list_empty(&tmp_neigh_node2->bonding_list))
         continue;

This seems wrong in this context. If the list is empty then this neighbor is 
not part of the candidate list. Wouldn't you agree ?

Regards,
Marek

