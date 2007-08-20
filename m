Message-ID: <46C992A9.9050209@dd19.de>
Date: Mon, 20 Aug 2007 15:10:01 +0200
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
References: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
	<200708041143.37165.axel@open-mesh.net>
In-Reply-To: <200708041143.37165.axel@open-mesh.net>
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



Axel Neumann schrieb:
> Hello!
> 
> On Freitag 03 August 2007, Freifunk Dresden wrote:

<removed>

> Do you really think of a human-readable ascii string that you want to flood 
> with an arbitrary length over the mesh with content like: "Hello take a cool 
> beer and see my fancy cool movie torrent-server at 105.10.bla.bub". Iam not 
> against such communication but...
> 
> default OGM size: 10 bytes
> OGM + HNA size: 15 bytes
> OGM + example-TLV-ascii message: 95 bytes
> 
> ... I am a bit scared about the amount of data which would be flooded over the 
> mesh (at every originator interval) with no means for stopping the sources.

maybe a additional byte is enough to tell, that other nodes can query
service information. this would result in less overhead than announcing
services in OGM and is also less overhead than polling all nodes for
services.

It would also leave enough room for announcing different service
advertisement systems in this byte.

> 
> Therefore i asked if anybody knows a decent forman for describing such 
> services (preferably in a short and machine readable notation). 
> Perhaps another approach is to just have a kind of key-to-service list 
> (similar to /etc/services with a 16bit key) just roughly indicating the type 
> of offered service together with another port/ip  where further information 
> (of arbitrary length) about the indicated service can be retrieved.
> This would also allow to outsource part of the service-discovery to another 
> daemon.
> 
> 
> greetings,
> axel
>

Greets, alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGyZKohx2RbV7T5aERAn4DAJ41fmMlKiOHhjuFvmHZPJefa2C7uACdEdx2
yfPQKQt3ICcJZh8BDGGoPzc=
=zOak
-----END PGP SIGNATURE-----
