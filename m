Return-Path: <linus.luessing@web.de>
Date: Wed, 12 Jan 2011 16:32:22 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110112153222.GA24766@Sellars>
References: <1293810385-31761-1-git-send-email-linus.luessing@ascom.ch>
	<201101051312.34513.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201101051312.34513.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] NDP patches v4
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

On Wed, Jan 05, 2011 at 01:12:33PM +0100, Marek Lindner wrote:
> 
> Hi Linus,
> 
> great that you embraced the feedback that quickly. As discussed in Berlin I'll 
> go through your patches once I have a little bit more room to manoeuvre (next 
> week is rather packed).
> 
> > Would be great if someone could check the usage of rcu-locking +
> > refcounting. I was also a little confused because in
> > "Documentation/RCU/listRCU.txt" list_del_rcu() and list_add_rcu() are not
> > protected with a spinlock for the list here, but in the batman-adv code we
> > are usually having those extra locks. Do I have to leave those spinlocks
> > or can I remove them for adding/deleting entries in the neigh_list?
> 
> I don't understand why you think there are no locks. Did you read the text 
> around the examples (Documentation/RCU/listRCU.txt) ? I mean, below the first 
> example (which indeed does not contain spinlocks) it is written:
> 
> Normally, the write_lock() and write_unlock() would be replaced by
> a spin_lock() and a spin_unlock(), but in this case, all callers hold
> audit_netlink_sem, so no additional locking is required.  The auditsc_lock
> can therefore be eliminated, since use of RCU eliminates the need for
> writers to exclude readers.  Normally, the write_lock() calls would
> be converted into spin_lock() calls.
> 
> If you check the following example you'll find spinlocks or search for 
> list_del_rcu() in the kernel sources to find more usage scenarios.
> 
> Regards,
> Marek
> 

Oki doki, thanks. I was a little confused by the example at that
section and couldn't find any other references to "audit_netlink_sem" (though
it is/was probably just a common semaphore, I guess). Ok,
quick searching of list_del_rcu() in the kernel code (via http://lxr.linux.no/linux)
cleared things up.

Cheers, Linus
