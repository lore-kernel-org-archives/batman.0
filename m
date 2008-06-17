From: Damian Ivereigh <damo@launtel.net.au>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 18:01:56 +1000
Message-Id: <1213689716.19413.28.camel@damian-x31.damian.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Problems Multi radios
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

I am duplicating Shane Chao's setup with three nodes - the central one
having two radios on different channels - each one on the same channel
as one of the other two nodes.

node 1             node 2           node 3
10.232.0.1         10.232.0.3       10.232.0.2
------             ------           ------
 wlan0 <--ch 50--> wlan0
                   wlan1 <--ch 58-> wlan1


When they are all on the same channel (and the central node is just
using one radio), batman works fine - node 2 relays between the two
(node 1 and node3 can't hear each other due to an obstruction).

However when I get batman to run on both interfaces, I can no longer
talk between node 1 and node 2 at all. In fact even if node 3 is turned
off, just running batmand on both interfaces of node 2 stops it working.

What is wierd is that node 1 can't seem to get its routes organised so
that when it tries to send packets back to node 2, its gets (-d4 log):-

Error - can't send requested ip to client (10.232.0.3): Network is
unreachable

It can hear packets coming from node 2 just fine. More log:-

Received BATMAN packet via NB: 10.232.0.3, IF: wlan1 10.232.0.1 (from
OG: 10.231.0.3, via old OG: 10.231.0.3, seqno 5126, tq 255, TTL 50, V 5,
IDF 0) 
[   5187150] HNA information received (1 HNA network): 
[   5187150] hna: 10.232.0.3/32
[   5187150] Creating new originator: 10.231.0.3 
[   5187150] updating last_seqno: old 0, new 5126 
[   5187150] Drop packet: OGM via unkown neighbor! 

I am not so much looking for someone to help me to debug this, just a
confirmation that multiple interfaces does work OK.

Damian


-- 
Launtel - Plugging Tassie into the world
Tel: 1800LAUNTEL (1800528683)
Mob: 0418217582
Fax: 1300784109
http://www.launtel.net.au

