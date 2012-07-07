Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sat, 7 Jul 2012 00:37:24 -0300
Message-ID: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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

Hello again nice folks,
I updated today another segment of the network with just 4 nodes, to
batman-adv 2012.2 (the one i compiled yesterday with simon patches for
blaII, marek stability fixes, and debug log enabled , yikes!)
and i couldn't get batman to work over wired ethernet?? (?)

P -(50mts wlan)- D -----(ubnt transparent bridge) 2km -- C
 \----eth-------------------/

Node P and D connected by ethernet on eth0 but close enough that could
also see each other through adhoc wlan, with bla enabled, correctly
preferred ethernet connection to communicate between them (iperf
yielded 92mbps), so far so good.
now, node D and C, too far away from each other to communicate over
wlan, but connected by a "loooong eth cable" (mediated by a wds
transparent bridge) wouldn't find each other batman originator.
C originator table was empty, and D only showed P.
I thought the transparent bridge was misbehaving, so I tried in a
simpler setup using P and D, with the wifi off:
but after disabling wlan0 (batctl if del wlan0-2) and adding eth0
(batctl if add eth0) on both nodes, batman could not see each other
anymore :(
i thought i was doing something wrong, so i tried in different ways,
but could not get it to work.
batctl td eth0 shows both outgoing OGMs from local , and incoming OGMs
from remote,
but batctl l only reported outgoing OGMs.

http://pastebin.com/7DDUaXu1

diego is local node ("D"), palmeras is on the other side of the
ethernet cable ("P") (and jure is further away, connected to palmeras
by adhoc wlan, not illustrated in the previous ascii art)

i hope i'm overlooking something really obvious?

Have a nice weekend!

Gui
