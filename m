Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Jul 2010 15:04:07 +0200
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2203135.jJj0XkDj1J";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007061504.09139.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
Cc: greg@kroah.com

--nextPart2203135.jJj0XkDj1J
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Hi,
>=20
> here are patches targetted for 2.6.36. All patches needed for that patchs=
et
> are already part of your staging-next tree.
>=20
> All patches are cleanup patches and no new feature is added.
>=20
> thanks,
> 	Sven
>=20
> Antonio Quartulli (1):
>       Staging: batman-adv: Convert names from Java to C style
>=20
> Linus L=FCssing (1):
>       Staging: batman-adv: Avoid rounding issues for local hna timeout
>=20
> Marek Lindner (4):
>       Staging: batman-adv: replace manual calculation by msecs_to_jiffies=
()
> for better readability
>       Staging: batman-adv: Add sysfs abi documentation
> about bonding
>       Staging: batman-adv: adapting source version to revised
> versioning scheme Staging: batman-adv: fix early debugfs deinitialization
>=20
> Simon Wunderlich (1):
>       Staging: batman-adv: Lower resolution for timeouts
>=20
> Sven Eckelmann (3):
>       Staging: batman-adv: Add include guards to all header files
>       Staging: batman-adv: Allow to build it inside the kernel
>       Staging: batman-adv: Remove dependency to PROCFS

Hi,

we send you those 10 patches 10 days ago and they don't seem to be merged i=
n=20
you staging-next tree. Linus has already released -rc4 after his vacation a=
nd=20
it is unclear to me how long it takes until 2.6.35 is released and I am not=
=20
allowed to submit patches for 2.6.36.

Do you think that I can still submit some patches to you for 2.6.36 or shou=
ld=20
I wait for 2.6.37?

The remaining patches are logging related. One patch moves the printk's to=
=20
pr_(err|info|warning) and bat_(warning|info|error) makros. The second one=20
moves the logging of routing related information from kernel ring buffer to=
 a=20
private ringbuffer in debugfs for each batX device.

Best regards,
	Sven

--nextPart2203135.jJj0XkDj1J
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMMynIAAoJEF2HCgfBJntGTNMQAJllg1p0T/HwdgSrdcvi3YMk
HuMk4T+qwQ+uIDGYCVJxtScYPVZPIhgGcEFbgbasGc1bzskx8jX25rzGQ+7bAL9H
MGR8h4Jsgss6iNTLesXgahqENfBLlYEuNb5BeKIahjmFsblXD9lOJU4cd/yxtWTb
ulUG2Ru//hnliswyULVYaddooX9/2WXzoEqs7ix6CG1HtLaQmQPSLGPtBIP346Qi
v0T78SX+ZrHEky5+x4AyMG36jLFijIE96TFmeRv4CyhaE1lh1XOK12H6bREAj6+Q
RBPffbXsggIC6cTWqQGZ3erMvUGoK3qxQ0TfwHDYUl3VMD1R2LXymV4WuWNTGMyJ
QLoShdqSPPO7h6NgnCDIvUuZYg01U0PzOFDAyZ8xUX3YCaMr5X/GBWfajoY/S1EU
6W5eqgBwHkbFPbNk+56l7e9y+5E1oqPnzrMIzobvBEhAgYPZ/oRZ/LwDyQPwbuUw
SBoA2rkt5cSNXpmkhHHcAmIBdhPPZx7T4uyrMOxLf80Epnzk5h4tl/LSf1nMpbbc
CQ1jQO/YB83Ib8rfcgo8s7UO46yWqTRg0dRG9ENmWUtYcpCTKZvlQAzivpXP4Lmu
ZCoiSLx3SWAeWkxyNoy6wsXkqA06FrFTZsAsw5t2sI1L4yomKYMLM2ZQ/RrfmiGc
mX/RPMWORVMtuXE1dVTz
=JGXY
-----END PGP SIGNATURE-----

--nextPart2203135.jJj0XkDj1J--
