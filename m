Return-Path: <vinay@orxrail.com>
Message-ID: <4D6BF3B3.8040509@orxrail.com>
Date: Mon, 28 Feb 2011 14:12:51 -0500
From: Vinay Tharigopula <vinay@orxrail.com>
MIME-Version: 1.0
References: <4D668F3F.4080700@orxrail.com>	<201102250130.35865.lindner_marek@yahoo.de>	<4D67B241.8070606@orxrail.com>
	<201102262349.52282.lindner_marek@yahoo.de>
In-Reply-To: <201102262349.52282.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv mesh slows down wired clients
	(bridge-loop-avoidance)
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

Linus , Marek...

I think the List had issues with all of us getting multiple emails for 
some reason. I wanted to update you on this status and let others know 
about my solution.

Linus, in the problem that I described after updating to batman-adv 
2011.0, I would lose connection to both the routers that were plugged 
in. Any SSH connection already established also would timeout. Therefore 
I can't get the output of batctl ping or dmesg at that exact instant. I 
did try to do a tcp dump but got nowhere because of the disconnects.

Now here is how I (kinda) solved it.

I had to enable STP on the lan-switches.  STP type: STP and Mode: Root 
Protection. This can be enabled on all ports safely without causing 
disruption to the clients plugged into the switch.

After this step was done, bridge-loop-avoidance worked properly and if 
more than 1 router in a mesh was plugged in, all the routers would pick 
one as a gateway.

Extra Bonus Step:

If more than one is plugged in, the higher MAC router will drop all lan 
packets which will result in slower throughput to clients to that router 
because it is hopping to another router via wireless and neglecting the 
fact that it's own wired link would take it faster to the intended 
destination.

My "solution" to this was to enable STP in the router too. In the UCI 
page for networking, under the br-lan, I had this option.

option 'stp' '1'.

After this setting, the 2nd router would choose the wired link as its 
preferred method of linking to the network.

The customary "warning" : I am no network expert and I am just offering 
a solution for anybody else reading this.

Thanks for all your help Linus and Marek. Please do let me know if you 
have any explanation for this :) . If you want me to send some of the 
binaries I built or my OpenWRT config files to the list, I can do so . 
Let me know.

Thanks

Vinay.

My specific setup:

Routers   : 8  x  Buffalo WZR - HP -G 300NH
Switches : 6  x 3Com 5500G-EI.



On 2/26/2011 5:49 PM, Marek Lindner wrote:
> Hi,
>
> Linus has some problems sending mails to the list, so I forward his reply.
>
> Cheers,
> Marek
>
>
> ============================================
>
>
> Hi Vinay,
>
> On Fri, Feb 25, 2011 at 08:44:33AM -0500, Vinay Tharigopula wrote:
>> Marek..
>>
>> I got the binaries from the openwrt prebuilt packages. However,
>> now
>> I rebuilt the image and built batman-adv 2011.myself. I will try
>> this now and let you know.
>>
>> However, now I am running into a much bigger issue. If two
>> routers
>> are plugged in to the same switch, bridge loop avoidance doesnt
>> work
>> and both of them are stopping responding to pings.
> Could you try "batctl ping" too and check whether this is working
> or not.
>
> If that's working but the normal pinging is not, then it should be
> a layer 3 problem - in that case we'd need the outputs of "ip
> route show" and "ip address show".
>
> If batctl ping is already not working then "batctl o" and "batctl
> if" output will be interesting.
>> Here is my config.
>>
>> bat0 if:
>> wlan1: active.
>>
>> wlan1: Mesh Network.
>>
>> wlan0: Infrastructure network.
>> eth0 : 4 lan ports
>> eth1: 1 wan port
>>
>> br-lan : wlan0 eth0 eth1 bat0
> Hmm, that looks sane and correct, should work like that.
>
> Is there anything weird in the output of "dmesg"? Any errors or
> warnings?
>
> Cheers, Linus

