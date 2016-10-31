Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 31 Oct 2016 10:57:25 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161031095725.GL7448@otheros>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <1546440.hnPT5BvDlZ@sven-edge> <20161031072217.GK7448@otheros>
 <2258656.3t3hhMR4e6@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2258656.3t3hhMR4e6@sven-edge>
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

On Mon, Oct 31, 2016 at 09:09:44AM +0100, Sven Eckelmann wrote:
> No, this is not what happens. bm_list->pprev is set by
> hlist_add_fake to &bm_list->next and not to bm_list->next.

Argh! You're absolutely right... now looks like it to me too, that a
simple hlist_add_fake(&forw_packet->bm_list) is enough in
batadv_forw_packet_steal() (and that the INIT_HLIST_NODE(bm_list)
in the alloc function is sufficient).

I'll retest, not sure what issues I thought I had seen without
the extra list head addition.
