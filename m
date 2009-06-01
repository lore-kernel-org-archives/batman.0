From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 1 Jun 2009 21:35:07 +0200
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200906011844.15664.sven.eckelmann@gmx.de>
	<4313f3060906011103q21b32600nf99f8607bd01045c@mail.gmail.com>
In-Reply-To: <4313f3060906011103q21b32600nf99f8607bd01045c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6319264.NkGH9GRySr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906012135.22488.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman] Add padding around allocation
	debugger structures
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Nathan Wharton <naw@greptar.com>
Cc: b.a.t.m.a.n@open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

--nextPart6319264.NkGH9GRySr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 01 June 2009 20:03:43 Nathan Wharton wrote:
> I had to copy the patches out of the e-mail.
>
> Here is the back trace:
> #0  list_add_tail (new=3D0x29bf0, head=3D0x298c9) at list-batman.c:68
> #1  0x0000ee7c in _hna_global_add (orig_node=3D0x29f80,
> hna_element=3D0x29ba8) at hna.c:371
> #2  0x0000f160 in hna_global_add (orig_node=3D0x29f80, new_hna=3D<value
> optimized out>, new_hna_len=3D<value optimized out>)
>     at hna.c:529
> #3  0x000099c8 in update_routes (orig_node=3D0x29f80,
> neigh_node=3D0x2a080, hna_recv_buff=3D0xbead1591 "\n\002\001",
>     hna_buff_len=3D10) at batman.c:377
> #4  0x0000c730 in update_orig (orig_node=3D0x29f80, in=3D0xbead157f,
> neigh=3D167772673, if_incoming=3D0x27678,
>     hna_recv_buff=3D0xbead1591 "\n\002\001", hna_buff_len=3D-16723,
> is_duplicate=3D0 '\0', curr_time=3D3199014207)
>     at originator.c:227
> #5  0x0000a7e0 in batman () at batman.c:956
> #6  0x000148d4 in main (argc=3D14, argv=3D0xbead1e14) at posix/posix.c:629
>
> Looks like debugMalloc didn't return an aligned value for head.  I'll
> step through that and see what I see.
Ok, I think I see the problem. The malloc returned a valid aligned adress.=
=20
list_add_tail will get a pointer to an element in hna_global_entry. This=20
structure is packed and all operations on it should be non-alignment safe. =
If=20
you look at it further you will notice that orig_list is at position 9=20
(assuming 4 bytes for a pointer) - which will not be aligned to 4 bytes of=
=20
course.....
And here comes the problem: the compiler will only do the safe operations o=
n=20
non-aligned data if it knows that it is not alignent. Since a cast is done =
by=20
calling list_add_tail it will not know that this parameter is not aligned a=
nd=20
the non-alignment bug will occur.

So my question to marek: Is it really needed to have "struct hna_global_ent=
ry"=20
packed in hna.h:57? If not then we should remove it and this problem should=
 be=20
gone. And what is with "struct hna_element".

Thank you for your work, Nathan :)

Regards,
	Sven

--nextPart6319264.NkGH9GRySr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKJC1wAAoJEF2HCgfBJntG38IQANZgbquZFyFZoKvTCqLOHmVa
rxDLkeC/ceZSiRHJEc5pxFTgkxHKoamzk/3w4FauL/0iTaFkSm3GnU4ks3/cuH4K
KrXYqo4UNe39HPkUyfo+/jAbcf8gNt6a+1ouPYBU7zYjh8ztcJgR5A9nXlbFFHm5
yyjC9UsRunZV2I9NyRAUBmfiXMleVS+buznx46GohchQg5xx3EmosztySqx+Eu5c
Lf5fS1FPZhnNbDe6IxHorGA10E2wGmCQNMtybUa7atF/iBOGiU0zynULMFtsqyBq
ULQKNdQ2YbC0LLhr0zMKpduDIUj7CMd2Ec0Jqp5ZT1ngz3Bo0ZksMfFE3R1mKiZn
xQmcN9kg5ZlJvxOXd8V+SKGDiVX4CuDi/u3MKa3styfvvb/7JHs1vaO0em8FWCu6
nSFmKZntVWireFOW1gmh5pnj/FkZP36ciWZnJaQXidjtxZZycjl4SB2+hp2yUgUv
Dlc0rTPaHY3bLm6S0EiNP+LzuKcjwc1nCoy8shStaVidu+tmaEDqoX9GpKOFP1AX
0bbglKcIZ26/V7zdvsjmIWoaTdHJtsSGGhCVr4KoQiQm+ChrBxOlrd9S6prTcx+D
TqvsOqiIHMr+WHoWcpxs0lJ2tqbQcXrQfXkjiij5aGM+dXyBgCVujaNOUXoKpERB
rd92XgEhwXkTLc4motIs
=n4zw
-----END PGP SIGNATURE-----

--nextPart6319264.NkGH9GRySr--
