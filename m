Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 7 Sep 2009 01:47:05 +0800
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909062311.22521.lindner_marek@yahoo.de>
	<4AA3EDCD.1090704@rsm-freilassing.de>
In-Reply-To: <4AA3EDCD.1090704@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909070147.05443.lindner_marek@yahoo.de>
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

On Monday 07 September 2009 01:13:49 Michael Rack wrote:
> Now, the reason for the tunneling-interface is totaly clear. There is no
> other solution to route internet-traffic through a specified gatway. The
> only solution will be to lable a tcp/ip-packet how MPLS does, but that
> is to fancy.

Well, we have something similar called "batman-adv". It is a kernel module 
implementing the batman protocol on layer 2.5 (using mac addresses instead of 
IPs). May be you should look into that ?


> One question: Will the P2P-Interface (gate0) shows up in a traceroute?
> The P2P-Interface have a private ip-address 169.x.x.x assigned to it. I
> use only public ip-addresses and do not want to show a private
> ip-address in a traceroute.

I have no test setup at hand but I think you always should see the gateway's 
virtual ip (0.0 at the end) if you try to traceroute a host that resides in 
the internet.

Keep in mind that the tunneling will make everything appear as a single hop no 
matter how many nodes are in between. A traceroute should look like this:

* node ip
* gw virtual ip
* internet ip1
* internet ip2
* ...


> When using the tunneling interface, the MTU is set to a lower value then
> 1500 bytes (1431 bytes). B.A.T.M.A.N have in addition to the NAT-Helper
> set the TCPMSS Flag to something like 1371 bytes (1431 bytes - 20 Bytes
> of MAC-Address and - 40 Bytes of TCP/IP Header). I found nothing about
> TCPMSS on my firewall-rules (iptables) in the table "mangle".
> 
> Without TCPMSS, packages that transport more then 1371 bytes will be
> silently dropped in my case.

Not sure how you get to these numbers (1431 / 1371) as the batman tunnel is 
running over UDP which costs 29 Bytes [20 Bytes IP + 8 Bytes UDP + 1 Byte 
batman stuff] in total, reducing the maximum packet size to 1471.

You are right about the the TCPMSS configuration - batman could set this 
automatically as well. I suggest something like this:

iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -o gate0 -j TCPMSS --clamp-
mss-to-pmtu


> Currently i have my own policy-routing-script, because B.A.T.M.A.N does
> not support HOST-Routes xxx.205.12.4/32. But why does B.A.T.M.A.N not
> fully support Host-Routes? A mash with only Host-Addresses is easier to
> administrate then complete networks. A second goal is, that the ad-hoc
> mobile user is free to change his position across the net.

Your own policy-routing-script ?
Why do you think batman does not support host routes ? I had the feeling 
batman supports host routes in all possible ways.  :-)

Cheers,
Marek


