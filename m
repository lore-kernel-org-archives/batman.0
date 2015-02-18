Return-Path: <martin@hundeboll.net>
Message-ID: <54E4C964.5050304@hundeboll.net>
Date: Wed, 18 Feb 2015 18:18:28 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
 <3583975.lz5Xt4SSRR@voltaire>
In-Reply-To: <3583975.lz5Xt4SSRR@voltaire>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
 optional features
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
Cc: Sven Eckelmann <sven@narfation.org>

Hi Sven, Marek,

On 2015-02-18 08:33, Marek Lindner wrote:
> On Thursday, February 05, 2015 17:22:53 Sven Eckelmann wrote:
>> The current default settings for optional features in batman-adv seems t=
o be
>> based around the idea that the user only compiles what he requires. They
>> will automatically enabled when they are compiled in. For example the
>> network coding part of batman-adv is by default disabled in the out-of-t=
ree
>> module but will be enabled when the code is compiled during the module
>> build.
>>
>> But distributions like Debian just enable all features of the batman-adv
>> kernel module and hope that more experimental features or features with
>> possible negative effects have to be enabled using some runtime
>> configuration interface.
>
> Interesting point. Based on what you are saying we definitely should revi=
ew our
> policy and agree on sane defaults.

Sane defaults have always been one of the great values of batman-adv...

>> The network_coding feature can help in specific setups but also has
>> drawbacks and is not disabled by default in the out-of-tree module.
>> Disabling by default in the runtime config seems to be also quite sane.
>
> This feature requires the wifi driver to support promisc mode. We should =
keep
> it disabled.

I think the problem Sven mentions, is that some distro's build their=20
kernels with all_yes, and so network coding is always built in. Since NC=20
is enabled by default (runtime) when compiled in, it may run even when=20
promisc mode is not enabled/supported.

So I suggest NC being disabled runtime by default.

>> The distributed_arp_table is in theory a good solution to reduce connect=
ion
>> problems in large networks caused by ARP packet loss. Unfortunatelly, it
>> seems to also break ARP resolution in simple mesh setups. The only solut=
ion
>> which seems to be used by AP firmwares seems to be the deactivation of t=
his
>> feature. Disabling this feature by default until the problem was underst=
ood
>> and fixed may help new deployments to create a working mesh. Tuning of t=
he
>> mesh can still be done by them in case DAT works in their setup.
>
> I vote for keeping DAT enabled.

++

>> The bridge_loop_avoidance is the only feature which is disabled by defau=
lt
>> but may be necessary even in simple setups. Packet loops may even be
>> created during the initial node setup when this is not enabled. This is
>> different than STP on bridges because mesh is usually used on Adhoc WiFi.
>> Having two nodes (by accident) in the same LAN segment and in the same m=
esh
>> network is rather common in this situation.
>
> Agreed.

++

--=20
Kind Regards,
Martin Hundeb=F8ll
Frederiks All=E9 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
