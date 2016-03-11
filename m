Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Mar 2016 14:48:48 +0100
Message-ID: <1539981.Mf4IRzjGc5@prime>
In-Reply-To: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6258559.ut2ZC54A0e";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] alfred: vis: Use debugfs_make_path
	helper
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart6258559.ut2ZC54A0e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 28 January 2016 04:53:13 Andrew Lunn wrote:
> By using the helper, knowledge of network namespaces can be kept to
> within the helper.

I've applied this one, since its a good change even without the namespace 
changes.

Applied in revision dca3ebf

Thanks!
      Simon
--nextPart6258559.ut2ZC54A0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4szAAAoJEKEr45hCkp6hP4YQANKQDwuFgS5dpHUuNnQD7sHg
/HVXNq+amMDcS2W9Qn+W1qSnEl1SBTLJTWW/nEVX+iEAQdmnAhNwV/DrbHjNsSJu
vMykYsPY3XGEX70ohLIrWWBYIsTGnVlW5FkDet3RjXryw6jjFINZpCQPt4df3tgU
7fcwEBwSgcQZ5npeoNvYP5aYPae3dOHp+O6KYooE2KLMN7Z3yiGBirYjyYhWzwLL
hY4TXS1ggQM46oaIc9UbdMreuLSd1xI489i4dW+Tw/LsVgbkMInueKEiwNvJMOHg
9JVga5b4oaLZRDNHX4NNmAAEzhsyx3VstIxrvDp+1XGhO/Rz8JJGYk+/nX6gZg5a
MPhiS1vMZMhuyjndRD26v/Ry/DE4Vv7uJKlMnJsVWr/QwystQSH7dTgHIWQiYaOX
wsYwCeUW0UWXcBe1fEJjDoFIOrpM8uj4jaWGMNq/l30ROSXVl4/5ohSq4aIknzDj
AsXJyqWb/Z8DMU8RYLB3bQ1ycvQV3+ixv6k7sVxaVvIr81iYHNPfG5ZayyRahNxv
A+8oc4cn+Ck9RK5z0GrpG06IUMpUEKmCsIbSwU9wXzpyEktFvnsRYRM4uOPvex/+
BBvRObogwHjY/XlAzFhTN/2euON46X/6tDIcj2DF2SxeUlvhhSWlAKzrB8a2jUV0
kFFEvzNVxU8fdKoJO4c1
=B3Kf
-----END PGP SIGNATURE-----

--nextPart6258559.ut2ZC54A0e--

