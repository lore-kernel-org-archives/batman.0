Return-Path: <christof.schulze@gmx.net>
From: Christof Schulze <christof.schulze@gmx.net>
Date: Mon, 30 Jun 2014 00:41:04 +0200
Message-ID: <2867594.eVPB0e8mVU@lappi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7152642.nGf3rgOV3u";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] increasing BATADV_FRAG_MAX_FRAGMENTS
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, info@ffm.freifunk.net, "d. theisen" <d.theisen@gmx.net>


--nextPart7152642.nGf3rgOV3u
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hello world,

During an experiment it was found, that BATADV_FRAG_MAX_FRAGMENTS=3D16
allows ~72 clients to be connected to one single access point.

This parameter is defined in batman-adv/main.h [1]

What negative side-effects should I expect when doubling that value at
compile-time?

Christof

[1] http://lxr.free-electrons.com/source/net/batman-adv/main.h#L149
=2D-=20
()  ascii ribbon campaign - against html e-mail
/\  against proprietary attachments

--nextPart7152642.nGf3rgOV3u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlOwlgEACgkQpZfyPAmdZJnzaQCbB9a+/ytByubv73jNKEEczKOq
Ql4Anj/EsihrFUUS8EHyx7FdsdtUuYfh
=4QZT
-----END PGP SIGNATURE-----

--nextPart7152642.nGf3rgOV3u--

