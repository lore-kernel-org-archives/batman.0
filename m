Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Oct 2009 19:37:25 +0200
References: <200910061328.04894.holger@layer-acht.org>
	<200910061355.49409.sven.eckelmann@gmx.de>
	<200910062127.42925.lindner_marek@yahoo.de>
In-Reply-To: <200910062127.42925.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1304334.eYggVrcPzc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910061937.28427.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Re: Debian extra modules
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1304334.eYggVrcPzc
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> That is a qood question. It is self-contained as well but I don't think it
> makes much sense bringing it into staging as it is just a "hack".  :)
> I'm not sure what the best path forward might be. Does it hurt keeping it
>  the way it is ?
Sry, doesn't want to upset you, but wanted to say that batgat isn't a compl=
ete=20
solution like batman-adv, but an extension to reduce the load on the gatewa=
y.=20
I don't think that it would hurt at the moment to leave it as it is. Have n=
ot=20
attended Linux Plumber Conf 2009 - so don't know what was discussed there. =
As=20
co-maintainer (Holger is the actual maintainer) of that package in Debian i=
t=20
doesn't hurt me at the moment.

> > Parts which are important:
> >  * TODO list for staging inside batman-adv folder
> >  * removed compat.h and remaining LINUX_VERSION_CODE (net_device_ops,
> >    unregister_chrdev)
> >  * clean Makefile and Kconfig
> >  * anyone who says how the further development should be done
> >  * anyone who sends the patch to Greg (probably Marek)
>=20
> I think most of the things listed here are already done. It just needs to
>  come together. I'm confident that this will happen soon.
I categorized them in my head under todo because nothing of it is currently=
=20
visible to the user. So some parts could be marked as "put them in the righ=
t=20
place".

[...]
> The postifx setup is quite simple at the moment: It rejects all unknown /
> unregistered mail. Greylisting is not in place yet. I quickly ran pflogsu=
mm
>  to give you an impression:
>=20
> Per-Day Traffic Summary
>     date          received  delivered   deferred    bounced     rejected
>     --------------------------------------------------------------------
>     Sep 27 2009       110        107        153         16       4874
>     Sep 28 2009       170        855        298         56       6894
>     Sep 29 2009       229       1235        379         90       6757
>     Sep 30 2009       176        525        420         38       7477
>     Oct  1 2009       187        222        377         20       7913
>     Oct  2 2009       132        132        414         17       8086
>     Oct  3 2009       112        117        374         18       7790
>     Oct  4 2009       128        658        294         42       6158
>     Oct  5 2009       243       1634        509         97       7657
>=20
> But I tend to agree with you: We might have to face the fact that we have
>  to improve the SPAM filter on our end and open the list. As a first step
>  we could install greylisting and have a bunch of moderators to see how
>  that goes.
Lets hope that greylisting would do a good job here as it is quite easy to=
=20
setup (just done that for exim using greylistd - so cannot say that it is a=
lso=20
that easy for postfix, but there is a package called postgrey). I never fee=
l=20
real happy about the filtering of spamassassines bayesian analysis as it ma=
rks=20
important mails for me as spam from time to time.

Best regards,
	Sven

--nextPart1304334.eYggVrcPzc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJKy4BVAAoJEF2HCgfBJntG4aYP/1xvUfwAOjBksGDsIvcajSRj
93cVFh/6QGMN7aS382UrbFzuVVI3e4IGYk6G+LxofXL9YP3Lp/Ib9fMnbtz7vb53
Nnzo292oKPXdvkUGVwgCrtYg4s/ZHq/8XJbI7+gpMSjMZ7Xm8VQ1f1ELT0mqCqiX
NcRODINhq7OZy+vRB3pBEq+gATny2skmubcMLAN5dfZTqDr3SeMJ1TbPRw3LU7MY
0MBJriqIfgww/+4FnsMePd35BbxMdjmrqVKSvi66p2Nu8/FzFHEBDX9b4LYb0KAY
hrn69pkKRFEl7u/J3Mh9fX4TPGQKQTOhSucxRH+9XncBCNmRLRm9NtwupiUVK6Yd
2cTADTmWCrLdyqIkdaRDadzqnUf1fg2RGrAcLmwejKPWqhonsm3sRxcJaijWpDqk
4/IhVmxBgePOa0giCCUE8WD9bfQij3hz9yMNK/bS4bAwhQXQqWPpd8M1+6XaXxOy
xCwnxmCIA97H6MHRS42PpClD7fFa+/bDitJgAiB3rrxoE0D7BQkualSHTXcDAJJG
SWj7ub+WCGSuQGLRtihLYNVbB1syFcv+fWqNaoiQ6t5AMS/Kqi8ph7geALlUj5rH
Ae3NhSq4oRNAScbWZdgi7WpB/0WFDOWGUBSmnlSur0u/S1Y8BdigoKWk2dB1JOv8
zuR07DI5/Bs/5ayyOqW5
=wZ7W
-----END PGP SIGNATURE-----

--nextPart1304334.eYggVrcPzc--
