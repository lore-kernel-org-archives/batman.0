Return-Path: <linus.luessing@web.de>
Date: Thu, 15 Aug 2013 20:02:12 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130815180212.GA8728@Linus-Debian>
References: <1376382240-30664-1-git-send-email-linus.luessing@web.de>
 <1376382240-30664-4-git-send-email-linus.luessing@web.de>
 <20130815134549.GA1982@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20130815134549.GA1982@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 3/5] batman-adv: Modified forwarding
 behaviour for multicast packets
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

On Thu, Aug 15, 2013 at 03:45:49PM +0200, Simon Wunderlich wrote:
> Hey Linus,
> 
> I'm currently playing a little with this patchset ...
> 
> On Tue, Aug 13, 2013 at 10:23:58AM +0200, Linus Lüssing wrote:
> > [...]
> > +	count = atomic_read(&tt_global_entry->orig_list_count);
> > [...]
> > +	atomic_inc(&tt_global->orig_list_count);
> > [...]
> > +		atomic_set(&tt_global_entry->orig_list_count, 0);
> > [...]
> > @@ -830,12 +833,14 @@ struct batadv_tt_local_entry {
> >   * struct batadv_tt_global_entry - translation table global entry data
> >   * @common: general translation table data
> >   * @orig_list: list of orig nodes announcing this non-mesh client
> > + * @orig_list_count: number of items in the orig_list
> >   * @list_lock: lock protecting orig_list
> >   * @roam_at: time at which TT_GLOBAL_ROAM was set
> >   */
> >  struct batadv_tt_global_entry {
> >  	struct batadv_tt_common_entry common;
> >  	struct hlist_head orig_list;
> > +	atomic_t orig_list_count;
> >  	spinlock_t list_lock;	/* protects orig_list */
> >  	unsigned long roam_at;
> 
> You never decrease this orig_list_count, do you? But actually you should
> when a node leaves the group. What I've tried is:
> 
> Node 1 pings a multicast address
>  -> no group member, nothing is sent
> Node 2 is added to the group
>  -> multicast is now sent as unicast
> Node 3 is added to the group
>  -> multicast is now sent as broadcast
> Node 2 is removed from the group
>  -> multicast is still sent as broadcast (should be unicast!)
> Node 3 is removed from the group
>  -> nothing is sent (as to be expected).
> 
> Could you please check the removal case?
> 
> Thanks,
> 	Simon

Hrm, stupid regression introduced with v8 while rebasing...
Sorry and thanks for spotting it! Going to send v9 in a minute.
