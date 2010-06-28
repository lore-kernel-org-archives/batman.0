Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 28 Jun 2010 18:40:07 +0200
References: <AANLkTimCSkFrm9F7DF6HWBBgo4PCb5qmy6xEmeHGonLl@mail.gmail.com>
In-Reply-To: <AANLkTimCSkFrm9F7DF6HWBBgo4PCb5qmy6xEmeHGonLl@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1472240.VF3iaLAsTX";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006281840.08381.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Multicast video over 2 node mesh
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
Cc: Nathan Wharton <nwharton@gmail.com>

--nextPart1472240.VF3iaLAsTX
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Nathan Wharton wrote:
> I am having problems getting multicast video over my 2 node mesh.  I
> am building under openwrt and the version is 0.3.0-alpha rv1715.

=46irst thing: multicast is currently implemented over broadcast.

> I have a lan bridge on each side.  If I directly add ath0 to the lan
> bridge the video works fine.  But since I want to mesh, I put ath0
> into bat0 instead, and then I put bat0 into the bridge.  This works
> for all my traffic that put across it so far except the multicast
> video.  A tcpdump comparison of both sides shows that after about 32
> packets data starts getting dropped.  The video is about 1Mbs.

Simon changed to broadcast code some time ago. Maybe it is related. Can you=
=20
please try to use ethernet to transfer the data between the nodes (so bat0=
=20
should only have the ethernet device included). Just as test if it could be=
=20
related to midair collisions due to the broadcasts resends or if the broadc=
ast=20
code as a general problem.
=20
> Given this thousand foot view of the problem, is there something
> obvious I might be missing?  I've set the mtu on ath0 to 1524.
> Everything else seems to work fine, including copying a file over the
> mesh setup that is 20MB at a speed of 578.9KB/s and the md5sum was
> right.

=46ile transfers are unicast. So little problematic to compare with your=20
situation.

thanks,
	Sven

--nextPart1472240.VF3iaLAsTX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMKNBnAAoJEF2HCgfBJntG+JYP/1tT1LrkexChfo87eDyM+0mw
DYRHIjMPJZ6YSvqNRXegoayXfiliNl2FDeQ2SeoRpu1sVQ4m/p8D2jEu51McFkDL
SuDTg+YAfDmf4CVO/KJjpZ3/Pyjt1ZwrU+2YfelETe93fbwHvycVv31zj6DDRFmx
5ix8yB/pjG17Xv2ob9A5t/mnpCJu0qCUa5AH6t8szzIhI8rGCPdEjABNIyPPNKtW
lXxL8P/7dBgmUAJEBG6EAKriCXUy813lRRAwD5t7631BCIZPZ5nSI8+p036Q2WXf
f1RnXQeBjYh7vFOG2lJkLqYoaIRxO6DVMAlSuZFnyuGCz4m6l/WVe+1SQWfodEo6
vFyUYBJ8EkQkFaGksCdlczi0CHZiMXdyFSJeFIkznSi41wOfB6rV/JO8r/slcfs7
5dn60hi9F92V00mokuBHH/iDGjCglGcdtuoDPq/FHQl81htAz+j9MpYINxPC9eqe
UXgbwIr7mtX/ic600biZ67BlTcOHqQVyJEIMIbwFD/kfr53FsAfUHHPeO2HSktkp
ngPysJt/O+zDYv7im866scRw1/1LH3d9MGg4CYxJ5bHbIO5Uy7zZiH+WbjDlalhT
iRj1tLr++LabIm/ZqZrELmwHcnNNumyNDCuJ+FRCmCOz8/in75wNxaK/LaUmXYvP
YmK0PD0SANmqh7IQ0D+F
=JRfb
-----END PGP SIGNATURE-----

--nextPart1472240.VF3iaLAsTX--
