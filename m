Message-ID: <4672C430.1020208@poelzi.org>
Date: Fri, 15 Jun 2007 18:54:08 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] dynamic network annoucments
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

another feature i forgot in the last mail :)

It would be great if batman allows to dynamic add and remove announced
networks via the unix socket interface.

for example
# adds new announced network
batmand -c -a someip/mask
# removes some announced network
batmand -c -A someip/mask

why ?
we are working on the posibility to give a computer in the mesh a unique
ip, besides the network the node is serving. if you assign a unique ip
to a computer, and get a dhcp lease of another node, the node would then
add your ip as a hostroute announcement to batman, which would overwrite
the default place: your home network. this would mean real mobile ip
without the overhead of sending the traffic to your home router and then
forward to your actual position.

besides this, it would allow better integration into bgp by simply
spawning a script to add/remove routes via zebra.

kindly regards
  daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGcsQwy/mkIQp7AD0RAkG5AKC1UkQHec8jfbGmsMD9d1turzdWjACdFLMh
W8ciliTQtKs4NTNfEt8Zc4U=
=XzcN
-----END PGP SIGNATURE-----
