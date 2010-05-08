Return-Path: <ordex@ritirata.org>
Date: Sat, 8 May 2010 19:07:55 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100508170755.GA27599@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Blocking OGMs from a node for testing purpose
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

Hi all,
	I'm tring to make some tests on batman-adv with some stations,
but I'm in trouble since I'm not able to "hide" a node to another. In
other words I would like to create some personalized topologies to
to test batman against them.

To do this, first of all, I should block OGMs from a particular station.
I tried with ebtables in order to block all the packets with source MACa
(where MACa is the MAC address of the station I would prevent to
communicate with me), but I failed.

Does anyone know a working way to do what I described before?

Thank you so much!

Regards


-- 
Antonio Quartulli

Ognuno di noi, da solo, non vale nulla 
Ernesto "Che" Guevara
