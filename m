Return-Path: <linus.luessing@web.de>
Date: Thu, 3 Feb 2011 10:55:25 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110203095525.GA21622@Sellars>
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
	<1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
	<201102022242.52008.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201102022242.52008.sven@narfation.org>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting
 for gw_node
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

Hi Sven,

On Wed, Feb 02, 2011 at 10:42:46PM +0100, Sven Eckelmann wrote:
> > gw_deselet():
> > * is the refcount at this time always 1 for gw_node, can the null
> > pointer check + a rcu_dereference be ommited? (at least that's what
> > it looks like when comparing to the rcuref.txt example)
> 
> Why can't it be NULL? And _always_ use rcu_dereference. What example tells you 
> that it isn't needed? None of the examples has any kind of rcu pointer in it 
> (just el as pointer which is stored in a struct were the pointer inside the 
> struct is rcu protected).
Ok, you got a point there with the always-rcu-dereference pointers. I
somehow was thinking that in between the spin-lock/unlock there
could possibly be no other thread reading/writing to it then - but
I guess at that moment I forgot about the reordering and the whole
point of using the rcu macros between the spinlock there :). So,
yes, you're right with that one, will change it.

For the NULL pointer, guess you're right again. I was looking at
the delete() example in rcuref.txt which was not doing any NULL
pointer check. But either that's the case there because it's more
pseudo-code there or because it's more related to lists, meaning
that after the delete_element there it's not in the list anymore
and not possible for any other thread to have the idea to free the
same thing again.
> 
> 
> > gw_get_selected():
> > * Probably the orig_node's refcounting has to be made atomic, too?
> 
> This part is still a little bit ugly and I cannot give you an easy answer. 
> Just think about following:
>  * Hash list is a bunch of rcu protected lists
>  * pointer to originator is stored inside a bucket (list elements inside the
>    hash)
>  * hash bucket wants to get removed - call_rcu; reference count of the
>    originator is decremented immediately
>  * (!!!! lots of reordering of read and write commands inside the cpu!!!! -
>     aren't we happy about the added complexity which tries to hide the memory
>     latency?)
>  * the originator was removed, the bucket which is removed in the call_rcu
>    still points to the removed originator
>  * a parallel running operation tries to find a originator, the rcu list
>    iterator gets the to-be-deleted bucket to the originator
>  * the pointer to the already removed originator inside the bucket is
>    dereferenced, data is read/written -> Kernel Oops
> 
> Does this sound scary? At least it could be used in some horror movies (and I 
> would watch them).
> 
> But that is the other problem I currently have with the state of batman-adv in 
> trunk - and I think I forget to tell you about it after the release of 
> v2011.0.0.
> 
> So, a good idea would be the removal of the buckets for the hash. Usage of 
> "struct hlist_node" inside the hash elements should be a good starting point. 
> But think about the problem that the different hashes could have the same 
> element. So you need for each distinct hash an extra "struct hlist_node" 
> inside the element which should be part of the hash. The hash_add (and 
> related) functions don't get the actual pointer to the element, but the 
> pointer to the correct "struct hlist_node" inside the element/struct. The 
> comparison and hashing function would also receive "struct hlist_node" as 
> parameter and must get the pointer to the element using the container_of 
> macro.
> 
> 
> > @@ -171,7 +172,7 @@ struct bat_priv {
> >         struct delayed_work hna_work;
> >         struct delayed_work orig_work;
> >         struct delayed_work vis_work;
> > -       struct gw_node *curr_gw;
> > +       struct gw_node *curr_gw;        /* rcu protected pointer */
> >         struct vis_info *my_vis_info;
> >  };
> 
> Sry, but I have to say that: FAIL ;)
> 
> I think it should look that way:
> > -       struct gw_node *curr_gw;
> > +       struct gw_node __rcu *curr_gw;
Eh, had been looking at whatisRCU.txt and there gbl_foo in section
3 did not have a "__rcu" (actually I hadn't seen that in any of the
documentations before).
> 
> Best regards,
> 	Sven

Cheers, Linus
