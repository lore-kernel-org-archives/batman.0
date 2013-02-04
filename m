Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-37ee694d-d9f0-43cf-8714-9311142e7837-1359979779496@3capp-webde-bs03>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Mon, 4 Feb 2013 13:09:39 +0100 (CET)
In-Reply-To: <CAM8o6HRvyK7LjLJezRNjBzAZg9Mwe+phyE+raPJTg_uxB7Y9Yw@mail.gmail.com>
References: <CAM8o6HRAd7FWEyYv+GktSHaDsqJ3UJefnXjui86JVfV2fzXxeg@mail.gmail.com>, 
 <CAM8o6HRvyK7LjLJezRNjBzAZg9Mwe+phyE+raPJTg_uxB7Y9Yw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Help and Suggestions Please! :)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi Ashwin,

> Gesendet: Donnerstag, 31. Januar 2013 um 17:04 Uhr
> Von: "Ashwin Chauhan" <ashwin.chauhan05@gmail.com>
> An: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>
> Betreff: [B.A.T.M.A.N.] Help and Suggestions Please! :)
>
> I'm a Computer Science Final Year Undergraduate student. We are a
> group of Four students and are wanting to do our final group project
> on B.A.T.M.A.N protocol. Can you help us with the simulating a simple
> sample network.

For simulating various network topologies with batman-adv, kvm is quite
often used. Have a look at: http://www.open-mesh.org/projects/open-mesh/wiki/Emulation

> 
> Also I was thinking, If instead of Broadcasting the OGM Packets every
> time into the network, we could broadcast them the first time a node
> joins the network and then just Multicast the OGM packets to its
> one-hop neighbours from the next time. So that their immediate nodes
> are still informed about the existence of the node in the network.
> This way we can reduce the unnecessary flooding of packets. Also when
> a node moves out of the network its immediate node would know about it
> much faster and can then broadcast it to other nodes.

   B
 /   \
A     D
 \   /
   C

If, let's say D wants to forward packets to A and sometimes the path
via B and sometimes the one via C is better due to link quality changes
between A-B and A-C. How is D supposed to learn about the better route
if link quality changes on A-B and A-C do not propagate any further?

> 
>  Trying to do our final year project in this area.
> Also can someone suggest us some ideas to work upon as our final year
> Project. :)

There's a list of rough ideas from the last Google Summer of Codes:
http://wiki.freifunk.net/Ideas#batman-adv

Cheers, Linus

> 
> 
> 
> --
> 
> Ashwin
> 
