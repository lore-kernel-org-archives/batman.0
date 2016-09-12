Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 12 Sep 2016 17:21:59 +0200
Message-ID: <1707606.1cADVqls3C@bentobox>
In-Reply-To: <20160912145209.GA6452@kroah.com>
References: <20160906072529.5587-1-sw@simonwunderlich.de>
 <20160906072529.5587-3-sw@simonwunderlich.de>
 <20160912145209.GA6452@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2033795.zU5HUu0SDG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4.7] batman-adv: Fix pagefault during
	neigh_node free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, stable@vger.kernel.org

--nextPart2033795.zU5HUu0SDG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 12. September 2016 16:52:09 CEST Greg KH wrote:
> On Tue, Sep 06, 2016 at 09:25:29AM +0200, Simon Wunderlich wrote:
> > From: Marek Lindner <mareklindner@neomailbox.ch>
> > 
> > commit d9f179877e50ae2681fe7b0b83e0d9f63b6165ad upstream.
> 
> That is not the commit id of this patch :(
> 
> What is the real one?
> 
> Please be more careful...

Just checked it and it looks like the patch already mentioned in the
"commit xxxxx upstream" line:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d9f179877e50ae2681fe7b0b83e0d9f63b6165ad

I've only rephrased the commit message (see above my signed-off-by line) to
explain why it is a user reported [1] problem. The initial patch didn't
explain this at all and made it look like a simple cleanup change. We
only became aware of the importance of this change after the original
"cleanup" version was accepted by Linus (part of 4.8-rc1 when I remember
correctly).

Kind regards,
	Sven

[1] https://www.open-mesh.org/issues/292
--nextPart2033795.zU5HUu0SDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX1sgXAAoJEF2HCgfBJntGaXIP/2KlCYNqdoiTdzNoMOCGxrb8
9V7K1uzc5PFkVyZ/EdNPdi7A6FBZHwOV3pwhun+E00qgs67u/Qepmtlbn/iZb9XC
gZyBFJLrAkIZiIaL8INp1jzN/kWJpStn72qouD+s9hn2SWFeL9FtjMu4NVNCMJey
5ImIoKkI4hC/la9ND5n7wqoviTwsoQEMq233Gsz/UMU9/EByCXISCh29/ifzowtf
34JFkT1d//7E6jGgL+9m4159FSJimFvbDOywcOuHkDYF9HPI0aYbl3qDgnjmFxkS
BSUmg0tIl5Eue82Y0GI0nl1QXtMZztXnH4IzYU3ONTS6UaS0qt2RvRd7cauPkiDZ
Ji0OfMuHzSCOJ2n8CluWfuNPLHAawCXxVXykqQC/FmraU2PGY8sVcTnfP6fiOn4l
GwSwMVaSf8ED+NmzjiFuZ6V555Qn+piXTnpNQOV0F5cCDDxnuo/pF40IoxKKfB2w
mG/aJBveOdp51RmxdL5OQYBFRbD0WdziJxqj1qjr0yIFQ37+UYduoM7c8KO+uKHE
45MmptpzR2GCH90TdJCnP4MZcYa3jIh33rP7igzuECDIGIMJe05zW35PU6cY2S6b
IbU5KEEaePB4tRHi7ivIj7ypWVxbRWfUSh9r3WoU0pIu+lEKc+SO2KRj3/ElIFIb
GLQPF3EApoADjcX6KLPn
=Xq03
-----END PGP SIGNATURE-----

--nextPart2033795.zU5HUu0SDG--

