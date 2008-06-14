From: Damian Ivereigh <damo@launtel.net.au>
Content-Type: text/plain
Date: Sun, 15 Jun 2008 09:45:32 +1000
Message-Id: <1213487132.5782.14.camel@damian-x31.damian.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Securing batman networks
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

Does anyone have any experience with securing batman networks (or more
to the point the adhoc networks it is based on)? My setup will be a
relatively planned infrastructure with all units controlled by myself,
so embedding keys etc won't really be an issue.

Can you use WPA2 with adhoc networks? How does this work with
wpa_supplicant & hostapd (which are obviously designed for use with
access point infrastructure).

When I use the term "security" I am looking at it at several levels:-

1) Stopping rogue units joining the network.
2) Encrypting the traffic to stop eavesdropping.
3) Stopping others from hijacking the connections (either between nodes
or via the gateways). 

I realise this is a different style from the community mesh network,
open to everyone, that Batman appears to have been part of up to now. In
Australia bandwidth is so limited (and expensive) that people here are
generally not willing to share it, so there is almost no chance of a
community arising of its own accord.

Damian

-- 
Launtel - Plugging Tassie into the world
Tel: 1800LAUNTEL (1800528683)
Mob: 0418217582
Fax: 1300784109
http://www.launtel.net.au

