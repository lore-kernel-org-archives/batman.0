Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Sep 2010 00:35:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201009170035.05463.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] LAN loop avoidance
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


Hi folks,

recently, I came across a nasty issue which hasn't been solved yet. The 
problem begins to show up when you try to connect multiple batman-adv mesh 
node to the same LAN network. If batman-adv is bridged into the LAN and the 
nodes have a decent connection to each other you are about to create an 
ethernet loop which will take out your entire network. 
A simple visualization of the loop:

node1  <-- LAN  -->  node2
   |                              |
  wifi    <-- mesh -->  wifi

Let's assume a packet from the LAN arrives at node1 which then floods the mesh 
with that new packet. Node2 receives the packet via the mesh and forwards it 
to the LAN where node1 receives it ...

If there wasn't the LAN connection this would not happen because batman-adv 
provides a flood/loop protection inside the batman header but as soon as the 
packet gets bridged this information is stripped from the packet. Every batman 
node connected to the LAN will think: Hey, it is a new packet!

A common solution to avoid bridge loops is to deploy protocols like STP or one 
of its derivates. STP would detect the loop and close ports to avoid it. 
Running STP over the mesh is not really what we want as STP has no clue about 
the link qualities and who wants to run a spanning tree over lossy links ?

So, batman-adv needs it own mechanism to detect other batman nodes connected 
to the same LAN and then close the appropriate ports. As a followup to this 
mail I propose a patch which does exactly that. It will detect OGMs that come 
in via the batX interface and interprets them as "port announcements". 
Internally, it keeps a list of all LAN neighbors and selects the one with the 
smallest mac address as gateway to the LAN. All traffic that should go to the 
LAN is forwarded to this node. Traffic from the LAN is simply dropped - only the 
smallest mac node will forward it to the mesh.

Simple steps to see it in action:
* add your wifi interface 
-> batctl if add wlan0
* create a bridge for bat0 and your lan
-> brctl addbr br-lan
-> brctl addif br-lan eth0
-> brctl addif br-lan bat0
* activate batman on the lan
-> batctl if add br-lan

The patch can also deal with vlans on top of batX and offers a list of LAN 
neighbors via debugfs (batctl support is yet to come).

Feedback is welcome!  :-)

Regards,
Marek

