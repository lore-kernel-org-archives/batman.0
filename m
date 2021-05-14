Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 1/2] batctl: main: Prepare DEBUGJSON command type
Date: Fri, 14 May 2021 14:20:21 +0200
Message-ID: <4531406.tM7hSj3uOr@sven-desktop>
In-Reply-To: <20210513141034.1649576-2-asarmanow@gmail.com>
References: <20210513141034.1649576-1-asarmanow@gmail.com> <20210513141034.1649576-2-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4026565.7da73Uhx7I"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Alexander Sarmanow <asarmanow@gmail.com>

 
--nextPart4026565.7da73Uhx7I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>
Subject: Re: [PATCH v3 1/2] batctl: main: Prepare DEBUGJSON command type
Date: Fri, 14 May 2021 14:20:21 +0200
Message-ID: <4531406.tM7hSj3uOr@sven-desktop>
In-Reply-To: <20210513141034.1649576-2-asarmanow@gmail.com>
References: <20210513141034.1649576-1-asarmanow@gmail.com> <20210513141034.1649576-2-asarmanow@gmail.com>

On Thursday, 13 May 2021 16:10:33 CEST Alexander Sarmanow wrote:
> The introduction of JSON debug commands requires a new command type.

You only added a DEBUGJSON for MIF. But you would also need one for HIF and VID

And then you will not only print the "debug" tables but just the netlink query answers. So it should be called differently

[...]
> +.br
> +.PP
> +.I \fBdebug JSONs:
> +.IP
> +The batman-adv kernel module comes with a variety of debug JSONs containing various information about the state of the mesh
> +seen by each individual node.

This makes no sense. The batman-adv kernel module doesn't come with debug JSON.

Kind regards,
	Sven
--nextPart4026565.7da73Uhx7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCeawUACgkQXYcKB8Em
e0b51Q//V4DwFfR90kZ8hTa/U00ZsoWh3EvgTb3GypFQaPB4ZxBhYv5OYZ8qZoar
T8f9y5vtHANf5x85IgePcNBjltpCSPmcrqcDlNPCHGQjZPOXoBnoHvr+XrZd4Sn1
aaZ8AhxRKpV6y1VoeWGWdS/lLpYeLhqtqvlyhTH9bui8lhiQ1m0b3yuXzbXWkCrE
dHTgkaOdigNZJFbmex3g8nK3tdFmtJgY4KKf0QDtR5YEDVuv9IHwsKp+4nP5AY3R
rH6fFgYn7qy99gr0w6rgJmrlkLAg9AQ+M1HEbnV91ddDY2eU8IAYsDZlh5+lgQwy
Bee5MhCqIssmShu2ejlvmm4Xjw0KWNoeiVtxrcMdgMSkd8TeT+z4b+UPlFRxHsFI
HAPhbG1noyfVaASBkWcfeVvZmUAJtBABixuL4yPNnw6MgcmN+6pDYPy+wLQtlaaG
XXPvTUZ+DncOEE/GULQ0KLpOJinIFZvryJJe95Yz0WGuxTtNYY3pMp6xWMkewCRv
YhWdnJJrPSJ7G+gCO6TeaPR45JNPy4LMcHIvpKMSOuH2yz8sGMgm8KdyO201GVbr
UKkP4i8qBwTy+NtOGPWNJp7rEHJTM4ZlzdGzzPmAMEEAFJInnQXvx0TlBUQ1Syxf
EDCZo6TVVpEx9p7gHzRrCgafYS3PiJFVGZjkyD0QzLxahT642qE=
=inLc
-----END PGP SIGNATURE-----

--nextPart4026565.7da73Uhx7I--


