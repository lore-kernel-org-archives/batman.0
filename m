Message-ID: <468193BB.30202@dd19.de>
Date: Wed, 27 Jun 2007 00:31:23 +0200
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] securing batman gateway
References: <2bda28cd0706260823h3c1e4d78m27f8eb9809e655cd@mail.gmail.com>
In-Reply-To: <2bda28cd0706260823h3c1e4d78m27f8eb9809e655cd@mail.gmail.com>
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



Stefano Scipioni schrieb:
> I am working on a mesh cloud with wep encryption on wireless channel,
> olsr and openvpn to have a tunnel with gateway.
> 
> Batman has a tunnel with gateway but is it possible to secure it? In
> first step only clients with proper credentials can start tunnel and in
> second step tunnel is crypted.
> 

As the tunnel connects 2 nodes inside the mesh, ipsec transport (not
tunnel) could secure communication.
http://en.wikipedia.org/wiki/IPsec#Transport_mode

This would require less changes then implementing an additional tunnel
for encryption.

Gruss, Alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgZO7hx2RbV7T5aERAsZzAJoDkkmSR1XF+vsRg/I3gBxEo8gZ0ACgxYg+
RwdE5e4LXLJA0nTlpSHjq+w=
=N3aP
-----END PGP SIGNATURE-----
