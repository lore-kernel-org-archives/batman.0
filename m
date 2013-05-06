Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 May 2013 04:29:46 +0800
References: <1367869192-3322-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367869192-3322-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305070429.46317.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't use call_rcu if not
	needed
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

On Tuesday, May 07, 2013 03:39:52 Antonio Quartulli wrote:
> +/**
> + * batadv_tt_global_entry_free_ref - decrement the refcounter for a
> + *  tt_global_entry and possibly free it
> + * @tt_global_entry: the object to free
> + */
>  static void
>  batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry
> *tt_global_entry) {
>         if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
>                 batadv_tt_global_del_orig_list(tt_global_entry);
> -               call_rcu(&tt_global_entry->common.rcu,
> -                        batadv_tt_global_entry_free_rcu);
> +               kfree_rcu(tt_global_entry, common.rcu);
>         }
>  }

You are replacing 2 container_of() calls with a single one. If you are sure 
that works why doesn't the compat code do that same ?

Cheers,
Marek
