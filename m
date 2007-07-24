Message-ID: <46A64669.5050604@poelzi.org>
Date: Tue, 24 Jul 2007 20:35:21 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
In-Reply-To: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Freifunk Dresden wrote:

> I'm currently checking how the HNA is working, but until now I can not
> see any HNA on a second node. Firewall is enabled completely for both
> nodes and each node sees the other nodes. I call batmand as follow:
> Node1: batmand -t 63 -a 141.56.0.0/16 wlan0 bbs /t 2 bbc /t 2
> Node2: batmand -t 63 eth1 bbs /t 2 bbc /t 2

> 
> But batmand -c -d 4 does not show any HNA messages and no HNA entry is
> stored in   routing table.

mmhh, the hna announcments are written into another routing table, have
you checked that ?

> If a node offers a ftp server (portforwarding) I like to offer this
> "service" via batmand like olsrd.
> A generic solution would be good to just allow to send user text
> messages with the OGM.

This is a bad idea in my opinion. A routing protocol has one purpose
which is routing, not flooding 99% useless information just because it
COULD.

i think the right approch for service discovery is using something like
dns for example. dns is very small overheaded, allows great redundancy,
works on demand...

using TXT and SRV records, a good dns infrastructure and user frontend,
it should be easy to publish services.

here in leipzig we already layed the ground stones for a widespanning,
redundant dns network using anycast ips for redundancy.

http://wiki.freifunk.net/FF-Zone

kindly regards
 Daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGpkZpy/mkIQp7AD0RAhrlAKCVDRFsf+6+909tsAxtCFM3oZSxugCfdKsT
sGLdwUFF9ckhxfLHikdfwP8=
=DW4D
-----END PGP SIGNATURE-----
