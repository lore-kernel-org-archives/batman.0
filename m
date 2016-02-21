Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Feb 2016 16:39:22 +0100
Message-ID: <23488110.8Oiix784PY@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2215995.WfTHLC1UMt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Patchwork on open-mesh.org
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2215995.WfTHLC1UMt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I've used my free time in the last week to look over the 5246 patches which 
were sent to the B.A.T.M.A.N. mailing list. These patches were categorized as

 * Accepted:
   committed to the respective repository at git.open-mesh.org
 * Rejected:
   Either rejected by the Maintainer(s) or withdrawn by the Author because
   they turned out to be a bad idea
 * RFC
   patches which were just posted to get comments
 * Not applicable
   patches which were not really for a repository at git.open-mesh.org
   (for example patches which are forwarded to net-next.git/net.git)
 * Changes requested
   Patch had flaws but these could be fixed but the author of the patch hasn't
   sent a new version of the patch
 * Superseded
   New version of the patch(set) was sent which makes the old version obsolete

The result can now be found at https://patchwork.open-mesh.org/

You may wonder why are there patches with the state "New" + "Delegate" set to 
some person. These are the patches which have not yet been applied in their 
respective repository at git.open-mesh.org, not yet rejected and not yet 
replaced by a different patch. Ok, these are most likely not all still waiting 
to be applied but I just didn't know their state and thus the maintainer(s) 
have to look over the remaining patches and change their state. Until then, 
these are added to the TODO list of the maintainer [1].

Patchwork is currently configured to read the mails which are sent to 
b.a.t.m.a.n@lists.open-mesh.org and add each patch + its comments to the 
patchwork database. Maintainers can then update their state, download the 
patches and bundle them (which then can be downloaded again). A heuristic was 
installed in the post-receive hook that tries to find the correct commit for a 
newly applied patch in the master branch and automatically mark them as 
Accepted.

The author of an patch will be automatically informed about changes to the 
state of his patch.

I have already started to assign the patches with the state "New" to the 
maintainers. This is also the reason why Marek, Simon and Elektra will not be 
able to create their own account and instead will receive a mail from me with 
their account data.

But also other people can help here. They can register to set the state of 
their own patches. This is for example helpful when they've just submitted a 
new patchset and want to mark the old patchset as superseded. But they can of 
course also disable the notification mails.

I hope this helps to better keep track on the incoming patches and make it 
harder to forget one.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/user/todo/
--nextPart2215995.WfTHLC1UMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWydoqAAoJEF2HCgfBJntGH3wP/jDMQIpOdKcKa4A8oC+MMkJQ
0/uGUojBC/ryUwNN6pEt0QPzYCipRD/8ISozxdB+nLk7UPOF7lWR/dm1jyduS2yf
5P1zkm23el81cKQZvjPo3UcDEF5V7x96rQbUlDy4ofxK/sdyR4dnKGriYuKEjgtk
6PtPgz7ibMJAQykdU/8/ArXYSRUOZSED9te1Rbbj3o1i3dnHV4lDW1btZGvpLPs6
oEAQDG1ZJbutCkpCy7BArTlZlLZQmDASyWHTlP5XA+249qUl+D+DP6PqR5wP1Xmq
i9YZN3x5+T77fmArvuooBfNxhtfv1W+veIuug35JAkJd+QQVo/lWCf0ANil5FRjF
hBQwjcpFNpkE8dW7f4Qcp1Hic0QhvUP01Ftm4l6f29tnWD5KIh8xGxlTrtPxspdY
aVcX2Z12sFl88tWfHxEmG1rO0Q3Qn8fNEBSok59iE7EiJpoZBcVYZ6u92fy6A7c3
wH/i1RYOc2fDgmrJ4QNXE1Vrh44APsW4qqaEizin+rt5gJD8W+kdvrRP8zH7eaYz
mS/QIB6qVIwOXrHKSlihM4v79+ISnzDgF3b1UH4e7/JnbgBBFWJniYPMsKOTkHqX
1HLmsZGpwWoGr2eCA/4oJju0V4FjrG4txS34+gycnU73XsOwYT1pvoY/clYD4bEe
Hl+znwqDlop3JDM9y1mm
=4KIx
-----END PGP SIGNATURE-----

--nextPart2215995.WfTHLC1UMt--

