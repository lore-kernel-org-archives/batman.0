Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 28 Oct 2010 11:49:31 +0200
References: <1288166545-8252-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288166545-8252-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2720223.4ue3b7pcMG";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010281149.45974.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Correct sparse warning about
	different lock contexts for basic block
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

--nextPart2720223.4ue3b7pcMG
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 October 2010 10:02:25 Sven Eckelmann wrote:
> sparse noticed that if_list_lock is taken in some situations with bottom
> halfes disabled in some SMP kernels and that we must always lock it with
> spin_lock_bh.

I would like to reject that patch by myself. Not that it does something bad=
,=20
but more that it does not make any sense what sparse says. I've looked thro=
ugh=20
the 2.6.32 smp code and couldn't locate the real problem. So if anyone has =
a=20
opinion or can show were the actual problem is... please tell me.

My current test was done like that (on debian squeeze i386):
=2D----------------------------------------------------------
$ cd $MY_v2.6.32
$ make mrproper
$ make allnoconfig
$ grep -v 'CONFIG_MODULES is not set' .config > .config.tmp; mv .config.tmp=
 \
 .config
$ grep -v 'CONFIG_NET is not set' .config > .config.tmp; mv .config.tmp \
 .config
$ grep -v 'CONFIG_SMP is not set' .config > .config.tmp; mv .config.tmp \
 .config
$ grep -v 'CONFIG_MODULE_UNLOAD is not set' .config > .config.tmp; mv \
 .config.tmp .config
$ echo 'CONFIG_MODULES=3Dy' >> .config
$ echo 'CONFIG_NET=3Dy' >> .config
$ echo 'CONFIG_SMP=3Dy' >> .config
$ echo 'CONFIG_MODULE_UNLOAD=3Dy' >> .config
$ echo 'xy'|make menuconfig
$ make prepare
$ make modules


$ mkdir test
$ cd test
$ cat << EOF > Makefile
obj-m +=3D test.o
test-y +=3D main.o
EOF
$ cat << EOF > main.c
#include <linux/module.h>
#include <linux/spinlock.h>

static DEFINE_SPINLOCK(testlock);

static int __init test_init(void)
{
	spin_lock(&testlock);
	spin_unlock(&testlock);
	return 0;
}

static void __exit test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);
EOF


$ make CC=3Dcgcc -C $MY_v2.6.32/linux-next M=3D$(pwd) modules         =20
make: Entering directory `$MY_v2.6.32'
  CC [M]  $MY_v2.6.32/testmodule/main.o
$MY_v2.6.32/test/main.c:6:19: warning: context imbalance in 'test_init' -=20
wrong count at exit
  LD [M]  $MY_v2.6.32/test/test.o
  Building modules, stage 2.
  MODPOST 1 modules
  LD [M]  $MY_v2.6.32/test/test.ko
make: Leaving directory `$MY_v2.6.32'
=2D----------------------------------------------------------

The sparse version was v0.4.3.

I will post a question regarding that problem on the sparse mailinglist

Best regards,
	Sven

--nextPart2720223.4ue3b7pcMG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMyUcuAAoJEF2HCgfBJntGUhAQAMcaEaLpxaix5xZ4Qq9UHr9y
BRyIiiz48Oknqz3QomJnFyaV/vk8ktpU+RoP8wK1tdWDvzohqXPzEHuvtIP4meou
prMYCNVQ4jYmJIfFxrEvwZKbngN2gTP0OMbg5mU7/nfOUfmmWlMnCKdeMKT9c2hv
NYwJmpLY25vWXal8pvBtpryGSh2R6Kez65lF0Y0fYv4bCoB3Nddn/L+TxpP6wf5m
K4xQbFBLBBgXrT0S8AmF/ReQtLqfR04h23Nc+oMULu/guuH902MyQQ/kynCWK8zj
SY5NadDUx8A9j4osxeFsU3XCBU5j4iG7hjTcIWYgy74wPcL7X2dmHzhMUbcsUdc/
6AGcpxQ5GkG+YTWTaCFikmFGNccZusq0pB2lN9mI0Wy7eTxEW18ewv5vQRNThpAL
rdTcFtkWCE8zXhbAcqsEkrvtRqHcTqTU8dfd7Zx9On+CpXpsqaJYKUjol3cVA6Il
IT0UwwKybFM5xDmQkUjXJQtrqGgmGYlo6y5CIxmkxpG4CykxJ33lRza4G6IvMG+N
kX+em2Hpu1t1NKyTT4tEoBdfcMulMYRsFGEusUTs2UkFFA55ygoJazMbFiexiOzS
n0iN14rmtkUvkKv41Q3v7n+7p6+R7FmsDW0u6sUgCgpaeSHaBe3IzpHbSFU1ik75
KnqRabZYUmdMfXsuv1GO
=3cyi
-----END PGP SIGNATURE-----

--nextPart2720223.4ue3b7pcMG--
