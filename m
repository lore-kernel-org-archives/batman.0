Return-Path: <vinay@orxrail.com>
Message-ID: <4D67D576.7070809@orxrail.com>
Date: Fri, 25 Feb 2011 11:14:46 -0500
From: Vinay Tharigopula <vinay@orxrail.com>
MIME-Version: 1.0
References: <4D668F3F.4080700@orxrail.com>	<20110224194414.GA15337@Sellars>	<4D66BBC9.80101@orxrail.com>	<201102250130.35865.lindner_marek@yahoo.de>
	<4D67B241.8070606@orxrail.com>
In-Reply-To: <4D67B241.8070606@orxrail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv mesh slows down
	wired	clients	(bridge-loop-avoidance)
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Update on this...

As I said previously, after updating to the latest batman-adv,  both 
routers connected to the lan stopped responding to pings.

I was playing around with the switch settings and setting " Edge + Root 
protection with STP" on the ports connected to the routers wired 
connection brought them back.  Now they act according to the bridge-loop 
avoidance document and pick one of the routere to be the primary router 
to the lan.

Any idea why this is happening ?

Thanks

Vinay


On 2/25/2011 8:44 AM, Vinay Tharigopula wrote:
> Marek..
>
> I got the binaries from the openwrt prebuilt packages. However, now I 
> rebuilt the image and built batman-adv 2011.myself. I will try this 
> now and let you know.
>
> However, now I am running into a much bigger issue. If two routers are 
> plugged in to the same switch, bridge loop avoidance doesnt work and 
> both of them are stopping responding to pings.
>
> Here is my config.
>
> bat0 if:
> wlan1: active.
>
> wlan1: Mesh Network.
>
> wlan0: Infrastructure network.
> eth0 : 4 lan ports
> eth1: 1 wan port
>
> br-lan : wlan0 eth0 eth1 bat0
>
>
> In case anybody else wants the binaries for Openwrt 10.03.1 RC 4 , let 
> me know I can send it to you.
>
>
> -Vinay
>
> On 2/24/2011 7:30 PM, Marek Lindner wrote:
>> Hi Vinay,
>>
>>> I am having trouble finding binaries of batman-adv 2011.0 for OpenWRT .
>>> Are they available or do I have to build them myself  ?
>> as Linus already pointed out - bridge loop avoidance is not available 
>> before
>> batman-adv 2011.0.0. That is what you need to address first.
>>
>> Where did you get the binaries for batman-adv 2010.1.0 ? Does this 
>> source also
>> provide newer binaries ? Unlike user space application a kernel 
>> module heavily
>> depends on your system (kernel version / patches / etc). Which means 
>> nobody
>> can give you binaries without having access to exactly the same 
>> system you are
>> using.
>>
>> Regards,
>> Marek
>

