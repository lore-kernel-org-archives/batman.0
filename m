From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Date: Mon, 8 Sep 2008 23:18:42 +0200
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
In-Reply-To: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1367866.Rftx9O3oWk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809082318.54082.sven.eckelmann@gmx.de>
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

--nextPart1367866.Rftx9O3oWk
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok, I got the /proc/modules file now. Current situation is following: it=20
crashes inside the the batman module add position 0x00000aa4

    a60:	3c020000 	lui	v0,0x0
     a64:	8c500024 	lw	s0,36(v0)
     a68:	24420024 	addiu	v0,v0,36
     a6c:	12020014 	beq	s0,v0,ac0 <cleanup_module+0x610>
     a70:	3c040000 	lui	a0,0x0
     a74:	3c050000 	lui	a1,0x0
     a78:	3c020000 	lui	v0,0x0
     a7c:	24840000 	addiu	a0,a0,0
     a80:	24a50088 	addiu	a1,a1,136
     a84:	24420000 	addiu	v0,v0,0
     a88:	0040f809 	jalr	v0
     a8c:	24060283 	li	a2,643
     a90:	8e040004 	lw	a0,4(s0)
     a94:	8e030000 	lw	v1,0(s0)
     a98:	3c020010 	lui	v0,0x10
     a9c:	34420100 	ori	v0,v0,0x100
     aa0:	8e110008 	lw	s1,8(s0)
     aa4:	ac830000 	sw	v1,0(a0)
     aa8:	ae020000 	sw	v0,0(s0)
     aac:	3c020020 	lui	v0,0x20
     ab0:	34420200 	ori	v0,v0,0x200
     ab4:	ac640004 	sw	a0,4(v1)

This is part of the compiled version of packet_recv_thread. Due the=20
optimizations done I cannot say were exactly the problem lies.

I think the code of get_ip_addr() got inlined in packet_recv_thread and we=
=20
need to search for the crash inside of it at list_del(&entry->list);
I would also say that the really crash is inside __list_del where prev and=
=20
next will be set. To check it, look at LIST_POISON1 and LIST_POISON1 inside=
 of=20
poison.h of the current linux kernel. You will notice that the values are=20
0x00100100 and 0x00200200 =3D=3D address of the failed paging request. The =
list=20
poison stuff will be done in in list_del after calling __list_del (it is th=
e=20
sequence lui, ori, sw in the asm snipped). So could it be that we have a=20
poisened entry inside the list?
This could for example happen when we get scheduled (please notice that the=
=20
optimizer exchanged many instrictions) while another part of the program is=
=20
deleting entries. I haven't checked the rest of the code if that really cou=
ld=20
happen, but that is my current idea.

So for better readability the callstack:
=2D packet_recv_thread
=2D get_ip_addr from gateway.c:401
=2D list_del from gateway.c:645
=2D __list_del

Best regards
	Sven Eckelmann

--nextPart1367866.Rftx9O3oWk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjFlrMACgkQqQGwKVlMoDsLOACfXK/Av8hPlSit0wH4OU8MicB3
Zo8AnAxp/vq3WG3VCkPcCRw5fXZdHza6
=QQTT
-----END PGP SIGNATURE-----

--nextPart1367866.Rftx9O3oWk--
