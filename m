Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 12 Oct 2016 20:04:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161012180426.GF10902@otheros>
References: <CAGghcR53ja+D8kz+mAcLgL_rt69=4RdQ3wic1pVMWiod2yS5wQ@mail.gmail.com>
 <alpine.DEB.2.00.1610072303480.19956@nhfn.net>
 <CAGghcR6ZUP1U+p838b6fEARQOXdLiCV9aH9ZuAJ=4EDpcrCbLQ@mail.gmail.com>
 <alpine.DEB.2.00.1610101140390.25626@nhfn.net>
 <CAGghcR5CDGwxFBzwEm5jadLP+X9rBYvhDxDj=hkCH=NSHExsBg@mail.gmail.com>
 <20161011103629.GA8598@otheros>
 <CAGghcR47zo=9+jiH8L1jMRMB23ZWSZu06KYVSnzdVFR7s3JLcQ@mail.gmail.com>
 <CAGghcR7d-xuSkj7Joard+JE2ug-yHvrAxCfJ0wYa6tdybw2Aeg@mail.gmail.com>
 <CAGghcR7wro6kSZrFfC=dMrXcuFrK89i7Vjz8Vr+u+UwVTk_UnQ@mail.gmail.com>
 <20161012174646.GD10902@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161012174646.GD10902@otheros>
Subject: Re: [B.A.T.M.A.N.] Help in setting up mesh test bed using qemu -
 BATMAN adv
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

Actually, for some basic tests you could skip the netns part and
just use veth directly:

$ ip link add veth0 type veth peer name veth1
$ batctl -m bat0 if add veth0
$ batctl -m bat1 if add veth1
$ ip link set up dev veth0
$ ip link set up dev veth1
$ ip link set up dev bat0
$ ip link set up dev bat1

And then check with "batctl -m bat{0,1} originators" for instance.

Cheers, Linus


On Wed, Oct 12, 2016 at 07:46:46PM +0200, Linus Lüssing wrote:
> First result in my favorite search engine for "linux network
> namespace":
> 
> http://blog.scottlowe.org/2013/09/04/introducing-linux-network-namespaces/
> 
> Extensively describes how to set up and use network namespaces
> with veth.
> 
> Have fun :-).
> 
> Regards, Linus
> 
> 
> On Wed, Oct 12, 2016 at 10:42:30PM +0530, Kaushik N P wrote:
> > Hello,
> > 
> > @Linus, I am a bit new to this and haven't much exposure to compiling
> > kernels and all. I will try out and see what I can do with it, but a
> > little more explanation would help a lot.
> > 
> > "Then you connect the namespace via veth-pairs." Didn't get the
> > namespace and making veth-pairs part.
> > 
> > Anyways, I'll be certain to see what I can do with the code itself.
> > 
> > Thanks and regards,
> > Kaushik
> > 
> > Thanks and Regards,
> > 
> > Kaushik NP
> > LI | Tw | FB
> > SAP Ambassador,
> > General Secretary, Computer Society
> > Team IEEE UVCE,
> > 3rd Year Undergraduate Student,
> > University Visvesvaraya College of Engineering,
> > Bangalore, IN
> > 
> > 
> > On Wed, Oct 12, 2016 at 10:19 PM, Kaushik N P <kaushik.np.in@ieee.org> wrote:
> > > Hello,
> > >
> > > @Linus, I am a bit new to this and haven't much exposure to compiling
> > > kernels and all. I will try out and see what I can do with it, but a little
> > > more explanation would help a lot.
> > >
> > > "Then you connect the namespace via veth-pairs." Didn't get the namespace
> > > and making veth-pairs part.
> > >
> > > Anyways, I'll be certain to see what I can do with the code itself.
> > >
> > > Thanks and regards,
> > > Kaushik
> > >
> > >
> > > On Oct 11, 2016 4:06 PM, "Linus Lüssing" <linus.luessing@c0d3.blue> wrote:
> > >
> > > Haven't tried that myself yet, but maybe the new network namespace
> > > support in the git master branch might be an easy alternative to
> > > start with?
> > >
> > > You could first try to compile and load the batman-adv
> > > kernel module. Then you'd create a namespace for each virtual node
> > > you want to have. Then you connect the namespace via veth-pairs.
> > > And finally, within each network namespace you would hook some veth
> > > ends into a batX interface.
> > >
> > >
> > > First you could try wiring two, then three nodes manually. If
> > > that works and looks good you could then write a script to setup
> > > the testbed with an arbitrary amount of virtual nodes.
> > >
> > > Regards, Linus
> > >
> > >
