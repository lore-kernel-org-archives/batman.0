Message-ID: <46A774DA.4070702@dd19.de>
Date: Wed, 25 Jul 2007 18:05:46 +0200
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>	<46A64669.5050604@poelzi.org>	<46A738FC.9060007@dd19.de>	<46A7478B.8080007@leipzig.freifunk.net>	<46A766DC.5030509@dd19.de>
	<46A76A02.7040600@poelzi.org>
In-Reply-To: <46A76A02.7040600@poelzi.org>
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



Daniel Poelzleithner schrieb:
> Alexander Morlang wrote:
> 
>> Sorry, but this does not look like a decentral "all are equal" solution,
>> more like a centralized service.
> 
> yes, some sort of. there is a master dns server that ensures uniquiness
> of domains and at least knows how is responsible for the zones. nothing
> forbids you to mirror the zones on all nodes, i just don't see any sense
> in it. 4-5 slave servers should be enough even for a large city. every
> zone admin can run his own masters if he wish to.
> responses will be fast and redundant even if some of them die. and you
> can use real dns software and can run really large zones with large
> entries without wasting pressures router ram. reverse dns, dyndns, like
> my notebooks is always aestas.poelzi.ff if its somewhere in freifunk...
> very cool stuff. dns loc records, very nice. combined with reverse dns
> allows very rfc conform routings visualisations... even can show nodes
> that are offline....

with the small sideeffect of a small group controlling the a-server.

> 
>> i think, something like the olsr-bmf would be more interesting, it gets
>> metrics from the underlying meshrouting protocol but does its own
>> message forwarding.
> 
> what does bmf have to do with dns. if you think about forwarding name
> entries as broadcasts: this is just a wast of bandwidth. i don't even
> start to think about renaming my node to www.google.de and see what
> happens ;)

in opposite of the name plugin wich uses olsr for flooding informations,
bmf does its own flooding. as batman does not support flooding custom
payload, this would be the only way of distributing information
efficient and decentral as long there is a way to get the metrics from
the routing protocol.

And, of course, who are you, desciding for me what a waste of bandwith
in my case ist? ;-)


> 
> kindly regards
>  daniel

cu in finowfurt, alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGp3TZhx2RbV7T5aERAsshAJ0XUiQxil/EnLspvS488WSCxFSJjwCfYmuh
Rip12GW8r2ayJa97EsngHxQ=
=17xF
-----END PGP SIGNATURE-----
