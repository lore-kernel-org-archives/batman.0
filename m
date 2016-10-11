Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 11 Oct 2016 12:36:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161011103629.GA8598@otheros>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGghcR5CDGwxFBzwEm5jadLP+X9rBYvhDxDj=hkCH=NSHExsBg@mail.gmail.com>
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

Haven't tried that myself yet, but maybe the new network namespace
support in the git master branch might be an easy alternative to
start with?

You could first try to compile and load the batman-adv
kernel module. Then you'd create a namespace for each virtual node
you want to have. Then you connect the namespace via veth-pairs.
And finally, within each network namespace you would hook some veth
ends into a batX interface.


First you could try wiring two, then three nodes manually. If
that works and looks good you could then write a script to setup
the testbed with an arbitrary amount of virtual nodes.

Regards, Linus
