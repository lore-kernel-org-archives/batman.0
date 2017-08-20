Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170820140507.GA24150@lunn.ch>
References: <CAA_JP8UHmeHu_UavyVt9tXQ27AVOdNcznZnuCib3xoSDB0V8Tw@mail.gmail.com>
 <5468456.iLjU66Egku@sven-edge> <20170820140507.GA24150@lunn.ch>
From: dan <dandenson@gmail.com>
Date: Sun, 20 Aug 2017 11:48:45 -0600
Message-ID: <CAA_JP8Us6GdMpxVhoREG1J1PfXQ-G5jb=-r__B_Ot5wuLFK9Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] wired performance
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

On Sun, Aug 20, 2017 at 8:05 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> And there is currently no special batman-adv support for the flow
>> dissector [1] in the kernel. This could be also a reason why multiple flows
>> are not distributed well to different cores when you enable RPS/XPS. It is not
>> yet know whether this will actually be helpful but at least someone interested
>> could do same research and implement a proof-of-concept patches for further
>> testing.
>
> Hi Sven
>
> DSA just added a patch to help with flow dissectors. Maybe it can be
> generalized and made to work for BATMAN as well?
>
> commit 43e665287f931a167cd2eea3387efda901bff0ce
> Author: John Crispin <john@phrozen.org>
> Date:   Wed Aug 9 14:41:19 2017 +0200
>
>     net-next: dsa: fix flow dissection
>
>     RPS and probably other kernel features are currently broken on some if not
>     all DSA devices. The root cause of this is that skb_hash will call the
>     flow_dissector. At this point the skb still contains the magic switch
>     header and the skb->protocol field is not set up to the correct 802.3
>     value yet. By the time the tag specific code is called, removing the header
>     and properly setting the protocol an invalid hash is already set. In the
>     case of the mt7530 this will result in all flows always having the same
>     hash.

Ok, maybe virtualbox specific slowness then.  I'm running batman-adv
2015.2 on ubuntu kernel 4.4.0, so a little out of date.

I'm actually wanting to target something embedded, like a pc-engines
APU2c4.  It has 3 onboard ethernets and I can add up to 8 more via
pci-e.  But that has a 1Ghz CPU (quad core) and being stuck on 1 core
1/4ers the potential.

The test network I'm designing is handling wireless PtP backhauls and
having batman-adv make all tower sites look like a single switch,
almost list a replacement for shortest path bridging.  1Gbps would be
the real base line performance here.

I have another question on the list about running on top of vlans,
specifically do to something like router-on-a-stick with a wisp
specific PoE switch and running a vlan across backhaul links and
putting those vlans in batman-adv.  That way I don't have issue
accessing the ptp link interfaces themselves.
