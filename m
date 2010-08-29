Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 29 Aug 2010 23:54:53 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1397097.6MQ9Z4WtnN";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008292355.02225.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] The state of batman-adv branches in august 2010
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

--nextPart1397097.6MQ9Z4WtnN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

as we started to have different branches and repositories, everything
became a little bit more complex to track. I will try to summarize what
and where is something going on inside the batman-adv universe.

There is currently one main change happening in the branch design. The
branch currently called 'maint' will be renamed to 'next'. This should
reflect that we work there on the features (already part of
master/trunk) which should be submitted to the kernel maintainers. This
branch is stopped quite early in the development phase - even before the
kernel with the corresponding features will be released.

=46or example the current patches for linux 2.6.36 (which will may be
released in 5 weeks) will be finished with the release of v2010.1.0. The
next branch will get immediately all patches which will be part of linux
2.6.37. This is needed because all patches must be tested in linux-next
a long time before Linus Torvalds opens the merge window vor linux
2.6.37.

Of course, this will create a small gap for bug fixes which will enter
linux 2.6.36 after the release of v2010.1.0. That's why we now use the
maint branch to track those changes. Maint will always be a branch on
top of the last release with all bugfixes which must be added to that
release and are not features for the next branch.

That new maint branch will also help other distributors to easily find
patches which should be applied on top of their shipped versions or for
users which want to build their version of batman-adv manually and still
get a version which fixes (hopefully) all know bugs. And maybe we will
have bug fix releases in the future...

 * trunk/batman-adv/ [1], master [2]

   In trunk is always summer - so changes always(?) enter here and will
   get moved to other branches unless they need some more time to get a
   fine flavor - or at least more testing. Even if everything should hit
   trunk, it is easier to describe changes in a different places (next,
   master-rebase).

   This branch can be used together with trunk/batctl/ [3]

 * next [4]

   This is were commits are gathered to be send later to the linux
   kernel folks. Only tested features or features which are dependencies
   for the in-kernel batman-adv should enter this branch.

   Since the last time [5] many things happened, but not all are
   finished yet. So for example the release of v2010.1.0 is still
   pending and so no patches for linux-2.6.37 have been send to GregKH.

   Meanwhile we had to deal a little bit with some regressions which
   were added when we changed to everything from procfs to sysfs. This
   is the reason why there were some patches sent to the linux
   stable-tree folks lately.

   After that release we we will merge some patches which are mostly
   needed to push the merge of batman-adv into linux-net a little bit
   further. That includes for example the preparation of nearly all data
   inside of skbs instead of external buffers and the usage of optimized
   kernel functionality for things which we tried to implement our self.
   But of course there are again quite interesting features:

   * batman-adv: layer2 unicast packet fragmentation
   * batman-adv: attach each hard-interface to a soft-interface
   * batman-adv: multiple mesh clouds

   Also patches were added which tweaked a little bit here and there.
   Many of them came directly from the kernel folks and dealt with
   smaller coding style problems.

   This branch can be used together with batctl-next [6]

 * linux-2.6.36

   The release of linux 2.6.36 isn't finished yet, but we have submitted
   all patches in next. We aren't yet in net/, but hope that this
   follows soon. All problems which David S. Miller [7] found were
   relative small and already fixed. We will wait until the first
   patches for the upcoming merge window were send to the staging tree,
   before we try to get really into net/.

   You may experienced some weird regressions when using early -RCs of
   linux 2.6.36. Those happened due to some smaller patch war between
   the guys from linux-net and us. Those changes clashed when GregKH had
   to merge them after the release of 2.6.35. Unfortunately he resolved
   the merge conflicts a little bit different than I expected. But those
   problems should be solved with the upcoming release of linux
   2.6.36-rc3.

 * linux [8]

   The dirty place were all the linux integration happens. It is ugly,
   misunderstood and uninteresting for most people.

   The last synchronization point was GregKH-20100821 [9]. It is a merge
   of linux-2.6.36-rc1 and v2010.0.0-46-ge3a0cc9 [10] + a documentation
   of all files we create in sysfs. So this synchronization point (a git
   tag) just says that we checked at least linux-2.6.36-rc1 for new
   patches not yet integrated in next/trunk of batman-adv and that we
   send our changes until that point to GregKH [11].

 * rebase [12]

   My personal playground. (With a little delay) I will try to get all
   changes in trunk rebased on top of next. As result we get only the
   essence of changes in trunk which aren't already part of next. This
   also means for example that patches will look like they were made
   with sysfs in mind when they are originally created files in /proc.
   Even when I always ensure that the files in master and rebase are
   100% equal, the original author may not be blamed when a single patch
   will try to eat your pet (or you could say that patches in that
   branch will not be checked by their original authors and I will only
   guarantee that when you apply all patches you will get the same files
   as in trunk).

   Nevertheless it is a great place to get and test feature patches on
   top of next without using the complete set of changes in master. Or
   to understand what goes on in trunk compared to next.

   After the release of v2010.1.0 we will only have the gateway patches
   again waiting to get merged into next.

    * batman-adv: adapting source version to revised versioning scheme [13]
    * batman-adv: adding gateway functionality [14]
    * batman-adv: send DHCP requests directly to the chosen gw [15]
    * batman-adv: best gw DHCP filter 802.1Q support [16]

   This branch will jump around and it is not save to track it using a
   local git branch.

   It can be used together with trunk/batctl/ [3]

   Maybe this is a good place to announce that there is something like
   master-rebase also to rebase current patches of batctl [17] on top of
   the latest release. It is unknown who will continue the work on that,
   but as it is not as complex at the kernel module, I doubt that it is
   really much work rebase and reorder those patches.

Last but not least, thanks to everyone who has done the real work

 *  Andreas Langer
 *  Joe Perches
 *  Linus L=FCssing
 *  Marek Lindner
 *  Randy Dunlap
 *  Simon Wunderlich

Special thanks goes to

 *  Kazuki Shimada
 *  Tim Glaremin

for extensive testing and debugging help. Lets see what the next months
will bring us.

Best regards,
	Sven

[1] http://downloads.open-mesh.org/svn/batman/trunk/batman-adv/
[2] http://git.open-mesh.net/?p=3Dbatman-adv.git;a=3Dshortlog;h=3Drefs/head=
s/master
[3] http://downloads.open-mesh.net/svn/batman/trunk/batctl/
[4] http://git.open-mesh.net/?p=3Dbatman-adv.git;a=3Dshortlog;h=3Drefs/head=
s/next
[5] http://git.open-mesh.net/?p=3Dbatman-adv.git;a=3Dshortlog;h=3D13bc17ebf=
3e6062d92673a31f1b60a2e60f85813
[6] http://git.open-mesh.net/?p=3Dbatctl.git;a=3Dshortlog;h=3Drefs/heads/ne=
xt
[7] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-July/003141.html
[8] http://git.open-mesh.net/?p=3Decsv/linux-merge.git;a=3Dshortlog;h=3Dref=
s/heads/linux
[9] http://git.open-mesh.net/?p=3Decsv/linux-merge.git;a=3Dcommit;h=3DGregK=
H-20100821
[10] http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dcommit;h=3De3a0cc90940915=
dd14e4ca6bdab6d74bbc60f4a4
[11] http://open-mesh.net/wiki/SubmittingLinux
[12] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dshortlog;h=3D=
rebase
[13] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3D59=
00c5e655797f2470532a1e1d1eb42dd55fd890
[14] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3Def=
d570e04d14993a837711fc150562574a53a835
[15] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3D1f=
498c63ae13135af1950809f4d5e41a1b509718
[16] http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dcommit;h=3D79=
1290fc06e64b779c6b0ee776d3273484692058
[17] http://git.open-mesh.net/?p=3Decsv/batctl-rebase.git;a=3Dshortlog;h=3D=
rebase

--nextPart1397097.6MQ9Z4WtnN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMetcuAAoJEF2HCgfBJntGyXEP/0X0qKh4zo0bCFujpJgZZ2SB
+Wt8s+4eiYJGyKQz4YWaphkaATEkomQwby27F6fe1+zUR9qRreDPPK7F4Jn1n/V2
l7b1knQ00/NdRRpUv1s7rjgTaM8xchfLAO/Yp5HVw9j2BLoPy5mD387PdR3LDwRz
PoXzwBwG44vvLdxtHL/baa3sFfqQ+bEthXBkDKqXTS1n7rcCK7as/2a52E98L5xU
HoXWo9WaVDus99vgvFZsWVxWp9AXGmtmbUPTNfWn38+nSLA3LpQI0r1w9lPupIPu
7lrNvYBxD3JfXK8VDA7itGdgQjX/I+WqqIw2Rm0tjUQj/SjD2hoNdYiWKm5Lnmfk
DCcGOQxLkVGVDuZZB5iTVWV2Ty2iMjbIzsT4YbA//ZU96S0x+a6ya0sU3NcHgYE0
s0HQ19em14gNZO0RpkjqcGUKfbZPhJnldF3j/0CKiTgRjIcf/86UAPBeAhJsFzaF
0OLD0Gpq7GJSBa0pOkx+qql51iihfkPJ23YuJW8Aph2d41UlmIWg6pdt2mfHPyi4
FQPSAufKgZdwBPeLkOBs7k71fLFwxxFUNt8KBtCFxX6fo+/qS/DjktSbCGRYG+Ad
8ShkL9oH6zlUNdFACTDSNriKOt5AW7vrAyY1HpKyCrJ8U+KGhEC3pJQ4E+v/vkV0
726nR3DjXGOIP/5OkxYP
=/DLi
-----END PGP SIGNATURE-----

--nextPart1397097.6MQ9Z4WtnN--
