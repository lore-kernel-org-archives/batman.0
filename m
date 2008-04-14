MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Message-id: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
From: Philippe April <isf_lists@philippeapril.com>
Date: Mon, 14 Apr 2008 11:12:20 -0400
Subject: [B.A.T.M.A.N.] Node keeps switching back and forth
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi!

I setup 3 nodes on OpenWRT Kamikaze and B.A.T.M.A.N 0.3, using atheros  
chipset.

My gateway is started this way: batmand -g 5Mbit/1Mbit -a  
some_subnet... ath0
My nodes: batmand -r 2 -a other_subnets... ath0

Let's call them "gateway", "node1", "node2".

"gateway" is in my basement.

"node1" is upstairs.

"node2" is in the shed.

node1's connection to gateway is strong.
node2's connection to gateway is very weak, about 50% packet loss.
node2's connection to node1 is strong.

Knowing this: does anybody have a clue to why my node2 keeps switching  
from node1 to gateway? I connect to node2 and ping on the internet  
constantly, I see the node switching back and forth from node1 to  
gateway, sending some of my packets to one, or the other... basically  
the user experience is horrible.

I was missing FW masquerading rules until yesterday, things were not  
working at all when I was not going through the gateway directly, but  
that "seems" to be resolved, now packets go by "sometimes". If node2  
could stick to using node1, it would be easier to troubleshoot.

I'm trying to move my nodes as far as I can so it can't connect to the  
gateway directly at all from node2 but the shed does not seem to be  
far enough :)

Thanks for any enlightenment...

Philippe April
