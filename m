Return-Path: <chiehmin18@gmail.com>
MIME-Version: 1.0
References: <20190127214708.GC1788@otheros>
 <20190127224822.lsagihtfiuvxyool@breakpoint.cc>
 <CALJUYjOq-xpjorsfnMRthzmC+iuDTVOPHXRb2p3ahU248Jrw4w@mail.gmail.com>
 <20190128133940.jxwuscyi2wvbfb52@breakpoint.cc>
 <20190128135030.xmtngyqaq3p74iug@salvia>
In-Reply-To: <20190128135030.xmtngyqaq3p74iug@salvia>
From: Chieh-Min Wang <chiehmin18@gmail.com>
Date: Mon, 28 Jan 2019 22:03:28 +0800
Message-ID: <CALJUYjO4=pDT0COGJRx2YWDMiEJTpa2CdqQqxndd93khVDZHjA@mail.gmail.com>
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
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>, netfilter-devel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

I think 71d8c47fc653711c4(netfilter: conntrack: introduce clash
resolution on insertion race) is doing the same logic for resolving
conntrack clashing.

The first packet who win the race should handle the NAT stuff on the
conntrack right?

Pablo Neira Ayuso <pablo@netfilter.org> =E6=96=BC 2019=E5=B9=B41=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:50=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, Jan 28, 2019 at 02:39:40PM +0100, Florian Westphal wrote:
> > Chieh-Min Wang <chiehmin18@gmail.com> wrote:
> > > I think this is the same issue as this one.
> > >
> > > http://patchwork.ozlabs.org/patch/995825/
> >
> > Yes, likely.
>
> I see.
>
> I don't think letting the packet go through is a good idea. Not sure
> NAT will work fine, packets would go through being unmangled? I think
> we should still drop the packet until we fix this.
