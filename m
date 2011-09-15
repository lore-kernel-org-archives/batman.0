Return-Path: <clownix@clownix.net>
Message-ID: <d477c5ac8b5c4fea9529957152699501.squirrel@clownix.net>
In-Reply-To: <14791148.Lch9XMektA@sven-desktop.home.narfation.org>
References: <c3913757cea624537f48fb88fb60e913.squirrel@clownix.net>
	<14791148.Lch9XMektA@sven-desktop.home.narfation.org>
Date: Thu, 15 Sep 2011 08:40:15 -0500
From: clownix@clownix.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] lxc and batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


So, for the multiplication of machines in a big network, you confirm that
batman-adv is not compatible with lxc.

However something is still not clear: with one batman-adv per namespace,
would it be possible to have what you have with kvm but with lxc?
The gain for this work would be only performance, the useful scenario
being no other than what you have with kvm: big (independant) networks.

Thanks for your answer.
Kind Regards
Vincent



> On Wednesday 14 September 2011 18:43:36 clownix@clownix.net wrote:
>> Hello,
>> I was wondering if the batman code in the kernel make batman not
>> compatible with lxc.
>>
>> Lxc are the linux containers that permit to have virtual machines with
>> the
>> least overhead (native speed) but those machines use the host's kernel.
>> If you know openvz, lxc is the same technology.
>>
>> It would be nice to be able to have lxc compatible with batman so as to
>> test big networks on a single machine.
>
> At least OpenVZ support would mean: one batman-adv instance which provides
> separate interfaces for the different namespaces.
>
> We looked at it and found no useful scenario for the OpenVZ support. And
> your
> example doesn't seem to make sense for me right now. It would be one
> batman-
> adv instance which is connected to itself... not a big virtual network.
>
> We tend to use something like kvm for big virtual network tests.
>
> Kind regards,
> 	Sven

