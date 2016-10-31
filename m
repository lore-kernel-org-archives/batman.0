Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 31 Oct 2016 08:22:17 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161031072217.GK7448@otheros>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <2315506.rV8PSJo6DZ@bentobox> <20161029024646.GE7448@otheros>
 <1546440.hnPT5BvDlZ@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546440.hnPT5BvDlZ@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/2] batman-adv: fix race conditions
 on interface removal
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

On Sat, Oct 29, 2016 at 08:55:44AM +0200, Sven Eckelmann wrote:
> On Samstag, 29. Oktober 2016 04:46:46 CEST Linus Lüssing wrote:
> [...]
> > > [...]
> > > > +bool batadv_forw_packet_steal(struct batadv_forw_packet *forw_packet,
> > > > +			      spinlock_t *lock)
> > > > +{
> > > > +	struct hlist_head head = HLIST_HEAD_INIT;
> [...]
> > > > +	/* Just to spot misuse of this function */
> > > > +	hlist_add_head(&forw_packet->bm_list, &head);
> > > > +	hlist_add_fake(&forw_packet->bm_list);
> > > 
> > > Sorry, I don't get how this should spot misuse via this extra hlist_add_head.
> > > You first add the packet to the list (on the stack) and then setting pprev
> > > pointer to itself. So you basically have a fake hashed node with next pointer
> > > set to NULL. Wouldn't it be better here to use INIT_HLIST_NODE instead of
> > > hlist_add_head? I would even say that INIT_HLIST_NODE isn't needed here
> > > because you already did this during batadv_forw_packet_alloc.
> > > 
> > > But I would assume that you actually only wanted hlist_add_fake for the
> > > WARN_ONCE in batadv_forw_packet_queue, right?
> > 
> > Right :). I'm only using the _fake() variant for this WARN_ONCE.
> > (So I'll leave that as is? Or too confusing? Do you want me to
> > reword / clarify something better in the code?)
> 
> I think the _fake stuff + comment is ok. But the add to the hlist_head
> on the stack is confusing and maybe should be removed.

Hm, ah. I think I had that first, but then noticed it doesn't
work. For the fake-approach to work, I need to be able to
distinguish a stealing from batadv_forw_packet_steal() and
batadv_forw_packet_list_steal().

Note, that the former has the extra hlist_add_head(bm_list) to a
stack hlist_head while the latter hasn't.


The three, potential cases to distinguish in
batadv_forw_packet_queue() are:

OK-case 1): 
- Not stolen yet, we may requeue
  (hlist_unhashed(bm_list))

OK-case 2):
- stolen by purging thread, batadv_forw_packet_list_steal(),
  we may not requeue
  (!hlist_unhashed(bm_list) && !hlist_fake(bm_list))

ERROR-case:
- someone called batadv_forw_packet_steal() and
  then batadv_forw_packet_queue() was called afterwards
  (!hlist_unhashed(bm_list) && hlist_fake(bm_list))


Only doing the hlist_add_fake(bm_list) without the previous
hlist_add_head() in batadv_forw_packet_steal() would lead to
"hlist_fake(bm_list)" becoming true, like we'd want it to
and need to detect the ERROR-case, right.

Unfortunately, a plain hlist_add_fake(bm_list) then sets
bm_list->pprev = bm_list->next = NULL. Which results in:

  hlist_unhashed(bm_list) (= OK-case 1), not what we want)


Does that clarify why the previous hlist_add_head() in
batadv_forw_packet_steal() is done?

Regards, Linus
