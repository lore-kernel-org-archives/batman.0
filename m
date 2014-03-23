Return-Path: <itamar@itamar.org>
Message-ID: <532E98EB.6070201@itamar.org>
Date: Sun, 23 Mar 2014 10:18:51 +0200
From: Itamar <itamar@itamar.org>
MIME-Version: 1.0
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>	<53218FEB.8000100@meshcoding.com>	<CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>	<5321B5AE.9080005@meshcoding.com>
 <CAMcTwKrw+U7xZckqmcurrc8z4UZTkt50SqQ_esFHKo_D2Grf_A@mail.gmail.com>
 <5325A449.3080905@itamar.org> <53267792.8080102@meshcoding.com>
In-Reply-To: <53267792.8080102@meshcoding.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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

Thanks all for your support,
U have figured out the issue. I is indeed related to a driver issue (so 
I now understand).
grinding my teeth trying to debug I have realized that when I power 
cycle the raspberry-pi the link returns. Whereas I do a reboot via 
console, the link refuses to start. The issue is probably related to the 
wifi card not being initialized properly when the driver is loaded. What 
I did to resolve is simple. I have added some extra lines to to 
initialization script of the wireless device;

ifconfig ra0 up
ifconfig ra0 down
ifconfig ra0 up
iwconfig ra0 mode monitor

And after this "morning sport activity" to the interface I continued as 
usual, setting it to ad-hoc and adding it to the bat0 device.

The interface I use is a cheap ralink 7601 chipset usb wifi 
(idVendor=148f, idProduct=7601). But maybe this may help whoever 
stumbles into something similar.

Thanks for the help!
Itamar

On 14-03-17 06:18 AM, Antonio Quartulli wrote:
>
> On 16/03/14 14:16, Itamar wrote:
>> I have compiled both the kernel module and batctl from source (2014.1.0).
>> The problem remains. Whenever I reboot a node, its IP is never reachable
>> from the network and the network can not be reached by it.
>>
>> Things I have tried:
>>
>> * DAT enabled
>> * DAT Disabled
>> * DAT not compiled (ticked "n" in the Makefile)
>>
>> Of course, the tests were performed when all nodes in the mesh were with
>> the consistent configuration and never mixed.
>>
>> Another curious thing I have seen is that when looking at a tcpdump (via
>> batctl) I could indeed see ARP requests to the pinged IP (the tcpdump
>> running on the node hosting the pinged IP) but the node never replies.
>>
> Have you seen if the ARP request makes its way to the other host? (e.g.
> using tcpdump on bat0 to check that the packet is getting delivered).
>
> Then check if the ARP reply is at least sent. If so, check where it gets
> lost.
>
>
> Cheers,
>
>
>

