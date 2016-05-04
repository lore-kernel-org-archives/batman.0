Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 04 May 2016 09:06:04 +0200
Message-ID: <5243925.zzlkmNnEOT@bentobox>
In-Reply-To: <20160503182442.GA26706@lunn.ch>
References: <1462293026-24716-1-git-send-email-andrew@lunn.ch>
 <20160503182442.GA26706@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4630219.9SCC6cA8lE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: Use netlink to replace some of
	debugfs
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

--nextPart4630219.9SCC6cA8lE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 May 2016 20:24:42 Andrew Lunn wrote:
[...]
> Where is netlink.h missing?

The file is missing. Not the include. The includes fail because the file is 
not part of the patch.

Kind regards,
	Sven
--nextPart4630219.9SCC6cA8lE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKZ9cAAoJEF2HCgfBJntGQ80P/iRQR5LunBxzzSplCUbb6JoF
uSjXyqZxm5gyAc2NCX9BIBdio10nS+zIECHBDcZCpScJbvhIgHS5zZloPrWFqUTz
rnivXqPKpyHatUlp9n3WtMFxibFVy2ycogV2QVGlqaAesw2wL2CUp9ANB9AQFnTh
y/YTz2ECYEfbhSIKlyYAHpgWwfx+KjFHzZQLuoF7T2gQJGuUODAWY7F2VWm56UBH
SzH043Qlt8x+uovM4HKDIH500J3YlOZJ+D3rUaZWLhPI4lZC41jZYfrb4iEfQCq3
16hriNn66orKe0HJz0SQLzA5UKVUIeKFQfTNcydJxkMpCNvCWdaFklZ1yz2WoVEf
UcJmHbluY4j39LanlyDREi/MVdwtS5sNemOHHID5w2VGGubZZyqR2ceJg1cKwFg6
VrHpmFcXYj36BwfsBU7Q7gX2uF/uefOcjm7z9FYucYo6HmcZG5ew2PIrXV9VtO/R
YOlqpjdDxesrlmNrWw1F5hbcFZUujHgjWi22adEiJEQQ9g8Qcw9PvkhPrCjyTnDF
09iqaG1001bIw6Mslvm+CAu+VZg+2T4hJp9eoZ4jGC149Zgtr9i6IKTNKMjjlfnZ
z6chIP9QjgvNqAclQrBbH0ulhfRjSkU0w5NFdnXcswYu/yNPMiRbbSqHTx3N5+/V
lUPzSbrCsRaipsXRGJM/
=Q6Uu
-----END PGP SIGNATURE-----

--nextPart4630219.9SCC6cA8lE--

