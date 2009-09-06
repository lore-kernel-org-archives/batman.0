Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4AA3EDCD.1090704@rsm-freilassing.de>
Date: Sun, 06 Sep 2009 19:13:49 +0200
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909062311.22521.lindner_marek@yahoo.de>
In-Reply-To: <200909062311.22521.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Am 06.09.2009 17:11, schrieb Marek Lindner:
>
>
> I don't understand why you have the feeling the gate0 interface is a problem.
> As Elektra explained choosing a default gateway by "inserting a default route"
> is meaningless (in a mesh). If each client should be able to choose its own
> gateway there is no way around the tunnel mechanism.
>

Sorry but i had not the right view of the tunneling-interface.

Now, the reason for the tunneling-interface is totaly clear. There is no 
other solution to route internet-traffic through a specified gatway. The 
only solution will be to lable a tcp/ip-packet how MPLS does, but that 
is to fancy.

One question: Will the P2P-Interface (gate0) shows up in a traceroute? 
The P2P-Interface have a private ip-address 169.x.x.x assigned to it. I 
use only public ip-addresses and do not want to show a private 
ip-address in a traceroute.

When using the tunneling interface, the MTU is set to a lower value then 
1500 bytes (1431 bytes). B.A.T.M.A.N have in addition to the NAT-Helper 
set the TCPMSS Flag to something like 1371 bytes (1431 bytes - 20 Bytes 
of MAC-Address and - 40 Bytes of TCP/IP Header). I found nothing about 
TCPMSS on my firewall-rules (iptables) in the table "mangle".

Without TCPMSS, packages that transport more then 1371 bytes will be 
silently dropped in my case.

Now i will give B.A.T.M.A.N a second try and will use the little tricky 
solution to add two /1 subnets. Thanks to Elektra.

> I suggest to use the --policy-routing-script [1] option to modify the routing
> tables on the fly.

Currently i have my own policy-routing-script, because B.A.T.M.A.N does 
not support HOST-Routes xxx.205.12.4/32. But why does B.A.T.M.A.N not 
fully support Host-Routes? A mash with only Host-Addresses is easier to 
administrate then complete networks. A second goal is, that the ad-hoc 
mobile user is free to change his position across the net.

I use only host-addresses to safe ip-addresses.

Michael.
