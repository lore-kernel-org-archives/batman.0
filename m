Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Aug 2012 02:12:42 +0200
References: <1344606392-27130-1-git-send-email-martin@hundeboll.net>
 <3916161.gilKzHejHU@sven-desktop.home.narfation.org>
In-Reply-To: <3916161.gilKzHejHU@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208220212.43154.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused hlist macros
	in compat.h
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

On Sunday, August 12, 2012 16:43:37 Sven Eckelmann wrote:
> > -#define hlist_first_rcu(head) (*((struct hlist_node
> > **)(&(head)->first))) -#define hlist_next_rcu(node) (*((struct
> > hlist_node **)(&(node)->next))) -
> > -#define __hlist_for_each_rcu(pos, head) \
> > -     for (pos = rcu_dereference(hlist_first_rcu(head)); \
> > -          pos && ({ prefetch(pos->next); 1; }); \
> > -          pos = rcu_dereference(hlist_next_rcu(pos)))
> > -
> >
> >  #define rcu_dereference_protected(p, c) (p)
> > 
> >  #endif /* < KERNEL_VERSION(2, 6, 34) */
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 336d945.

Thanks,
Marek
