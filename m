Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Apr 2011 10:25:39 +0200
References: <1302891882-11246-1-git-send-email-linus.luessing@web.de>
	<201104160954.49563.sven@narfation.org>
In-Reply-To: <201104160954.49563.sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1383199.tY4Zr9t5EC";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104161025.40133.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix crash on module shutdown
	with multiple ifaces
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

--nextPart1383199.tY4Zr9t5EC
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Linus L=FCssing wrote:
> > hardif_remove_interfaces() removes all hard interfaces from the
> > hardif_list before freeing and cleaning up any device. However the clean
> > up procedures in orig_hash_del_if()
> > (hardif_remove_interface()->hardif_disable_interface()->
> > orig_hash_del_if())
> > need the other interfaces still to be present in the hardif_list.
> > Otherwise it won't renumber any preceding interfaces, which leads to an
> > unhandled kernel paging request in orig_node_del_if()'s "/* copy second
> > part */" due to wrong hard_if->if_num's.
> >=20
> > With this commit the interface removal on module shutdown will be down
> > in the same way as removing single interfaces from batman only: One
> > interface will be removed and cleaned at a time.
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
>=20
> Please use --patience as requested in
>  http://www.open-mesh.org/wiki/open-mesh/Contribute
>=20
> Please show us (as part of the commit message) why the information in
>  http://www.open-mesh.org/projects/batman-adv/repository/revisions/132b77=
6c
> 22c9b71962a3ed9a33e5b6f9218dae1b isn't valid anymore and explain why it is
> save to use the spin_lock only inside the loop (but it would have to
> protect the loop in normal situations).

Sry, this was not the correct commit - The commit which fixed a problematic=
=20
locking behaviour was 5d4b5a4d - but I didn't gave a lockdep output there.

The other question must still be answered.

Btw. what is the status of the sysfs_addrm_finish vs. rtnl_lock patch?

Kind regards,
 	Sven

--nextPart1383199.tY4Zr9t5EC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNqVKDAAoJEF2HCgfBJntGju8P/3nGeMHSreEM1FgYEYLrrYSF
k4U0kD7/6Pe9EJLNrTyDCqIMsSZfYH7/VNgxQA47hVSZqZ7H5as1y1sNwzMqg2tS
uaEaIGglnNr2rwLrPkaIU3mtbccl0PaP0xu9Rezh1ZyDCh3gIUrkKStCR7eAaVFc
x5dPN08x83eCgCKEEsMg09QYgiLl4GZx51TSMqBks0tEAzeDVwm8fAXigoCE0n0t
3fnNY0lEJI85o0Y3iXXGI2xPI1IohgK5zSPNrhxqPXEXRt1lxMD0Co+U7I54qOAQ
aR16mvDdCqxJcaLl0QvrsOB6b3fcCUGRLIPENQLIq9Gzg3mskViXM8CtT9RpqGr+
BXVKbnZMjd2N+KgclHmA0DeyH1wwVZKZgF8s0vv/k7cxhQOXY0peFYukLwjXNE5j
80GBbNS2NwOovpUThleiERmJAd5mYnVzk5TOdFDOxCpCltG1IVYa4paQLn0uAvfA
kYZQCymfE2so2FmPIvsrVtgSVOlXvFnV3UwjSS37xW97x0ykSQSOuitHFV/O09VP
CpN/5Y4NIsGQ7QoroNhoJXBz0BfJOOxnFD86EHJAEaePUo6SvwnQd5cWgmA4NV0/
RqKTIHq5T66dXHQQtcYNN/VR/4Cxf3hr8deXFy2mlfXjhT04tcUeNNiwYTbqDi6W
Do7KTAi2mrzW0wQ++cUW
=gsTt
-----END PGP SIGNATURE-----

--nextPart1383199.tY4Zr9t5EC--
