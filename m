Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 09 Oct 2012 09:20:19 +0200
Message-ID: <2393209.YkZH7o6tCk@bentobox>
In-Reply-To: <CA+h5VgoTV5mj++Lk74eVnZWkpdne9zmZMYNUbV5YXy1r_fYAhQ@mail.gmail.com>
References: <CA+h5VgoTV5mj++Lk74eVnZWkpdne9zmZMYNUbV5YXy1r_fYAhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1410248.dMTnpEeBWg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] adding mac address field to orig_node struct
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Dominic Follett-Smith <dominicfollett@gmail.com>


--nextPart1410248.dMTnpEeBWg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 09 October 2012 00:10:56 Dominic Follett-Smith wrote:
> Hi
> 
> [1] I am using batmand, I have added the following field to the
> orig_node struct in batman.h:
> 
> char * mac_addr;

This doesn't makes sense when you allocate a static 30 byte array.

> [2] In get_orig_node() in originator.c:
> 
>         orig_node->mac_addr = (char *)malloc(30 * sizeof(char));
>         memset(orig_node->mac_addr, 0, 30);

This is horrible code.

> 
> [3] Problem: When I update this field in isbidirectional() in batman.c:

There is no such function.

> memcpy(orig_neigh_node->mac_addr, mac_addr_1, strlen(mac_addr_1));

This is even more horrible.

> it updates the field fine, but it does not persist, that is to say
> that after receiving another OGM from the same station,
> orig_neigh_node->mac_addr is empty. I dont understand why this should
> be happening.

May it be related with the memset in get_orig_node? It is hard to find 
problems in the code without seeing the code.

Please use "watch" in gdb to break whenever the field is written (and 
therefore reset to 0). And check that you really get the same originator when 
you search in the hash (and not that the item couldn't be found for some 
reasons in the hash and had to be reallocated).

Kind regards,
	Sven
--nextPart1410248.dMTnpEeBWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQc9AzAAoJEF2HCgfBJntGjOQP/1p6Qs0LHgt2flE43OVCsVtx
bGrwq2xMpJAudMw1Q43RvkVzSYWdI/xi2+SmlYc70775T3461BwEL6mks3iq8Ggg
ZUMv9tUED4PwcrfVCUP8bnqVvINdztJQhCcOty3JF2iAhJs+RzSxbTONwtn4gX50
suCH3NZtEmdSBvgpaGAM1NsYC80xoo6GTvalsSI2SBjaO9c7803foyjGGXCd5bZd
oJwxSYlrnq/29UQZx49FdARHzETNW4Qu7mrXngSU8R3XMdGJFU727R9l70gTZd/8
EaE7JVebPgOYo4xwDu7fD5qQg1a966v6Cc5hU3hNMedKnJHJUSn5JUUeDDnKr41v
smP4CCpejVf3JKJ8PiSJiBMZUDCxlPL2nmw94oZo2KbcastCVIlCpn0ccIMuVebv
NFAWsrgraZJ/nE9qKsQllJUB5QTZZ6xknVYEYc4sHl+jCXhHnvpgJzB0dpTltx32
lh02B1QopuBllA6m7dh3q/C/9yrNPF0wubpWekJljLpbwPRMe6h7SfVah6lxLulz
wqgya867UjJDQeW41lx1Jy6pUETaHr8En3goeCbAbXfTSiZb5TuRvIXbSMwrFPXK
66hyczHuUNyfIyFm/fG2nCc33q7PfC0xa9oG6Qh44mAnosAcdd6b6IR3PyL7u3DX
wss84OTiUMPCULz3Ixkh
=WOPC
-----END PGP SIGNATURE-----

--nextPart1410248.dMTnpEeBWg--

