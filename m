Message-ID: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
Date: Mon, 24 Sep 2007 20:00:36 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] a strange case
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
To: b.a.t.m.a.n@open-mesh.net

Hi all

I'm experiencing a strange situation

[AP_n]--wifi--[client]--mesh--[gateway]--wifi--[AP_g]
                                |
                             [xDSL]---[world]

The two nodes (client and gateway) are running batman 0.3 (experimental
rv636) in the right way with option --bmx-defaults.

A wifi laptop associated with AP_g (gateway' AP) can browse internet
pretty well while associated with AP_n (client' AP) it can't!
Please note that client itself can browse internet! (I tryed ssh into node
and then wget something).
I verified no nameserver problem neither firewall blocking rules (gateway
and node are flashed and run the same firmware)

But what is puzzling me is that running batman 0.2 on nodes... laptop
associated with AP_n (client' AP) can browse!
(I've only changed the daemon, no others change into environment -
procedures dinamically change batmand command string)
.
I noticed the parameter "--no-unreachable-rule" then tryed adding this
parameter at the batman 0.3 command string but unfortunately with no
results!

Maybe I'm boring you... bat have any ideas about?

--
Antonio


