Return-Path: <fw@strlen.de>
Date: Mon, 28 Jan 2019 15:13:17 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190128141317.pxq7vklx346bv2bu@breakpoint.cc>
References: <20190127214708.GC1788@otheros>
 <20190127224822.lsagihtfiuvxyool@breakpoint.cc>
 <CALJUYjOq-xpjorsfnMRthzmC+iuDTVOPHXRb2p3ahU248Jrw4w@mail.gmail.com>
 <20190128133940.jxwuscyi2wvbfb52@breakpoint.cc>
 <20190128135030.xmtngyqaq3p74iug@salvia>
 <CALJUYjO4=pDT0COGJRx2YWDMiEJTpa2CdqQqxndd93khVDZHjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJUYjO4=pDT0COGJRx2YWDMiEJTpa2CdqQqxndd93khVDZHjA@mail.gmail.com>
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
To: Chieh-Min Wang <chiehmin18@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Linus =?iso-8859-15?Q?L=FCssing?= <linus.luessing@c0d3.blue>, netfilter-devel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Chieh-Min Wang <chiehmin18@gmail.com> wrote:
> I think 71d8c47fc653711c4(netfilter: conntrack: introduce clash
> resolution on insertion race) is doing the same logic for resolving
> conntrack clashing.

No, that commit dealsl with the case where two skbs have different
conntrack objects but where tuples are the same.

In nfqueue+bridge flood case the skbs point to the same conntrack
object.

Maybe one way to fix this would be to let nfqueue perform a deep
copy of skb->_nfct in case conntrack is unconfirmed and skb_shared()
is true.

But that would of course cause drop for l4 protocols that do not support
clash resolution.

