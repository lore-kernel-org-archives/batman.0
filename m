Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F88E056.4080208@codigosur.org>
Date: Fri, 13 Apr 2012 23:26:30 -0300
From: =?UTF-8?B?Tmljb2zDoXMgRWNow6FuaXo=?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
	<20120413081501.GJ7664@lunn.ch>
	<CAKLmikNt0M4+MEQRsDH-fdnLD664+0G1pCcGKyCNWKim-6ro7Q@mail.gmail.com>
In-Reply-To: <CAKLmikNt0M4+MEQRsDH-fdnLD664+0G1pCcGKyCNWKim-6ro7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

On 04/13/2012 05:41 AM, Mitar wrote:
> Hi!
> 
> On Fri, Apr 13, 2012 at 10:15 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> How many subnets do you think you will have? Are they all using
>> classful networks or classless network?
> 
> Probably not much. At most 10 % of nodes would announce their home
> subnets too. But we should support also classless networks.

I'm curious as to why those nodes wouldn't use the same IP address space
as the net if they will be announcing their routes to the mesh anyway.

One thing to be aware of is that when a home network (on a different
subnet) is connected to the batman mesh you get some side-effects, like
for example an in-house router responding to DHCP requests...
It happens here in QuintanaLibre where one user has a router with 2 IPs,
one for the house network and another for the mesh and DHCP server
enabled using the home net address space, which sometimes "leak" to a
client in the mesh.

I understand the batman-adv mesh works almost as one big switch, so it
makes sense that this router will answer for requests... but at first I
could not understand what was happening.

One other suggestion, for VPN is to take a look at Tinc; it has a
routing (or router?) mode which might be useful in your case.


>> quagga is a well used suite of routing protocols.
>> http://www.nongnu.org/quagga/
> 
> If I understand correctly, this would allow us also easier peering
> with other networks as quagga supports also redistribution of routes
> and so on. So if we decide for OSPF, it will be easy also to setup BGP
> on border nodes within the single daemon, no?
> 
> How CPU and memory heavy it is to run it on consumer routers like
> TP-links and so on? Probably depends on number of routes and not on
> itself? But is there a big penalty of running it on all nodes?
> 
> 
> Mitar

