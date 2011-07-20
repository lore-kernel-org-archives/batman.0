Return-Path: <drwho@virtadpt.net>
Message-ID: <4E270F72.10900@virtadpt.net>
Date: Wed, 20 Jul 2011 13:25:06 -0400
From: The Doctor <drwho@virtadpt.net>
MIME-Version: 1.0
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>
In-Reply-To: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Battlemesh-like experiment in Washington, DC
Reply-To: drwho@virtadpt.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
Cc: b.a.t.m.a.n@open-mesh.net, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>, babel-users@lists.alioth.debian.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/16/2011 09:42 AM, Juliusz Chroboczek wrote:

> They've got a few minor misunderstandings (for example, they're trying
> to get ordinary DHCP to work over a mesh), but they've managed to get
> both Babel and BATMAN-Adv to work with no help from us -- well done.

We actually did get DHCP working over our meshes as a proof of concept -
it works pretty well.  We're probably going to use DHCP to configure
clients that first associate with each mesh node (we can't install AHCP
clients on every wireless devices that happens by; besides, they support
DHCP by default).  Byzantium nodes themselves give their wireless
interfaces pseudo-randomly chosen RFC-1918 IP addresses when they're
brought online.

- -- 

The Doctor [412/724/301/703]

PGP: 0x807B17C1 / 7960 1CDC 85C9 0B63 8D9F  DD89 3BD8 FF2B 807B 17C1
WWW: http://drwho.virtadpt.net/

"Here sharky!  Here!  Here, boy!"  --Anthony Bourdain

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4nD3IACgkQO9j/K4B7F8GTNACbBzdExuJhnYOemgWMmlVAmirG
qgMAoJocq+kdlaYH4+fGRj9rzxROT99O
=pbuK
-----END PGP SIGNATURE-----
