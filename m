Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Fri, 07 May 2021 20:58:53 +0200
Message-ID: <62326514.53yIySlcTU@sven-l14>
In-Reply-To: <20210507171435.370648-1-asarmanow@gmail.com>
References: <20210507171435.370648-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1891496.0l7zDTGR7S"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Alexander Sarmanow <asarmanow@gmail.com>

 
--nextPart1891496.0l7zDTGR7S
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Fri, 07 May 2021 20:58:53 +0200
Message-ID: <62326514.53yIySlcTU@sven-l14>
In-Reply-To: <20210507171435.370648-1-asarmanow@gmail.com>
References: <20210507171435.370648-1-asarmanow@gmail.com>

On Friday, 7 May 2021 19:14:35 CEST Alexander Sarmanow wrote:
> According to part 1 of this patch following commands will be added to
> the JSON debug: meshinfo_json, originators_json, neighbors_json,
> translocal_json, transglobal_json.

I've asked you to split this up into helper code and one commit per command. 
And also add the documentation to the manpage and README.rst in each commit 
which adds/changes a command.

Why are you only printing selected attributes and not all?

Kind regards,
	Sven

--nextPart1891496.0l7zDTGR7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCVje0ACgkQXYcKB8Em
e0Yj5Q/9EWGKoh4MK2easOU1vdbzshG3MnfmdxabQ+M2pK2l8Jt1HLrXVnaHzicm
KXu6tNJNGPOlicFJWa47txAErUU2Wywv/5KJZoIsEMKIXNNrpFXzJHQaDPPPWgTS
ndCUoi7MOpcdjwoLsJ23Ya2agMq52Fo92JyVDOSfxGX9PtsIyZAg3z/amFxtIfm6
F8Vvel8ArcX4v8NBSc7pr4ybBdY1zHUDqNxdURCMweKGzafA3DyUfltwkp0FBqEc
tQpk/Ofjvp/cL8Qj+XGLleHnkDBApZ9wFwBk5MqU6KdAYxpz3c/HJcr96apYJYGP
JIiz5+5+oWgHGrYoJZyum6wRndu/9QfJOTLPj3GojG3nUAnpyW7n/Zn/OBK6I79l
WRF2eDmoFq7M9Tglt+YFN4q/9eoAiCQ7jiLGGRD+nF3nHKmeeFivf1uiYkcvLf1j
wvsb4aM2EVfSWYUBlvmKbNu/d13bmQh0ep6zRjBCBzVHzwp4j31sbwWL4JLuZvmN
qD7kn7lLqmFCKtDqwUnSnrh8RYTXG4ek7dhK/sgnt2Kn1w9aKMVu/nB+KlKA2bdQ
eL7i0QjcXpX7v+7CasyXtN6WKYz/anTvQitLGrU0Qn42eE3K/++sR/oWYzXJ96dR
pq0AyfJ0eKqCUsi0bR+NI8HhONlp1NUMZ8bryiPnZh0BHRS85M0=
=MaIK
-----END PGP SIGNATURE-----

--nextPart1891496.0l7zDTGR7S--


