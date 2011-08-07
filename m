Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Aug 2011 15:25:29 +0200
References: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201108071525.29452.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] "Distributed" DHCP vs gateway
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

> Now, what if the network is fractured and the same IP address gets
> assigned to a router (and thus is used as a prefix for that router's
> clients) on each side of the split?  When the segments join up, we'll have
> multiple nodes with the same IP address and this will cause problems.
> 
> Yes.  The lease times will be very short, so this type of problem should
> resolve itself quickly.

you are overlooking the fact that you can't be sure each gateway receives 
every DHCP packet even if you have a single network cell. On wireless you 
always have packet loss as opposed to wired networks. Therefore this approach 
won't be reliable. You can try things like arping nodes, etc but at the end of 
the day you will always hit the same wall: Just because nodeX did not receive 
a packet / can't reach nodeY you must not assume it does not exist.


> But, what do I do about how the gateway business interferes with DHCP?
> Could I somehow have two DHCP servers serving the same interface?  One
> that serves out IP addresses and one that deals only with gateways?

Why not simply disable the "gateway business" ? Or better, not enabling it - 
the gateway extension is disabled per default.

Regards,
Marek
