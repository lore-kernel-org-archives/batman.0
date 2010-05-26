Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 26 May 2010 23:40:32 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1620568.0bhC8eWqPQ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005262340.41252.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] The state of batman-adv branches in may 2010
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

--nextPart1620568.0bhC8eWqPQ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

as we started to have different branches and repositories, everything becam=
e a=20
little bit more complex to track. I will try to summarize what and where is=
=20
something going on inside the batman-adv universe.

 * http://downloads.open-mesh.org/svn/batman/trunk/batman-adv-kernelland/
   http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/mas=
ter

   In trunk is always summer - so changes always(?) enter here and will
   get moved to other branches unless they need some more time to get a fine
   flavor - or at least more testing. Even if everything should hit trunk, =
it=20
   is easier to describe changes in a different place.

   This branch can be used together with
   http://downloads.open-mesh.net/svn/batman/trunk/batctl/

 * http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/mai=
nt

   This is were commits are gathered to be send later to the linux kernel
   folks. Only tested features or features which are dependencies for the
   in-kernel batman-adv should enter this branch. We have already created t=
he
   release v0.2.1 only from commits inside that branch while we developed n=
ew
   stuff in parallel in trunk.

   Since that release we received smaller patches which were merged into the
   linux mainline first or which were send to us directly from people which
   actually wanted to fix problems of the in-kernel batman-adv directly. We
   had for example style changes or patches which will guarantee that
   batman-adv still builds in upcoming kernel releases - things we otherwise
   would have to analyse after that kernel was released. So instead of havi=
ng
   a user which notices that batman-adv doesn't build anymore, we got the
   fix for the problem which will exist somewhere in the future directly fr=
om
   the people which will create that problem. :)

   As one of the bigger changes we started to port batman-adv from /proc to
   sysfs and debugfs. batctl was also changed to work on top of the new
   configuration and debugging infrastructure. Unfortunately this change is=
 a=20
   two step process. First we changed everything from /proc to sysfs and la=
ter
   moved parts of the files in sysfs to debugfs because they were not single
   value files. But later more about those changes in maint-0.2.2.

   Beside smaller bugfixes, a bigger problem was found when receiving an
   enormous amount of broadcast packets which must be rebroadcasted. It cou=
ld
   happen that those packets looped inside the mesh. It was tried to fix th=
at
   problem without changing the packet format. Even if that reduced the
   problem, there are more changes coming later which needs changes to the
   packet format.

   Also a smaller new feature has entered maint - the ability to allow
   netfilter/ebtables to filter incoming packets which are directly for
   batman-adv.

   This branch can be used together with
   http://downloads.open-mesh.net/svn/batman/branches/batctl-0.2.x/

 * linux-2.6.35

   The merge window has opened over a week ago and all patches (patches we
   send at least a week before it was opened) were accepted. Newer bugfixes
   will probably accepted in some days. Unfortunately some patches like the
   move of some files to debugfs weren't finished right in time and will on=
ly
   be merged into linux-2.6.36 because they are more than just simple
   bugfixes. That includes the removing of /dev/batman-adv in favor of
   debugfs, moving of tables from sysfs to debugfs and the netfilter
   integration.

 * http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/mai=
nt-0.2.2

   As we weren't able to merge all patches inside maint in linux-2.6.35 and=
 we
   still want to be able to provide a release which behaves like the version
   in 2.6.35, it was decided that we just use a version before the debugfs
   patches and create a branch which will gather all bugfixes in maint. It
   will be merged and removed after the release of batman-adv-kernelland-0.=
2.2
   or plans are changed. So better don't start a friendship with this little
   buddy.

   If you want to try that branch or any snapshot of 2.6.35 then please try=
=20
   revision r1664 of
   http://downloads.open-mesh.net/svn/batman/branches/batctl-0.2.x/

 * http://git.open-mesh.net/?p=3Dbatman-adv;a=3Dshortlog;h=3Drefs/heads/lin=
ux

   The dirty place were all the linux integration happens. It is ugly,
   misunderstood and uninteresting for most people.

   The last synchronization point was GregKH-20100522. It is a merge of
   v2.6.34 and v0.2.1-38-gbcde864 + a documentation of all files we create =
in
   sysfs. So this synchronization point (a git tag) just says that we check=
 at
   least v2.6.34 for new patches not yet integrated in maint/trunk of
   batman-adv and that we send our changes until that point to GregKH.

   In reality the patches are modified a little bit.
    * Files are moved from / to /drivers/staging/batman-adv
    * compat.h, bat_printk.c, Makefile.kbuild are removed
    * all references (#include) to compat.h are removed
    * TODO, Kconfig, sysfs-class-net-batman-adv and sysfs-class-net-mesh are
      added
    * Makefile is rewritten to look like a stripped down version of
      Makefile.kbuild
    * All passages how to compile batman-adv outside of the kernel are remo=
ved
      from README
    * Squashed with patches which only fix another patch

   All those changes are done for each patch (or at least ensured that no
   changes will conflict with those points) on top of the last merge point.
   This should ensure that we don't diverge too much from maint with the
   in-kernel batman-adv.

   Each patch is then applied on top of a current linux-next, tested if it
   compiles, checked with sparse and checkpatch.pl --strict. When everything
   looks fine, they get exported again using git-format-patch and send to
   GregKH.

   Only because a change is part of a synchronization point, it doesn't mean
   that it will appear with the next linux kernel. As said before, all=20
   bugfixes between GregKH-20100510 and GregKH-20100522 will be part of
   2.6.35, but anything bigger will be part of 2.6.36.

 * http://git.open-mesh.net/?p=3Decsv/master-rebase.git;a=3Dshortlog;h=3Dre=
base

   My personal project. (With a little delay) I will try to get all changes=
 in
   trunk rebased on top of maint. As result we get only the essence of chan=
ges
   in trunk which aren't already part of maint. This also means for example
   that patches will look like they were made with sysfs in mind even when
   they are originally created files in /proc. Even when I always ensure th=
at
   the files in master and rebase are 100% equal, the original author may n=
ot
   be blamed when a single patch will try to eat your pet (or you could say
   that patches in that branch will not be checked by their original authors
   and I will only guarantee that when you apply all patches you will get t=
he
   same files as in trunk).

   Nevertheless it is a great place to get and test feature patches on top =
of
   maint without using the complete set of changes in master. Or to underst=
and
   what goes on in trunk compared to maint.

   Of course you cannot use all patches in any order because they have
   dependencies between each other. A the moment we have following patches
   which should be quite easy to use together with any other patch:

    * batman-adv: mark trunk as 0.3.0 alpha
    * batman-adv: Add bonding functionality
    * batman-adv: move queue counters into bat_priv

   We have also patches which changes the packet compat version to 9 (all
   gateway patches must be used in that order, otherwise they would not
   apply):
    * batman-adv: adding gateway functionality
    * batman-adv: send DHCP requests directly to the chosen gw
    * batman-adv: best gw DHCP filter 802.1Q support
    * batman-adv: record route for ICMP messages

   The last patch increases the compat version 10 and thus requires the
   patches which justify the compat version 9 ("adding gateway functionalit=
y",
   "record route for ICMP messages"):
    * batman-adv: 32bit sequence number and TTL for broadcasts

   This branch will jump around and it is not save to track it using a local
   git branch.

   This branch can be used together with
   http://downloads.open-mesh.net/svn/batman/trunk/batctl/

Last but not least, thanks to everyone who has done the real work
 * Andrea Gelmini
 * Andrew Lunn
 * Dan Carpenter
 * Daniel Seither
 * Linus L=FCssing
 * Marek Lindner
 * Paul E. McKenney
 * Simon Wunderlich
 * Tejun Heo
and lets see what the next months will bring us.

Best regards,
	Sven

--nextPart1620568.0bhC8eWqPQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL/ZVQAAoJEF2HCgfBJntGcUMP/Re3dZ6TY14uTsEPhmx4wF0L
OOzxCyEFwVh3GkdrXPJ95HLKP2+5F4j/WJhcuqyln8xZc80pPaFi8+scliPwMyz0
d6MVkpC8qKXsD8UV8lS0XSCJMzAmPDJtjp28h/QHVTart5e/SHPRSixPk7QHxupc
4ovZXmMEMBCNF2aakLV9GGPKmrP7y6j7lgonPB0IknQDXLNqyrxtS1mOtXOmFTid
0lXquRe915h0HaCNWmatQQxB7OtLtd5qujTW4Tm5HgZuoF5G9mjjoi5/Bbhk0FVP
yC03AFRdE02DJQ8i6sibhMjBSg/heL/JKo8Np4Tw0amzqLblBdqY1iW/wbliA1A+
enH3Ux00Z1JIK5xXzzsKraW3SklZWXyPhXfxsrd+8gAnZ3tOjptNakpcpr7u5jDy
ZCl65dsrlQT0EWpSwoYCWslhIk/rjOIqTMmQfUgUgPyBMqVCSuxJpgpZOK1ebdfj
W49xsNQnAMjtjS0V51/5wU1uCxa2W0GyrqawN6K2xyk3bsmX2mMelk40XH0KvWaO
RM63ofr++z70Bi0cvnvfzCLwIyHcD5UPWOGK5zl7UaZsqgNGk5rbkS+SIFwIrbOa
E5+0He8vfYn1Hi2VKLyNm017ZMtzyLT1ZMxzd761zO5pdMWnzVM5PZpUtURxr6Vr
wGcJqTWsRUoLUe4ApQWG
=PK6V
-----END PGP SIGNATURE-----

--nextPart1620568.0bhC8eWqPQ--
