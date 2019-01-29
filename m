Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 29 Jan 2019 10:07:54 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190129090754.GB1528@otheros>
References: <20190127214708.GC1788@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190127214708.GC1788@otheros>
Subject: Re: [B.A.T.M.A.N.] "Kernel bug detected [...]
 nf_ct_del_from_dying_or_unconfirmed_list"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Jan 27, 2019 at 10:47:08PM +0100, Linus Lüssing wrote:
[...]
> The crash itself is triggered by the:
> 
>   BUG_ON(hlist_nulls_unhashed(&ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode));
> 
> in here:
> 
> https://elixir.bootlin.com/linux/v4.9.146/source/net/netfilter/nf_conntrack_core.c#L354

I had tried the nf_reset()s and Wang's patch but with no success.

Skimming through the code I noticed that there aren't that many
opportunities for the hnnode to become zero. There are several
hlist_nulls_del_rcu(), but no hlist_nulls_del_init_rcu()s for
instance.

That started to make me wonder whether something from "outside"
might be setting the hnnode to zero - and yeah...

I missed that batadv_send_skb_unicast() always frees/consumes the
skb... and I was freeing the skb myself if that call returned
!NET_XMIT_SUCCESS. So a double kfree_skb()... I'm a bit surprised
that things did not crash more often...

Sorry for the noise :-(. But thanks for all the help and quick
responses!
