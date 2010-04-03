Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Apr 2010 12:54:02 +0800
References: <201004020054.08840.clemens-john@gmx.de>
	<201004030000.16637.lindner_marek@yahoo.de>
	<4BB61A71.9070702@nord-west.org>
In-Reply-To: <4BB61A71.9070702@nord-west.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004031254.02506.lindner_marek@yahoo.de>
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

On Saturday 03 April 2010 00:25:21 Bjoern Franke wrote:
> Which ways are you thinking of?
> 
> Our initial problem is:
> - several node-clouds, connected via openvpn
> - these nodes also use the vpn as a gateway in the world wide web
> - the gateway also monitores the nodes, so it must be able to access the
> nodes, but it runs in openvz VE, so the kernelland-module is not usable

Ok, since your setup is rather small I would suggest going with the easiest 
solution possible. I'm always a big fan of making little steps that work well 
instead of aiming for the big goal which you never reach because you die in 
the process of getting there.

In a classical batman-adv setup the router(s) with the internet connection run 
a DHCP server and provide IPs/default route/etc for all the nodes & wifi-
clients in range. 

To connect the VPNs I see 2 feasible approaches:
* You run batman-adv over the VPN which will bring some overhead since the 
routing messages will be relayed over the VPN. Depending on the number of 
nodes this may or may not be an issue. To keep things simple all nodes run in 
the same IP address space.
* Alternatively you can route over the VPN network. The tap0 interface would 
not be added to batman-adv. Instead each VPN endpoint needs routing entries 
(over tap0) to the other clouds which you can propagate by pushing the routes 
from the openvpn server. Each cloud should have its own IP address space.

Regards,
Marek
