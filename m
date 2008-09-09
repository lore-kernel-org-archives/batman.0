Date: Tue, 9 Sep 2008 13:26:47 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Message-ID: <20080909112647.GA747@pandem0nium>
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
	<200809082318.54082.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <200809082318.54082.sven.eckelmann@gmx.de>
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sven,

thanks for you analysis!!

On Mon, Sep 08, 2008 at 11:18:42PM +0200, Sven Eckelmann wrote:
> Ok, I got the /proc/modules file now. Current situation is following: it=
=20
> crashes inside the the batman module add position 0x00000aa4
>=20
>     a60:	3c020000 	lui	v0,0x0
>      a64:	8c500024 	lw	s0,36(v0)
>      a68:	24420024 	addiu	v0,v0,36
>      a6c:	12020014 	beq	s0,v0,ac0 <cleanup_module+0x610>
>      a70:	3c040000 	lui	a0,0x0
>      a74:	3c050000 	lui	a1,0x0
>      a78:	3c020000 	lui	v0,0x0
>      a7c:	24840000 	addiu	a0,a0,0
>      a80:	24a50088 	addiu	a1,a1,136
>      a84:	24420000 	addiu	v0,v0,0
>      a88:	0040f809 	jalr	v0
>      a8c:	24060283 	li	a2,643
>      a90:	8e040004 	lw	a0,4(s0)
>      a94:	8e030000 	lw	v1,0(s0)
>      a98:	3c020010 	lui	v0,0x10
>      a9c:	34420100 	ori	v0,v0,0x100
>      aa0:	8e110008 	lw	s1,8(s0)
>      aa4:	ac830000 	sw	v1,0(a0)
>      aa8:	ae020000 	sw	v0,0(s0)
>      aac:	3c020020 	lui	v0,0x20
>      ab0:	34420200 	ori	v0,v0,0x200
>      ab4:	ac640004 	sw	a0,4(v1)
>=20
> This is part of the compiled version of packet_recv_thread. Due the=20
> optimizations done I cannot say were exactly the problem lies.
>=20
> I think the code of get_ip_addr() got inlined in packet_recv_thread and w=
e=20
> need to search for the crash inside of it at list_del(&entry->list);
> I would also say that the really crash is inside __list_del where prev an=
d=20
> next will be set. To check it, look at LIST_POISON1 and LIST_POISON1 insi=
de of=20
> poison.h of the current linux kernel. You will notice that the values are=
=20
> 0x00100100 and 0x00200200 =3D=3D address of the failed paging request. Th=
e list=20
> poison stuff will be done in in list_del after calling __list_del (it is =
the=20
> sequence lui, ori, sw in the asm snipped). So could it be that we have a=
=20
> poisened entry inside the list?
> This could for example happen when we get scheduled (please notice that t=
he=20
> optimizer exchanged many instrictions) while another part of the program =
is=20
> deleting entries. I haven't checked the rest of the code if that really c=
ould=20
> happen, but that is my current idea.

Mhm, as far as i looked into the issue, there are the following=20
points where free_client_list is accessed:

init_module() - INIT_LIST_HEAD()
* called on startup

get_ip_addr() - list_del():
* "secured" with a hash_lock spinlock

cleanup_module() - list_del():
* only called when unloading the module

batgat_ioctl() - list_del()
* from IOCREMDEV. This is called when batman shuts down.

packet_recv_thread - list_add():
* also secured in a hash_lock spinlock.

So it seems there should be no concurrency without user interaction=20
(module or batman shutdown).
But i don't have a good idea yet where the problem comes from  ... :/

best regards,
	Simon

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIxl13rzg/fFk7axYRAgZ4AKDOsa5sabLEsthBiiZ2tHiof2y1mACgov4f
6TgB6Bsd9c9iGcxpdO30+g4=
=wQVM
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
