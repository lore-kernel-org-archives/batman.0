Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4AA34865.9000203@rsm-freilassing.de>
Date: Sun, 06 Sep 2009 07:28:05 +0200
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
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
To: b.a.t.m.a.n@lists.open-mesh.net

Dear B.A.T.M.A.N List,

i've installed BATMAN v0.3.2 in a ethernet network to dynamicly route my 
network-informations. Before switching to BATMAN, i've used OLSR.

With OLSR all things went fine. But since my network grows faster as 
intended, i like to switch to BATMAN.

NOW TO MY PROBLEM:

I like to announce a gateway that is behind an VPN-Tunnel. The 
VPN-Tunnel is established, before BATMAN is running.

When i try to start BATMAN on the Gateway with this options:
   batmand -g 30mbit/2mbit

the clients will create a gate0 interface. I do not need this gate0 
interface. All routers have static public ip-addresses assigned. The 
once that i need is, that BATMAN inserts a DEFAULT-ROUTE to the next 
neighbour hop thats reach the gateway.

NETWORK-Setup:

   1. i386 Router located on ISP runs batman as gateway-provider
      xxx.205.12.0/32 brd 255.255.255.255

       <--- VPN-Tunnel over ISP-Network --->

      xxx.205.12.4/32 brd 255.255.255.255
   2. i386 Router located at home #1
      xxx.205.12.17/30 brd xxx.205.12.19

       <--- Wireless Bridge-Connection --->

      xxx.205.12.18/30 brd xxx.205.12.19
   3. i386 Router located at home #2
      xxx.205.12.21/30 brd xxx.205.12.23

       <--- Wireless Bridge-Connection --->

      xxx.205.12.22/30 brd xxx.205.12.23
   4. i386 Router located at home #3

How can i tell BATMAN (gateway) to announce 0.0.0.0/0 as HNA?

# batmand -c -a 0.0.0.0/0
Invalid announced network (netmask is invalid): 0.0.0.0/0

I dont like to setup a second VPN / P2P Tunnel, because thats not needed.

Thanks in advance,
Michael
