Return-Path: <fboehm@aon.at>
References: <CAA_JP8UAMyYUrKx0nYEhRyRTM2jObS2qFwaAmN=BwD298c93Jg@mail.gmail.com>
From: fboehm <fboehm@aon.at>
Message-ID: <547999bd-e8cb-d91b-d4a3-7d385237b67b@aon.at>
Date: Wed, 1 Feb 2017 18:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAA_JP8UAMyYUrKx0nYEhRyRTM2jObS2qFwaAmN=BwD298c93Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] how to hand ptp links and still access radio
 management interfaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Am 2017-02-01 um 15:17 schrieb dan:
> I'm trying to figure out the best way to handle this:
>
> (bat0-eth1) <===> PTP Radio1 ~~~~~~~ PTP Radio2 <===> (eth1-bat0)
> (eth1 is in bat0)
>
> These radios only have 1 interface (ie, no management interface) so I
> have to handle their configuration by assigning an IP to the same
> interface I want to connect into batman-adv.
>
> I considered:
> bat0-bridge-eth1 <===> PTP Radio1 ~~~~~~~ PTP Radio2 <===> eth1-bridge-bat0
> but this means the link isn't in the mesh
>
> I don't know if this would work:
> bat0-bridge-eth1 <===> PTP Radio1 ~~~~~~~ PTP Radio2 <===> eth1-bridge-bat0
> (bat0-eth1.10)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(bat0-eth1.10)
> because I don't know if the eth1.10 vlan will be touched by the
> bridge, or if it will work with bat0 this way.
>
> The purpose here is to use higher end radios like a ubiquiti airfiber
> 5x to reduce hop-counts and increase capacity.
>
> Any thoughts?
>

I didn't test the following. So I could be totally wrong :)

Airfiber allows to configure VLAN for the management traffic. That means 
you can activate VLAN100 on the Airfiber device and create interface 
eth1.100 at the Batman-router.

Kinda like you described in your 2nd sketch. The main difference is that 
now the Airfiber management traffic is VLAN tagged and the Batman 
mesh-traffic remains untagged.

Bridging eth1.100 with bat0 should make the Airfiber device available 
everywhere in your network. Which isn't necessarily desired.

Franz
