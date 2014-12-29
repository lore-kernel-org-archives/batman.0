Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 29 Dec 2014 15:32:02 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20141229143202.GA2431@odroid>
References: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
 <1869722.k5Ufm3Cai9@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1869722.k5Ufm3Cai9@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix potential TT
 client + orig-node memory leak
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

On Mon, Dec 29, 2014 at 11:52:53AM +0800, Marek Lindner wrote:
> > The issue this patch fixes is caused by batadv_orig_node_free_rcu()
> > never being called because of not yet released references to the
> > orig-node. References which were supposed to be released through
> > batadv_orig_node_free_rcu()->batadv_tt_global_del_orig().
> 
> Could you please provide addition insight as to which references are still 
> held ? I did look around but nothing obvious jumped at me. 

The batadv_tt_global_entry->orig_list holds the reference to the
orig-node. Usually this reference is released after
BATADV_PURGE_TIMEOUT through: _batadv_purge_orig()->
batadv_purge_orig_node()->batadv_update_route()->_batadv_update_route()->
batadv_tt_global_del_orig() which purges this global tt entry and
releases the reference to the orig-node.

However, if between two batadv_purge_orig_node() calls the orig-node
timeout grew to 2*BATADV_PURGE_TIMEOUT then this call path isn't
reached (*). Instead the according orig-node is removed from the
originator hash in _batadv_purge_orig(), the batadv_update_route()
part is skipped and won't be reached anymore.

It seems that in that case batadv_orig_node_free_rcu()->batadv_tt_global_del_orig()
is supposed to purge the global tt entry and to release the orig-node
reference but it's not called because batadv_orig_node_free_rcu() is
only called once all references are freed: A chicken 'n' egg
situation.

> 
> Generally, it wouldn't be bad if the commit message went into deeper detail 
> describing the nature of the bug instead of the middle section above to make 
> it easy to understand what is being fixed.

Hm, hm, my intention was to somehow/somewhere document how these
two, small and rare bugs together created this severe bug.
The issue fixed by 8a2ad5204674 was the main trigger for (*) in
previous releases.

But we can also skip that middle section if you want. Then I'll
just add a note to the ticket on redmine.

> 
> 
> Cheers,
> Marek

Cheers, Linus
