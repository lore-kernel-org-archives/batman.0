Return-Path: <drwho@virtadpt.net>
Message-ID: <4E42B411.9050601@virtadpt.net>
Date: Wed, 10 Aug 2011 12:38:41 -0400
From: The Doctor <drwho@virtadpt.net>
MIME-Version: 1.0
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>	<4E270F72.10900@virtadpt.net>	<7izkk8zsr4.fsf@lanthane.pps.jussieu.fr>	<4E28392B.9020209@virtadpt.net>	<7ibown8v2j.fsf@lanthane.pps.jussieu.fr>
	<4E403367.4060701@virtadpt.net> <4E411B95.4030203@tnode.com>
	<4E416584.2020701@virtadpt.net> <4E41A0C6.1010209@tnode.com>
In-Reply-To: <4E41A0C6.1010209@tnode.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh-like experiment in
	Washington, DC
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
To: Mitar <mitar@tnode.com>
Cc: Juliusz Chroboczek <jch@pps.jussieu.fr>, b.a.t.m.a.n@open-mesh.net, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>, babel-users@lists.alioth.debian.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/09/2011 05:04 PM, Mitar wrote:

> What exactly is this control panel? What do you understand under this
> term? It is something running on the node? Or on the server?

The Byzantium control panel is an application which allows the user to
(de)configure network interfaces, add or remove them from a mesh, and
enable or disable services and web applications running on a node.  It
runs on a node (listening only on the loopback interface) and is
accessed with any web browser.  Technically, it is a web application,
but seeing as how Byzantium will package a couple of web applications
for public use on a mesh anyway (Etherpad-lite, crypto.cat, status.net,
and a few others) it made more sense to call it a control panel.

> Is there some webpage with more about that?

http://wiki.hacdc.org/index.php/Byzantium
http://wiki.hacdc.org/index.php/Byzantium_Live_Distro (developer info)

> You are talking about IPv6 or IPv4 here?In IPv4 some MAC address + IPv6
> prefix could be enough.

IPv4.  We considered IPv6, and in fact we get it for free with the Linux
kernel, but not all applications are aware of or play nicely with it.

> In IPv4 is problem, that if you will take big address space you will
> have problems peering with other mesh networks. If this will be one day
> interesting to you. (At least in Europe we are slowly trying to connect
> all networks together.)

This is an interesting problem to us, and one of the things we have in
mind once Byzantium is stable is correcting problems with
interoperability.  In the States right now, mesh networking is not
really a popular technology; hopefully Byzantium will drum up more
interest over here (and open a meaningful dialogue with the "Mesh
networking sucks, why don't you just give up?" critics).

- -- 

The Doctor [412/724/301/703]

PGP: 0x807B17C1 / 7960 1CDC 85C9 0B63 8D9F  DD89 3BD8 FF2B 807B 17C1
WWW: http://drwho.virtadpt.net/

"And the flowers are still standing!" --Peter Venkman, _Ghostbusters_

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5CtBEACgkQO9j/K4B7F8FmpgCfdZZDeTtPuSxFgIgNYJuDwNZS
/2cAoOH7dDvsRrscwiuGvL+FTZ2C7ius
=pE6H
-----END PGP SIGNATURE-----
