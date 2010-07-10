Return-Path: <post@tiwoc.de>
Message-ID: <4C38446D.5020603@tiwoc.de>
Date: Sat, 10 Jul 2010 11:59:09 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<201007100107.57451.sven.eckelmann@gmx.de>
	<4C37C205.3030003@tiwoc.de>
	<201007101040.53995.sven.eckelmann@gmx.de>
In-Reply-To: <201007101040.53995.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On 10.07.2010 10:40, Sven Eckelmann wrote:
> Daniel Seither wrote:
>> On 10.07.2010 01:07, Sven Eckelmann wrote:
>>> batman-adv works quite well for us - but that doesn't mean that it is
>>> good in context of the current kernel development. And who should know
>>> it better than the netdev guys.
>>
>> Hagen Paul Pfeifer suggested in his message "a generalized architecture
>> and a user space implementation of the protocol". What came to my mind
>> when I read this again was a division of control plane and
>> data/forwarding plane as known from traditional routing.
>>
>> The whole forwarding stuff would stay in the kernel, using a simple
>> routing table (for destination X, send to node Y on interface Z).
> 
> This would go against the bonding/alternating functionality.

Okay. I didn't really look into this functionality yet, but slightly
extending the routing table by for example multiple next hops should do
the job, right?

> Lets check what we may remove from kernelland when move everything to 
> userspace (but don't forget, that the formular would be:
>  sizeof(kernelpart) + sizeof(userpart) >> sizeof(current kernelland part)
> 
>  * aggregation.* -> complete to userspace (but creates lot of jitter). 
>  * bat_debugfs.* -> nearly nothing moves to userspace
>  * bat_sysfs.* -> around 60-70% stays inside the kernelland
>  * bitarray.* -> stays inside the kernel
>  * hard-interface.* -> stays inside the kernel
>  * hash.* -> stays inside the kernel
>  * icmp_socket.c -> stays inside the kernel
>  * main.* -> stays inside the kernel
>  * originator.* -> moves to userspace
>  * ring_buffer.* -> moves to userspace
>  * routing.* -> 80-90% stays inside the kernel
>  * send.* -> 60% stays inside the kernel
>  * soft-interface.* -> stays inside the kernel
>  * translation-table.* -> stays inside the kernel
>  * vis.* -> moves to userspace 
> 
> This is a quite sketchy list and may misses some important points. 
> Nevertheless we see that probably most of the code is just the routing/device 
> stuff. So we could really think about splitting batman-adv in two parts: SEMF 
> (simple ethernet mesh framework) and batman-adv (the part which does the 
> discovery and route management). This doesn't mean that we really move to 
> userspace, but that we have a better separation between those two parts inside 
> the kernelland.

I agree. Thanks for analyzing the existing code; I'm not that familiar
with the gory details of batman-adv. Your suggestion should yield quite
an improvement from the point of architecture.

- Daniel
