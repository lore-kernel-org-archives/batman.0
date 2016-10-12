Return-Path: <kaushik.np.in@ieee.org>
MIME-Version: 1.0
In-Reply-To: <CAGghcR7d-xuSkj7Joard+JE2ug-yHvrAxCfJ0wYa6tdybw2Aeg@mail.gmail.com>
References: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
 <15be6bcfa10965e93dcfa6b609ade0cf@riseup.net>
 <CAGghcR59sCzYh5O3uhTkRrp__X6SNZMN5X-SKMQScrVWEZoUgQ@mail.gmail.com>
 <57F66926.2070404@rund.freifunk.net>
 <CAGghcR7QjF+yugxao-P5YsB_TkC_0D_YU2tc0+dinN9AJhZX9w@mail.gmail.com>
 <CAGghcR53ja+D8kz+mAcLgL_rt69=4RdQ3wic1pVMWiod2yS5wQ@mail.gmail.com>
 <alpine.DEB.2.00.1610072303480.19956@nhfn.net>
 <CAGghcR6ZUP1U+p838b6fEARQOXdLiCV9aH9ZuAJ=4EDpcrCbLQ@mail.gmail.com>
 <alpine.DEB.2.00.1610101140390.25626@nhfn.net>
 <CAGghcR5CDGwxFBzwEm5jadLP+X9rBYvhDxDj=hkCH=NSHExsBg@mail.gmail.com>
 <20161011103629.GA8598@otheros>
 <CAGghcR47zo=9+jiH8L1jMRMB23ZWSZu06KYVSnzdVFR7s3JLcQ@mail.gmail.com>
 <CAGghcR7d-xuSkj7Joard+JE2ug-yHvrAxCfJ0wYa6tdybw2Aeg@mail.gmail.com>
From: Kaushik N P <kaushik.np.in@ieee.org>
Date: Wed, 12 Oct 2016 22:42:30 +0530
Message-ID: <CAGghcR7wro6kSZrFfC=dMrXcuFrK89i7Vjz8Vr+u+UwVTk_UnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hello,

@Linus, I am a bit new to this and haven't much exposure to compiling
kernels and all. I will try out and see what I can do with it, but a
little more explanation would help a lot.

"Then you connect the namespace via veth-pairs." Didn't get the
namespace and making veth-pairs part.

Anyways, I'll be certain to see what I can do with the code itself.

Thanks and regards,
Kaushik

Thanks and Regards,

Kaushik NP
LI | Tw | FB
SAP Ambassador,
General Secretary, Computer Society
Team IEEE UVCE,
3rd Year Undergraduate Student,
University Visvesvaraya College of Engineering,
Bangalore, IN


On Wed, Oct 12, 2016 at 10:19 PM, Kaushik N P <kaushik.np.in@ieee.org> wrot=
e:
> Hello,
>
> @Linus, I am a bit new to this and haven't much exposure to compiling
> kernels and all. I will try out and see what I can do with it, but a litt=
le
> more explanation would help a lot.
>
> "Then you connect the namespace via veth-pairs." Didn't get the namespace
> and making veth-pairs part.
>
> Anyways, I'll be certain to see what I can do with the code itself.
>
> Thanks and regards,
> Kaushik
>
>
> On Oct 11, 2016 4:06 PM, "Linus L=C3=BCssing" <linus.luessing@c0d3.blue> =
wrote:
>
> Haven't tried that myself yet, but maybe the new network namespace
> support in the git master branch might be an easy alternative to
> start with?
>
> You could first try to compile and load the batman-adv
> kernel module. Then you'd create a namespace for each virtual node
> you want to have. Then you connect the namespace via veth-pairs.
> And finally, within each network namespace you would hook some veth
> ends into a batX interface.
>
>
> First you could try wiring two, then three nodes manually. If
> that works and looks good you could then write a script to setup
> the testbed with an arbitrary amount of virtual nodes.
>
> Regards, Linus
>
>
