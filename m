Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 2 May 2011 21:15:47 +0200
References: <1304182620-12637-2-git-send-email-sven@narfation.org>
	<1304196854-28141-1-git-send-email-sven@narfation.org>
	<20110502171645.GB12500@Sellars>
In-Reply-To: <20110502171645.GB12500@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11553152.PGWErOAovD";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105022115.48413.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Remove unnecessary
	hardif_list_lock
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart11553152.PGWErOAovD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> Looks quite good and seems to make sense to avoid the
> double-locking. Tested it here and together with patch 1/3 fixes
> the initial issue, too.
>=20
> Just one minor thing:
> ----
> [58518.225154] batman_adv: bat0: The MTU of interface eth1 is too
> small (1500) to handle the transport of batman-adv packets.
> Packets going over this interface will be fragmented on layer2
> which could impact the performance. Setting the MTU to 1527 would
> solve the problem.
> [58518.278111] RTNL: assertion failed at
> /home/mesh-node/incoming/batman-adv-git-builddir/hard-interface.c
> (136)
> [58518.293167] Pid: 6366, comm: bash Not tainted 2.6.38+ #4
> [58518.299142] Call Trace:
> [58518.300953]  [<f8cb91f3>] primary_if_select+0x2f/0x9f
> [batman_adv]
> [58518.447844]  [<f8cb8e9c>] ? rcu_read_unlock+0x1c/0x1e
> [batman_adv]
> [58518.452572]  [<f8cb9146>] ? primary_if_get_selected+0x6a/0x71
> [batman_adv]
> [58518.455759]  [<f8cb92c6>] hardif_activate_interface+0x63/0x91
> [batman_adv]
> [58518.459168]  [<f8cb98e4>] hardif_enable_interface+0x1cc/0x21e
> [batman_adv]
> [58518.462481]  [<f8cb7bca>] store_mesh_iface+0xed/0x113
> [batman_adv]
> [58518.465564]  [<f8cb7add>] ? store_aggregated_ogms+0x28/0x28
> [batman_adv]
> [58518.468714]  [<c11e1121>] kobj_attr_store+0x1a/0x22
> [58518.472277]  [<c11481dc>] sysfs_write_file+0xbc/0xe7
> [58518.613128]  [<c1148120>] ? sysfs_open_file+0x205/0x205
> [58518.616400]  [<c10ff7a7>] vfs_write+0x84/0xde
> [58518.660437]  [<c10ff89a>] sys_write+0x3b/0x60
> [58518.667248]  [<c151fd9d>] syscall_call+0x7/0xb
> [58518.672117] batman_adv: bat0: Interface activated: eth1
> ----
>=20
> So maybe it makes sense to add the assertion in
> primary_if_select() in patch 3/3 instead?

No, the problem is that I changed the patch after I noticed that it wasn't=
=20
made for the current master - and only tested after all patches were applie=
d.=20
I would like to add rtnl_lock/rtnl_unlock around primary_if_get_selected()=
=20
instead.

> Hmm, and I'm wondering if it might make sense to also document it
> with a little comment above the struct list_head hardif_list;,
> like:
> /* List additions and deletions have to be rtnl_lock()'ed,
>  * list traversals just rcu-locked */
> (or is that overdoing it?)

Ok, will steal this comment from your mail - ok, change it slightly to pres=
ent=20
it as my own work.

Kind regards,
	Sven

--nextPart11553152.PGWErOAovD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNvwLjAAoJEF2HCgfBJntGdA4QAJ91G48mrjF9HxZGipK3x4Ah
HS4LFc5xxmWBe5GTCkkMMx4dyo9TWRyPkeCkRd7QkpPU1gK5FQYGlKPtpc/VHmzY
B9bv4jGlWdpqngOk1sA/7sB0DV/NccwD3jUTpu7huxiBHDqr5oqwzxYHSIxadjjp
Mi+7VZ43UrtBL+lCy7njubTAGHJ1sAHtr/zWy77yrVBMFP725vdVn815cUI2x5jy
49XZcVDDZ6+UBiHEJ82j2oDK+8cyt0+Ujc6OnagU2PNxhWOXIsX3hAHPprmSD4UY
kE3v1Qrys2PJmK/ic5/a9DKXqB9Sw9q012kaOs1c7C6fF/PqqUJHoROC6sJ3uPyh
6Km2fig2jDyOd7uxB8TFutHtMTWkl0/9GRB9hDYKRGpVnjjsCsgSL0SuS2a3+0Mk
JBgkrd7zDYWWWU03vXlz3t340ZBzxDfhidMSICvOb+/LNs2nW27mixP0VNVn293Y
tNcnP0rPYv4sIAHRnfhAU9AkYLCxBZ+b5EEYMm0fNWqgHnP78wPlcX25t5HxjNjO
lpFpe1az/HZ2BW1lPxDXDcByxPGIWA+TnHEiu4Ymm3jCJce0pxxxilYuMRJAuxpb
guSfKkJk6ruPHUkoZKNwTkPUWpQ2vbxQ6zLe1XNqoHIjbuGaQhdV631dF64Hj83y
lsVgNV1xNb0zYtTUBAL6
=/EV2
-----END PGP SIGNATURE-----

--nextPart11553152.PGWErOAovD--
