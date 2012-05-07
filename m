Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 7 May 2012 14:40:20 +0800
References: <4FA54C09.6000303@universe-factory.net>
	<20120506201435.GA27416@pandem0nium>
	<4FA75113.40401@universe-factory.net>
In-Reply-To: <4FA75113.40401@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205071440.21129.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, May 07, 2012 12:35:31 Matthias Schiffer wrote:
> On 05/06/2012 10:14 PM, Simon Wunderlich wrote:
> > Your patch does the trick, although I think this ugly function could use
> > a rewrite. First counting bytes and then allocating this size to do
> > exactly the same thing again is not really good style. If you would like
> > to volunteer to do this job (or plan to work more on vis), please tell
> > me, otherwise I'll put it in on my TODO list.
> 
> While I'am already at it, I guess I can also volunteer to do some more vis
> work :)

Great! The vis code will profit from some love. :)


> Besides cleanup, are there more ideas about the vis? A nice feature I can
> think about would be adding some freely chosen identification string (for
> example the hostname) to the vis data, this could make big graphs much
> more readable. I wonder though if this would be possible without breaking
> compatiblity.

If you wish to replace the mac addresses with readable name you can simply use 
a bat-hosts file to tell batctl which mac address should be replaced. Check 
the bat-hosts section in our batctl online manpage:
http://downloads.open-mesh.org/batman/manpages/batctl.8.html


> - Is there any reason vis_seq_print_text() allocates a buffer at all
> instead of just printing the data directy into the seq_file? Looking at
> the seq_printf implementation, there doesn't seem to be a problem calling
> it while holding the lock.

The output can directly printed only as long as no spinlock is held. Spinlocks 
are not allowed to sleep. All other *_print_text() functions have been 
converted to directly call seq_printf() after we converted the hash to use RCU 
locking instead of spinlocks. For this to work in the vis code as well the 
vis_hash_lock spinlock has to be removed ..


> - In many places in the vis code hlist_for_each_entry_rcu() is used to
> iterate over the hash lists, even though all access to vis_hash is guarded
> by the vis_hash_lock, so it seems to be okay to just use
> hlist_for_each_entry(). In some functions, vis_seq_print_text() being one of
> them, rcu_read_lock/unlock pairs could be removed as well with this change.
> Do I overlook something?

The vis code is only half way through the spinlock to RCU conversion. Before 
you remove the vis_hash_lock anywhere you have to ensure that the data 
structures are properly protected by other means. If half of the code uses one 
lock while the rest uses another we'll certainly run into trouble.

If you ask me what could/should be done, I'd say:
 * Replacing vis_hash_lock with RCU locking.
 * The vis code should be reviewed to remove code duplication. It implements 
quite a number of things already present in the main batman-adv code (for 
example its packet queue). 
 * Boring code cleanups like using newly added macros / functions to make the 
code more readable.


> I'll also drop by the batman IRC channel.

See you there!

Regards,
Marek

