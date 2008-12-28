From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Split SOURCE_VERSION in RELEASE- AND
	EXTRA_VERSION
Date: Sun, 28 Dec 2008 17:30:43 +0100
References: <1230469532-24319-1-git-send-email-sven.eckelmann@gmx.de>
	<200812281525.01252.lindner_marek@yahoo.de>
In-Reply-To: <200812281525.01252.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2185701.IFAzW1bfba";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200812281730.53628.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart2185701.IFAzW1bfba
Content-Type: multipart/alternative; boundary="Boundary-00=_0m6VJYSYjt4NxIf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_0m6VJYSYjt4NxIf
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable

On Sunday 28 December 2008 15:24:57 Marek Lindner wrote:
> Hello Sven,
>
> > Afterwards the development branch should change the RELEASE_VERSION to
> > the upcoming version number and the EXTRA_VERSION to a string which
> > informs the user that it is "unstable" and in development. This could be
> > for example "-dev", "-pre-alpha", "-beta" or "-rc1".
>
> I like your patch a lot. It could solve a nasty little problem that always
> tends to be forgotten.  :-)
Yes, Simon told me about that :D

> Unfortunately, our compile farm which feeds the package repository extrac=
ts
> the SOURCE_VERSION from batman.h to generate the package name. Unless we
> rewrite the compile scripts to extract both defines we can't apply your
> patch as-is. This rewrite is not as painless as it could be. Certainly, at
> some point we want to touch the scripts to optimize the speed but that
> wasn't on our agenda right now.
Didn't know that but that makes patch of course useless. I liked the idea t=
o=20
have a version which marks the next release and the extra part which marks =
the=20
actual status of the next release. This is only one way to express this.

> Do you see alternatives which allow us to reuse the existing compile farm
> and have the functionality you implemented ?
We could also assume that the version string has a specific format. A versi=
on=20
number (RELEASE_VERSION part thing in my last patch) which has a postfix=20
seperated by a dash. If that dash is found in the version string then we ha=
ve=20
a postfix and we are currently in a unstable version.

Don't know if this makes really sense for B.A.T.M.A.N. but the patch for th=
at=20
is trivial.

Best regards,
	Sven Eckelmann

--Boundary-00=_0m6VJYSYjt4NxIf
Content-Type: text/html;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'DejaVu Sans Mono'; font-size:9pt; font-weight:400; font-style:normal;">On Sunday 28 December 2008 15:24:57 Marek Lindner wrote:<br>
&gt; Hello Sven,<br>
&gt;<br>
&gt; &gt; Afterwards the development branch should change the RELEASE_VERSION to<br>
&gt; &gt; the upcoming version number and the EXTRA_VERSION to a string which<br>
&gt; &gt; informs the user that it is "unstable" and in development. This could be<br>
&gt; &gt; for example "-dev", "-pre-alpha", "-beta" or "-rc1".<br>
&gt;<br>
&gt; I like your patch a lot. It could solve a nasty little problem that always<br>
&gt; tends to be forgotten.  :-)<br>
Yes, Simon told me about that :D<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>&gt; Unfortunately, our compile farm which feeds the package repository extracts<br>
&gt; the SOURCE_VERSION from batman.h to generate the package name. Unless we<br>
&gt; rewrite the compile scripts to extract both defines we can't apply your<br>
&gt; patch as-is. This rewrite is not as painless as it could be. Certainly, at<br>
&gt; some point we want to touch the scripts to optimize the speed but that<br>
&gt; wasn't on our agenda right now.<br>
Didn't know that but that makes patch of course useless. I liked the idea to have a version which marks the next release and the extra part which marks the actual status of the next release. This is only one way to express this.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>&gt; Do you see alternatives which allow us to reuse the existing compile farm<br>
&gt; and have the functionality you implemented ?<br>
We could also assume that the version string has a specific format. A version number (RELEASE_VERSION part thing in my last patch) which has a postfix seperated by a dash. If that dash is found in the version string then we have a postfix and we are currently in a unstable version.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Don't know if this makes really sense for B.A.T.M.A.N. but the patch for that is trivial.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Best regards,<br>
	Sven Eckelmann</p></body></html>
--Boundary-00=_0m6VJYSYjt4NxIf--

--nextPart2185701.IFAzW1bfba
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklXqbQACgkQqQGwKVlMoDsVfgCfWqPtQ4PjtISTNIMQqwDaUscJ
rl8An2ZNpWMxTYtS76xPv141eIX3qfDw
=FXQ9
-----END PGP SIGNATURE-----

--nextPart2185701.IFAzW1bfba--
