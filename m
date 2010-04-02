Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Apr 2010 00:00:16 +0800
References: <201004020054.08840.clemens-john@gmx.de>
In-Reply-To: <201004020054.08840.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004030000.16637.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
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


Hi,

> The problem is, that I have a vpn network on tap0 (10.18.0.0/24) and I
>  dont  know how I can link this two networks/interfaces to each other with
>  batman. I tried to assign tap0 to batman, but this doesnt work.
> 
> I want to be able to ping hosts that uses batman in the vpn and in the
>  wlan  network. How can I do this?

I have been reading the other mails but I don't fully understand what you are 
trying to achieve here. Nevertheless, I'll try to write something. If I got it 
all wrong, please let me know.  :-)

It is important to keep in mind that IP addresses are totally irrelevant to 
make this setup work. I mention this since you seem to have experience with 
layer 3 routing. Even if the tap interfaces had no IP addresses batman-adv 
would route the traffic through. Unless you need to access services on the VPN 
interfaces via IPs you can safely run them without.

If you IP networks don't share the same broadcast domain (e.g. 10.18.1.0/24 vs 
10.18.0.0/24) batman-adv won't propate IP routing entries because it assumes 
that is what you want. To resolve this you have 2 choices:

The easy way:
Move all nodes into the same broadcast domain. All nodes will be able to 
communicate with each other without problems. Disadvantage: If you have many 
nodes (100+) in close range it will create considerable (ethernet) broadcast 
overhead.

The routing way:
Let your VPN nodes know how to reach to "other" IP networks by adding routing 
entries. Naturally, this will reduce the broadcast overhead but requires a 
mechanism to distribute the routes (as batman-adv won't do it for you). There 
a couple of standard ways you can choose from. Depending on your setup & needs 
one or the other might be more interesting to use which brings us back to my 
initial question.  :-)

Regards,
Marek
