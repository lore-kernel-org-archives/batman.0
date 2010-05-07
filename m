Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 7 May 2010 12:48:16 +0200
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005062344.57242.sven.eckelmann@gmx.de>
	<201005071114.30601.lindner_marek@yahoo.de>
In-Reply-To: <201005071114.30601.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4223839.tZmNB2YxVF";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005071248.56290.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] staging:batman-adv
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4223839.tZmNB2YxVF
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Friday 07 May 2010 05:44:06 Sven Eckelmann wrote:
> > Am I the only one who thinks that Marek takes credits for too many
> > patches? Yes, we all have to praise him for his work, but just noticed
> > those minor
> >=20
> > glitches:
> >  * fix whitespace style issues
> > =20
> >    - work from Luis de Bethencourt <luisbg@ubuntu.com>
> > =20
> >  * Fix whitespace problems criticized by
> > =20
> >    Reduce max characters on a line to 80
> >    - work from me... somewhat
> >=20
> > Not that I really want credit for those patches (maybe I should have
> > submitted them under a different name.....), but that didn't happen in
> > the past and now more than one time in a row. What happened here?
> > git-am's fault?
>=20
> It seems there are a couple of patches wrong but I don't know how this
> initial credit list gets created. I had the impression the first
> "Signed-off-by" is the owner of a patch ?

Ok, there seems to be a problem misunderstanding in what our "infrastructur=
e"=20
does. Let's see what svn does:
 * svn does not have a field to store the complex information
   "Full Name <email@address>" for committer and author
 * svn stores the username of the committer

So we get a commit in svn it must get somehow to our repository. We have a=
=20
"translation and synchronisation" repository hidden in a private directory.=
 We=20
use git-svn there to fetch our data from svn and then push it to our public=
=20
git repository into the master branch.

If you look at a specific commit using something like
`git cat-file -p v0.2-59-g23a0a47` then you will see the committer and auth=
or=20
information which is part of the metadata of a git commit and not really pa=
rt=20
of the actual commit message. An example would be:

tree 359ee2bfbc9ad702b9f6ef1649833793090244fe
parent 0024f65f2c6cc1765bc7034cf82b9dc2b7626630
author Daniel Seither <post@tiwoc.de> 1266335052 +0000
committer Marek Lindner <lindner_marek@yahoo.de> 1266335052 +0000
=2E...

author is obviously the author of a patch/change. This is something which=20
should not be changed by the person who applies the patch. Thereof we have=
=20
also the committer part which shows who has applied the patch. The committe=
r=20
information is changed in many situations. A common one would be that someo=
ne=20
cherry picks a patch from master to maint. In other words: we have enough=20
information to thank the person for their contribution and to blame the per=
son=20
who applied in on the wrong branch. :)

So where do we get that information svn only stores the committer username?=
=20
git-svn uses different information to gather such data. The first one is th=
e a=20
translation table statically defined by us. We use it to translate the svn=
=20
committer to a something like "Marek Lindner <lindner_marek@yahoo.de>" in t=
he=20
git committer field. We still have the problem that the author isn't stored=
=20
inside the svn commit... normally.

We defined that all commits in trunk/batman-adv-kernelland must have a vali=
d=20
'Signed-off-by: ' line and must be submitted by an eligible committer (Simo=
n=20
or Marek). git-svn can now extract the first Signed-off-by-line to get the=
=20
actual author information from a (special) svn commit..... Problem solved f=
or=20
svn to git translation.

So what does git-commit do here? Nothing real exciting. When a new commit i=
s=20
created (and not otherwise specified) then both author and committer fields=
=20
get the same information fetched from ~/.gitconfig or an other configuratio=
n=20
file. When we change a commit then only the committer field is updated.

So we have nothing like signed-off-by parsing in git-commit. There are some=
=20
"tricks" described in the git-commit-tree manpage to supply such informatio=
n=20
directly - but that is nothing you really want to do for each patch.

The way patches get applied are using git-am. This program use(s|d?)=20
internally git-mailinfo to extract important information from the patch. Le=
ts=20
use
"[PATCH 21/26] staging:batman-adv: kfree_skb() in interface_tx() in error =
=20
case" for further explanations. We would normally just save that as file or=
 in=20
a mbox. Now just use `git am FILENAME` and everything should be parsed and=
=20
committed. If not than you can try `git am -3 FILENAME` to try a 3-way merg=
e -=20
if it still not work than maybe it is the best idea to inform the patch aut=
hor=20
that he should resubmit the patch.

So what information is now extract? Lets call git-mailinfo with patch21.mbo=
x=20
(the patch mentioned above saved as mbox file).

git mailinfo msg patch < patch21.mbox > info

We have 3 new files. "msg" is the commit message, "patch" is a patch which =
can=20
be applied using a normal patch program or git-apply and "info" - which is =
the=20
extracted info we are interested in.

Author: Simon Wunderlich
Email: siwu@hrz.tu-chemnitz.de
Subject: staging:batman-adv: kfree_skb() in interface_tx() in error case
Date: Thu, 6 May 2010 22:18:47 +0200

mailinfo has now the possibility to extract the From: line in the mail head=
er=20
=2D this is the usual way. But Andrew submitted the patch instead of Simon.=
=20
Thereof there is a second way to extract that information - the first 'From=
: '=20
line in the mail body. git-format-patch added this line because Andrew was =
not=20
the author of the patch and git-mailinfo will strip this line again from th=
e=20
commit message.

We can see that the Signed-off-by line is not used at all in git-am or git-
commit and that we must tools like git-am to get the correct author field i=
n a=20
commit when applying a patch. If you apply your patch with another tool tha=
n=20
you must use git-commit differently (not explained here because I don't wan=
t=20
to encourage people to it). So even if the Signed-off-by thing is more a=20
social thing (read linux-2.6/Documentation/SubmittingPatches), it is still=
=20
used in different scripts to find out who is responsible for a specific par=
t=20
of the kernel or similar things. We only use it here when getting patches f=
rom=20
svn to translate them into git commits.

This "credit" list you saw here is more or less the thing you get when runn=
ing=20
git-shortlog. It just gathers the commits of all authors and shows a summar=
y=20
commit list for each author. "author" means here the author mentioned in th=
e=20
author field of the git commit. So it is not Andrews fault, but the committ=
er=20
has done something different than the above mentioned steps to get the comm=
it=20
applied in maint.

Best regards,
	Sven

--nextPart4223839.tZmNB2YxVF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL4+/wAAoJEF2HCgfBJntG/Z4P/A+By3qSbk58n1Jd4pcjZgV5
JEb3eWACuroK0W34bR1opfWEIr46vxxYclybXk9dhRs5QCd1fZEOzcHc25fU5vWx
uQoCxVWcTI4FUGfqKAknwM9Aq1Jf3RWHSHkOlXptXYWCsUTjmlgyftCOA082KKOP
coCX7UeTeFYfoZbEuSvR0RjUsqxygOHgA/XymXBUFGgE8os7B95obkfLVeTbdVlO
hNhDiK2otDgkOlKcQSa8Og1frK7KaMJJRbH1onbpmleb1XLWMIafoUelMK04BfMK
l0+TdxV812d3SczYfDlT0+uenxu98YgKTAVGMGGOGF6argxUSpnh3tiSM8HrgEhV
p0dqCy/vz68ghZcz3nnIGTA4/d+pekyDr6UoSL3N6yYUxgHm1AqSAlflA27XL6X2
R/4dvqlUSa2vidtyiHBS6Qk6/p4NpnJILjbHCZWkuwYhdwn70yNf53Np5h8bCuJw
wKD7oaYlRNwkzDCEklNYW1OgNohZJlz2PVbwxpJgIHmLWPPZXnHYze1pyTj9f85O
j/gCB1zz5YPtsALGPGZMC3mc9HgT6cP51n92ITe/2yNJIEpA3PqxCdV15f0u8I7D
q5hShH0E0QG80j1aC5dk4ahZlfG5m8FGokDs3De4f3DpmhEwJhwWb1iRGzPR4fck
EpmtegY2kXBCzgOslSN3
=vlVP
-----END PGP SIGNATURE-----

--nextPart4223839.tZmNB2YxVF--
