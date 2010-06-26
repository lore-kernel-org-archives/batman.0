Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 12:59:35 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1277552691.31qh2zdsux";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006261259.36358.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] The state of batman-adv branches in june 2010
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

--nextPart1277552691.31qh2zdsux
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

as we started to have different branches and repositories, everything becam=
e a
little bit more complex to track. I will try to summarize what and where is
something going on inside the batman-adv universe.

Please note that the different repositories and branches were changed
slightly. For example batctl is now also available using git and the linux
integration branch was moved to a separate repository.

 * trunk/batman-adv/ [1], master [2]

   In trunk is always summer - so changes always(?) enter here and will get
   moved to other branches unless they need some more time to get a fine
   flavor - or at least more testing. Even if everything should hit trunk, =
it
   is easier to describe changes in a different places (maint, master-rebas=
e).

   This branch can be used together with trunk/batctl/ [3]

 * maint [4]

   This is were commits are gathered to be send later to the linux kernel
   folks. Only tested features or features which are dependencies for the
   in-kernel batman-adv should enter this branch.

   Since the last time [5] a lot of things happen. The most important one is
   probably the release of batman-adv 2010.0.0 [6]. This is essentially what
   you will get when you will build linux 2.6.35 - or what you will get when
   Linus will come back from his vacation [7] and merges GregKH's staging
   branch.

   Since that release we merged some patches from master which seems to work
   good enough (at least no major flaw was found during WMBv3 [8]).=20

    * batman-adv: 32bit sequence number and TTL for broadcasts [9]
    * batman-adv: Add bonding functionality [10]
    * batman-adv: bonding and interface alternating [11]
    * batman-adv: record route for ICMP messages [12]

   Also smaller patches entered it. For example some java style namings of
   variables and functions were converted to better match the kernel coding
   style, rounding issues were identified + resolved and the code was clean=
ed
   up a little bit.

   This branch can be used together with batctl-maint [13]

 * linux-2.6.36

   The release of linux 2.6.35 isn't finished yet, but we have submitted all
   patches in maint. This means that we have hopefully all patches in 2.6.36
   we wanted - this includes the debugfs and netfilter patches which were
   dropped in 2.6.35 because they were submitted to late (during the 2.6.35
   merge window instead a week before 2.6.34 was released).

   We also tried to contact the network subsystem developers to get a review
   [14] for batman-adv. This is needed to get it moved from
   drivers/staging/batman-adv to net/batman-adv/. Even if our goal is not to
   get it merged in 2.6.36, we still hope that we get enough information to
   merge soon into net/.

 * maint-0.2.2

   This branch was removed after the release of batman-adv 2010.0.0.

 * linux [15]

   The dirty place were all the linux integration happens. It is ugly,
   misunderstood and uninteresting for most people.

   The last synchronization point was GregKH-20100625 [16]. It is a merge of
   v2.6.34 and v2010.0.0-30-g13bc17e [17] + a documentation of all files we
   create in sysfs. So this synchronization point (a git tag) just says that
   we check at least v2.6.34 for new patches not yet integrated in maint/tr=
unk
   of batman-adv and that we send our changes until that point to GregKH [1=
8].

 * rebase [19]

   My personal playground. (With a little delay) I will try to get all chan=
ges
   in trunk rebased on top of maint. As result we get only the essence of
   changes in trunk which aren't already part of maint. This also means for
   example that patches will look like they were made with sysfs in mind
   when they are originally created files in /proc. Even when I always ensu=
re
   that the files in master and rebase are 100% equal, the original author =
may
   not be blamed when a single patch will try to eat your pet (or you could
   say that patches in that branch will not be checked by their original
   authors and I will only guarantee that when you apply all patches you wi=
ll
   get the same files as in trunk).

   Nevertheless it is a great place to get and test feature patches on top =
of
   maint without using the complete set of changes in master. Or to underst=
and
   what goes on in trunk compared to maint.

   Currently we have following patches waiting inside of it

    * batman-adv: adapting source version to revised versioning scheme [20]
    * batman-adv: move queue counters into bat_priv [21]
    * batman-adv: adding gateway functionality [22]
    * batman-adv: send DHCP requests directly to the chosen gw [23]
    * batman-adv: best gw DHCP filter 802.1Q support [24]

    This branch will jump around and it is not save to track it using a loc=
al
    git branch.

    This branch can be used together with trunk/batctl/ [3]

Last but not least, thanks to everyone who has done the real work

 * Antonio Quartulli
 * Dan Carpenter
 * Daniel Seither
 * Javier Martinez Canillas
 * Jiri Pirko
 * Joe Perches
 * Linus L=FCssing
 * Marek Lindner
 * Simon Wunderlich
 * Tejun Heo

and lets see what the next months will bring us.

Best regards,
        Sven

[1] http://downloads.open-mesh.org/svn/batman/trunk/batman-adv/
[2] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/ma=
ster
[3] http://downloads.open-mesh.net/svn/batman/trunk/batctl/
[4] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/ma=
int
[5] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3D11d889980441d=
d5350e6faac83d8f9e53320092b
[6] http://open-mesh.net/wiki/2010-06-19-batman-adv-2010-0-0-release
[7] http://lkml.org/lkml/2010/6/6/3
[8] http://open-mesh.net/wiki/2010-06-13-wbm2010-bracciano
[9] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dcommit;h=3D0e5c09ca3f7f145=
96fbf932d18954b78f3ac8afa
[10] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dcommit;h=3D287063696f2d3d=
fc21afe4fec22c7163cf627666
[11] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dcommit;h=3D231c5e0b8f79f7=
9b90247f44e64ec82922909f7d
[12] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dcommit;h=3D1a0a622c040bcc=
6db492af5df50ad3bb5cb4d9ae
[13] http://git.open-mesh.net/?p=3Dbatctl.git;a=3Dshortlog;h=3Drefs/heads/m=
aint
[14] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-June/003008.html
[15] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/l=
inux
[16] http://git.open-mesh.net/?p=3Decsv/linux-merge.git;a=3Dcommit;h=3DGreg=
KH-20100625
[17] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dcommit;h=3D13bc17ebf3e606=
2d92673a31f1b60a2e60f85813
[18] http://open-mesh.net/wiki/SubmittingLinux
[19] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dshortlog;h=3D=
rebase
[20] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3Db0=
df1c48a435aa4eae5548cc230d9ab4541942d1
[21] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3D82=
2bb7e77ee2e0174cb3048e91e5f19931b3aa91
[22] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3D73=
d01acffd6bdf46d7262f6e301e6d92e26f866f
[23] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3D37=
0a2b6521cc52b7538445193f880a31829d24ab
[24] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3Dd4=
199c7fbe5e83bd9656d92f6561b5824e4ca3f4

--nextPart1277552691.31qh2zdsux
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMJd2XAAoJEF2HCgfBJntGUGgQAIsZezec+sDwTXbQ4vLRlPAR
aPBTbV9gFoU7XJIxtlmGl/aUTww7Bs4pyHs10F569OVILh+XFVpazKTyPAWmbWNA
4iRAbikRXGtpVMhCH5SjI2cC8I3C3ueaW6jMRW5YpYpOcsjnrepUCcJXGVeki9y2
5Cbf1+3R0VRa9TyJKwcaf49hjQxgoaciuFN1cJmfkYHlxznRwh3secI5UsH/7Dwd
clvCBXwPCwEL8t6rFHQv5lxg+W0J6lUIGLcVcNgmsD7/PRVgI7uTeDAS8JttWJTi
qnKFvBmeQeM6Y2C5qPK+9bwQ/kFf0SRRxTWnkrT2TrX/nXzew3p8HtKp0Ct/1LtL
QbUrzFssW/V7PEfpSxX3nCaE2b/tNyOc8qJVhIFKXZMhTD6jn8BXLzuI1/owqE0T
qXbxDetcKs2GheUWb0TbAEG8mRI54XJKKGsxtLrnaNnDwCS6RcyNajgjLdLdSDMH
ZNtQ48I14D/fjTgGV2KYm0IoJdWCLRbXMbmP08LFXX+CLJXZWQyBy6v01hy7dPwo
4EtaMgC+Bc061b7N1GXfWeUNyMsU0dETkCPR2bDA1vskFRUzSW2b6ZSnCK7WxYLY
3Tyo91LPx2bCkvbRK7H86WX6QcLqUaAXbuDyonLokxcICfyCpY0esl/jmbeq3W49
ikpxCh2jEGwDGaq1g5W3
=lCqY
-----END PGP SIGNATURE-----

--nextPart1277552691.31qh2zdsux--
