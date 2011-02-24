Return-Path: <vinay@orxrail.com>
Message-ID: <4D668F3F.4080700@orxrail.com>
Date: Thu, 24 Feb 2011 12:02:55 -0500
From: Vinay Tharigopula <vinay@orxrail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batman-adv mesh slows down wired clients
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello..

I succesfully configured a batman-adv mesh to add access points to our 
existing wired lan.  I am using Openwrt 10.04 and batman-adv 2010.1.0. 
DHCP and everything works as expected. Any wired or wireless client 
connecting to the network gets an IP from a DHCP server hooked into the 
switch etc etc.

Our Network configuration:

8 batman-adv routers with a wireless mesh  with two or more of the 
routers having a wired connection directly to the switch. In this case, 
the 8 routers decide to pick one of the "plugged in" routers as a 
gateway to avoid bridge loops. This is fine.

I have been running into issues with wired clients however.

When a wired client plugged into the switch tries to contact a wired 
client plugged into the same switch, the packets manage to get lost. I 
believe they are are going through the wireless routers plugged into the 
same switch.

Instead of going like this..

PC 1 ----> switch1 ---> PC 2

they seem to be going like this... (my guess).

PC 1 ---> switch1 ---> wireless router 1 ----(wireless mesh link)----> 
wireless router 2 ----> switch1 --->  PC 2.

I think this is because the translation tables on the bat node are 
announcing that even the wired clients are connected to them.

This is causing extreme delays even in wired clients. Any help will be 
appreciated. Should I enable STP in on the switch ports ?

- Vinay
