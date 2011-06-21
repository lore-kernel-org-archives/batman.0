Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Jun 2011 15:12:31 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5074535.lrt4yXDKY7";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106211512.34486.sven@narfation.org>
Subject: [B.A.T.M.A.N.] One step back
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

--nextPart5074535.lrt4yXDKY7
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

after the last mail of David S. Miller, it was more than clear that I am no=
t=20
the right person to speak on behalf of the batman-adv community. I have the=
=20
same opinion about the always changing protocol as he does. I first struggl=
ed=20
with it after getting the batman dissector merged in wireshark, but it is=20
confronting everyone since the merge into the linux kernel began. Andrew=20
already told us that we would need to get some kind of stable on the wire=20
format and some kind of backward compatibility, but it doesn't look like we=
=20
get there soon.

I don't know who currently follows which vision, but I know that all those=
=20
ideas make the protocol incompatible with the versions before (and this wil=
l=20
happen again and again and again ...). I don't have answers how it can be d=
one=20
differently and still the current problems can be solved. That means, I can=
=20
neither represent the position of the ongoing protocol developments nor the=
=20
position of the backward compatibility.

So, I doubt that I can present the changes to David S. Miller any longer wh=
en=20
I am sure that he doesn't like the patches for the same reasons I don't lik=
e=20
them. It is better that I don't stand in the way as "grumbling old man" [2]=
=20
and make the position free for someone who can really speak on behalf of th=
e=20
current active developers of batman-adv.

So the first thing I did was a big cleanup. Most of my git repositories are=
=20
gone now:

 * ecsv/batctl-rebase / ecsv/master-rebase
   The development was changed to git some time ago. This makes those
   repository relatively useless when the development is done in the
   current branch structure. This means that next gets bugfixes/cleanups
   which still can be merged by David and then the branch is merged into
   master instead of cherry picking patches around. After a release the next
   branch (or better the tag of the release) has to be merged into master
   (without changing the SOURCE_VERSION in main.h to something else than
   "devel"), then the next branch merges the master branch and the new
   development cycle is started in next.
 * ecsv/debian/batctl ecsv/debian/batmand
   Those are only backups. I already have backups in different places - so =
no
   need to store them again on open-mesh
 * ecsv/viking
   That was a private repository - nobody seems to have noticed it. I doubt
   that those maintainers will merge it soon and I will probably just send
   them the patches over ml instead of doing a pull request again.
 * ecsv/git-conversation-svn
   Project to convert the open-mesh svn to smaller git repositories. Seems =
to
   have worked, but is now useless
 * ecsv/hash_regression
   Just to show that the hash regression was actually a regression in Linus
   code. Funny but useless :)
 * ecsv/post-commit-daemon
   A daemon which started svn hooks at a later point. Those build scripts on
   open-mesh were gruel, but I think that we killed them. This makes the
   script useless for us
 * ecsv/wireshark-batman-adv ecsv/wireshark-batman
   Both dissectors are merged in wireshark... somewhat. At least parts of
   v12/13 are now supported and it was now noticed that the v14 patches can=
not
   be applied out of order... but I am full of hope that the patches will be
   enter the wireshark svn sometime in the future ("where no man has gone
   before..."). But is not necessary to have the plugins in an external
   module. It can't be build against an older version of wireshark and new
   version of wireshark can't load it due to the conflicting names.
 * ecsv/linux-merge
   Ok, this one is not really gone - it just can be found under
   marek/linux-merge. Maybe it will change the place again.

There are also some scripts which run on daily basis and are a little bit m=
ore=20
verbose.

 * /home/batman/linux-next-check/sync-git
   It downloads the linux-next tree, Linus tree and pushes parts of the
   changes to linux-merge.git - this should be quite silent. But the
   ./hooks/manual-hook in /home/batman/linux-next-check/linux-next.git/
   is triggered and sends mails about changes in net/batman-adv,
   Documentation/networking/batman-adv.txt,
   Documentation/ABI/testing/sysfs-class-net-batman-adv and
   Documentation/ABI/testing/sysfs-class-net-mesh to the unhappy person
   mentioned in /home/batman/linux-next-check/linux-next.git/config (curren=
tly
   Marek and Simon)
 * /home/batman/packet.h_check/check.sh
   This one just send the difference of packet.h in all branches in batctl=
=20
   and batman-adv to the responsible persons (see the TO=3D"..." at the=20
   beginning of the file)
 * /home/batman/build_test/checkstuff.sh
   This is more or less the build monster. It builds against kernel 2.6.21
   till 2.6.39. I know that it will not work directly against 3.0, but it is
   no big change to fix it. It uses sparse, checkpatch.pl from linux-next a=
nd
   the minimized kernel sources generated through make_all.sh (of course, t=
his
   one also doesn't know about 3.0)
   Marek and Simon will see the rcu warnings every morning till Andrew Mort=
on
   forward my rcu checkpatch patch or it appears through other channels in
   linux-next.

The rest should be explained on wiki pages, /srv/git/README or some private=
=20
mails.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-June/005020.html
[2] http://upload.wikimedia.org/wikipedia/en/8/8b/StatlerAndWaldorf.jpg

--nextPart5074535.lrt4yXDKY7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOAJjAAAoJEF2HCgfBJntG1NEP/0XM06+RN+DgiK60w40We1zh
b8EHeF//M3QwyVThlIYABroa1Gi8OAKAhSEIr1Kmds2x/aVSSWzNsP6jgNkR4ex9
z7vt2/jmETUFiy/t5YAiBcq3DsLCzPvt/cESwuBIhVQ24goCsR2WKzZVMixIRfs/
9YPXP5ITq6MlyO2L1eWQ225KNFAGihOf/Y3WWyFBccOFez2nQWIY/V79/gX7BWql
oHvlNOvAxRiIaIZBs4bgLrkrPn3TAJe1PwfwzdLhchvMeHazu7saJSDA+dQFD+jJ
LiGkJ+jvSRuERkNr0+ixqWsw7dNx6pVLyS8I4OTI0Pfv/4j8b3wfrqyKcnhBHuqa
DkBxij8hgmQCU9lgKTX44ofipotrsxZrebmWKQjl0qWFZ8q/tDgJCugE62qT/fQy
JMumEKwajDHAsYujmdx1f8EQlCFwFEdWeA0y9qaEWHbziVjkH1awaszZeIqW1nFi
Ck0kX8FU7Vv5dq/gp1RaUsc2i+a4zloCfbpjeXPWzTk2iysZPh+E00rtNrAfV8VH
FO/CTlqsgSkJq5IWqiq4Y4kKxD1FlWs71wzh1ZBmmMzAbAAx5EeK8Cv+mYbsedqk
QLvbEOLR7luQsj3ptuUg8PbOPz66Zb5mmuPlJlU4Uff0u3RVuCRY2EUMJDJKojFc
Nar+KNSxy/biB9AO7SVh
=BX8P
-----END PGP SIGNATURE-----

--nextPart5074535.lrt4yXDKY7--
