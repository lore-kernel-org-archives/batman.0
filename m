Return-Path: <chiehmin18@gmail.com>
MIME-Version: 1.0
References: <20190127214708.GC1788@otheros>
 <20190127224822.lsagihtfiuvxyool@breakpoint.cc>
 <CALJUYjOq-xpjorsfnMRthzmC+iuDTVOPHXRb2p3ahU248Jrw4w@mail.gmail.com>
 <20190128133940.jxwuscyi2wvbfb52@breakpoint.cc>
 <20190128135030.xmtngyqaq3p74iug@salvia>
 <CALJUYjO4=pDT0COGJRx2YWDMiEJTpa2CdqQqxndd93khVDZHjA@mail.gmail.com>
 <20190128141317.pxq7vklx346bv2bu@breakpoint.cc>
In-Reply-To: <20190128141317.pxq7vklx346bv2bu@breakpoint.cc>
From: Chieh-Min Wang <chiehmin18@gmail.com>
Date: Mon, 28 Jan 2019 22:16:26 +0800
Message-ID: <CALJUYjMM7EJVxxhh_q=607yn7OXhfnhrnk+m=tQ7C8GJjOCDcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>, netfilter-devel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Yes, I understand the cases are different.

However, the result after resolving clashing will cause two skb point
to the same conntrack.
The first skb with confirmed conntrack may not pass through the NAT
when the second skb resolve clashing?

Florian Westphal <fw@strlen.de> =E6=96=BC 2019=E5=B9=B41=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Chieh-Min Wang <chiehmin18@gmail.com> wrote:
> > I think 71d8c47fc653711c4(netfilter: conntrack: introduce clash
> > resolution on insertion race) is doing the same logic for resolving
> > conntrack clashing.
>
> No, that commit dealsl with the case where two skbs have different
> conntrack objects but where tuples are the same.
>
> In nfqueue+bridge flood case the skbs point to the same conntrack
> object.
>
> Maybe one way to fix this would be to let nfqueue perform a deep
> copy of skb->_nfct in case conntrack is unconfirmed and skb_shared()
> is true.
>
> But that would of course cause drop for l4 protocols that do not support
> clash resolution.
>
