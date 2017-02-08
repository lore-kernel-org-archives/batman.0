Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f2f7a980-c7c0-8b71-a4f7-4a4c7501f3d5@aon.at>
References: <CAA_JP8UAMyYUrKx0nYEhRyRTM2jObS2qFwaAmN=BwD298c93Jg@mail.gmail.com>
 <f2f7a980-c7c0-8b71-a4f7-4a4c7501f3d5@aon.at>
From: dan <dandenson@gmail.com>
Date: Wed, 8 Feb 2017 16:33:08 -0700
Message-ID: <CAA_JP8WHB+SbkFWc3CCqY_tyPPq57X+hbHUH2bni62qqiSvnYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Will that work?

bat0 is untagged
bat0 contains eth0

bat1 is for management
bat1 contains eth0.10


I thought that bat0 could trunk VLANs if the MTU is 1528? (1500 + 24
batman-adv overhead + 4 VLAN)

So which wins?  If bat0 has a VLAN10 traversing it, but eth0.10 is in
bat0, then something breaks.







On Wed, Feb 1, 2017 at 10:57 AM, fboehm <fboehm@aon.at> wrote:
> I didn't test the following. So I could be totally wrong :)
>
> Airfiber allows to configure VLAN for the management traffic. That means you
> can activate VLAN100 on the Airfiber device and create interface eth1.100 at
> the Batman-router.
>
> Kinda like you described in your 2nd sketch. The main difference is that now
> the Airfiber management traffic is VLAN tagged and the Batman mesh-traffic
> remains untagged.
>
> Bridging eth1.100 with bat0 should make the Airfiber device available
> everywhere in your network. Which isn't necessarily desired.
>
> Franz
>
> Am 2017-02-01 um 15:17 schrieb dan:
>>
>> I'm trying to figure out the best way to handle this:
>>
>> (bat0-eth1) <===> PTP Radio1 ~~~~~~~ PTP Radio2 <===> (eth1-bat0)
>> (eth1 is in bat0)
>>
>> These radios only have 1 interface (ie, no management interface) so I
>> have to handle their configuration by assigning an IP to the same
>> interface I want to connect into batman-adv.
>>
>> I considered:
>> bat0-bridge-eth1 <===> PTP Radio1 ~~~~~~~ PTP Radio2 <===>
>> eth1-bridge-bat0
>> but this means the link isn't in the mesh
>>
>> I don't know if this would work:
>> bat0-bridge-eth1 <===> PTP Radio1 ~~~~~~~ PTP Radio2 <===>
>> eth1-bridge-bat0
>> (bat0-eth1.10)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(bat0-eth1.10)
>> because I don't know if the eth1.10 vlan will be touched by the
>> bridge, or if it will work with bat0 this way.
>>
>> The purpose here is to use higher end radios like a ubiquiti airfiber
>> 5x to reduce hop-counts and increase capacity.
>>
>> Any thoughts?
>>
>
