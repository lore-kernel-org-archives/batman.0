Message-ID: <46A89495.8020000@dd19.de>
Date: Thu, 26 Jul 2007 14:33:25 +0200
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>	<46A64669.5050604@poelzi.org>	<46A738FC.9060007@dd19.de>	<46A7478B.8080007@leipzig.freifunk.net>	<46A766DC.5030509@dd19.de>	<46A76A02.7040600@poelzi.org>	<46A774DA.4070702@dd19.de>
	<46A78785.9040501@poelzi.org>
In-Reply-To: <46A78785.9040501@poelzi.org>
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
> 
>> with the small sideeffect of a small group controlling the a-server.
> 
> yes. i prefer a group of people i can trust controlling the a-server
> then trusting every packet someone, somewhere in the network is sending.
> hello, i'm www.google.de, how are you :)
> by the way, ok, with hna annoucements faking some site is still easy,
> but just because one instance of the network has problems, there is no
> need to repeat ourself. i.e. dnssec for example.

i distrust central structures, doing it decentral is one of the main
things in meshnetworking. It sounds, you want to establish centralized
structures of power for security reasons and telling about the nice
advantage of reliability.

sounds familiar, i think we both are fighting against this things in
realworld, so i do not want to introduce it in the freifunk world.

> 
> 
>> in opposite of the name plugin wich uses olsr for flooding informations,
>> bmf does its own flooding. as batman does not support flooding custom
>> payload, this would be the only way of distributing information
>> efficient and decentral as long there is a way to get the metrics from
>> the routing protocol.
> 
> by the way, is see it comming. packetstorms through circular broadcast
> packets. i have SEEN links that have 1.5 seconds delay, god knows why.
> two of those and you crack the duplicate lookup buffer...

Thats a specific problem of implementation wich could be solved.

> 
> i'm not against broadcast in general. but everything i get which i'm
> actually not interested in, or is duplicated information (something i
> already know), is simply a wast of bandwidth. It's easy to say, ohh,
> some bytes here, some bytes there. if you look at a real mesh, you
> simply see to much useless traffic. there are nodes in freifunk leipzig,
> that have 80kb/s olsr traffic. 80kb/s, some people would dream about
> this speed, but just wasted away....

sure, imagine a bunch of 20 nodes periodically polling all nodes for
decentral information, because they do not trust the central instance,
how much traffic would that be? and, you cannot do anything against it,
except censorship on ip-level.

> 
> kindly regards
>  daniel
> 
cu, alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGqJSVhx2RbV7T5aERAvTKAKC8pkBRiIcEvPhox05FR5icei0HHACffqMz
UQpa9DBvzKrQzlhL/sckelw=
=4+zs
-----END PGP SIGNATURE-----
