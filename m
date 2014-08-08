Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 8 Aug 2014 14:20:28 +0200
References: <53E32F6D.3010207@aliyun.com>
 <201408071032.05730.sw@simonwunderlich.de> <53E4B02F.2040506@aliyun.com>
In-Reply-To: <53E4B02F.2040506@aliyun.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201408081420.28413.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] how to make IP layer handle the change of
	network topology
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
To: liu <liudows@aliyun.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Liu,

> Thanks for reply. I have tried to fix this problem followed by Simon's
> guide.  Unfortunately It stil doesn't work.I draw a pciture named
> 'topo.jpg' in the  attachment to describe my situation.
> 
> Gateway B and C are wired to router 192.168.1.1 through their 'WAN'
> interface. They are in the same LAN. 'bat0' and 'eth0' are bridged by
> 'br-lan' interface, and are assigned a mesh subnet IP address '10.130.1.x'.
> 
> Client A connected to B and C by mesh network. 'bat0' and 'wan' is
> bridged by 'br-wan' in Client A. 'br-wan' is assigned a subnet IP
> address by DHCP server in B or C, for example '10.130.1.138'.

You are still doing routing in that scenario. Instead, you should bridge all 
nodes in the same network, and they should be in the same IP subnet. If you 
configure another WAN, you are back to routing, which will not work for that 
scenario.

Please configure eth0, wan and bat0 in the same bridge (e.g. br-lan) on all 
devices. Don't configure other bridges. Then, your devices and your client 
should get an IP address from the 192.168.1.x subnet, and should be able to 
ping 192.168.1.1, even if node A fails.

Cheers,
     Simon
