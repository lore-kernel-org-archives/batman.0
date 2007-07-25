Message-ID: <46A76A02.7040600@poelzi.org>
Date: Wed, 25 Jul 2007 17:19:30 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>	<46A64669.5050604@poelzi.org>	<46A738FC.9060007@dd19.de>	<46A7478B.8080007@leipzig.freifunk.net>
	<46A766DC.5030509@dd19.de>
In-Reply-To: <46A766DC.5030509@dd19.de>
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

Alexander Morlang wrote:

> Sorry, but this does not look like a decentral "all are equal" solution,
> more like a centralized service.

yes, some sort of. there is a master dns server that ensures uniquiness
of domains and at least knows how is responsible for the zones. nothing
forbids you to mirror the zones on all nodes, i just don't see any sense
in it. 4-5 slave servers should be enough even for a large city. every
zone admin can run his own masters if he wish to.
responses will be fast and redundant even if some of them die. and you
can use real dns software and can run really large zones with large
entries without wasting pressures router ram. reverse dns, dyndns, like
my notebooks is always aestas.poelzi.ff if its somewhere in freifunk...
very cool stuff. dns loc records, very nice. combined with reverse dns
allows very rfc conform routings visualisations... even can show nodes
that are offline....

> i think, something like the olsr-bmf would be more interesting, it gets
> metrics from the underlying meshrouting protocol but does its own
> message forwarding.

what does bmf have to do with dns. if you think about forwarding name
entries as broadcasts: this is just a wast of bandwidth. i don't even
start to think about renaming my node to www.google.de and see what
happens ;)

kindly regards
 daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGp2oCy/mkIQp7AD0RAstwAJ4rptMfmyEGLpFbQRVKPcLB4yIafACg3hPi
GJ7T8PzUGVpO8Cfh9A/mj9A=
=Zv8z
-----END PGP SIGNATURE-----
