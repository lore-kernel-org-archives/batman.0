Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 5 Jan 2016 05:45:49 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160105044549.GW2823@otheros>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
 <1450617490-3544-19-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450617490-3544-19-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 19/30] batman-adv: Convert
 batadv_dat_entry to kref
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

On Sun, Dec 20, 2015 at 02:17:59PM +0100, Sven Eckelmann wrote:
>   * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
>   * free it

A few of the newly introduced _release() functions have this "and
possibly free it" renamed to "and possibly release it", some
don't.

> - * @dat_entry: the entry to free
> + * @dat_entry: dat_entry to be free'd
>   */
>  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
>  {
> -	if (atomic_dec_and_test(&dat_entry->refcount))
> -		kfree_rcu(dat_entry, rcu);
> +	kref_put(&dat_entry->refcount, batadv_dat_entry_release);
>  }
