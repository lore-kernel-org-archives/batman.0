Return-Path: <pablo@netfilter.org>
Date: Mon, 28 Jan 2019 14:50:30 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190128135030.xmtngyqaq3p74iug@salvia>
References: <20190127214708.GC1788@otheros>
 <20190127224822.lsagihtfiuvxyool@breakpoint.cc>
 <CALJUYjOq-xpjorsfnMRthzmC+iuDTVOPHXRb2p3ahU248Jrw4w@mail.gmail.com>
 <20190128133940.jxwuscyi2wvbfb52@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128133940.jxwuscyi2wvbfb52@breakpoint.cc>
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
To: Florian Westphal <fw@strlen.de>
Cc: Chieh-Min Wang <chiehmin18@gmail.com>, Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, netfilter-devel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

On Mon, Jan 28, 2019 at 02:39:40PM +0100, Florian Westphal wrote:
> Chieh-Min Wang <chiehmin18@gmail.com> wrote:
> > I think this is the same issue as this one.
> > 
> > http://patchwork.ozlabs.org/patch/995825/
> 
> Yes, likely.

I see.

I don't think letting the packet go through is a good idea. Not sure
NAT will work fine, packets would go through being unmangled? I think
we should still drop the packet until we fix this.
