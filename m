Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 18:41:58 +0200
Message-ID: <1538491.4gjieC19D2@sven-edge>
In-Reply-To: <1463414932-1152-11-git-send-email-andrew@lunn.ch>
References: <1463414932-1152-1-git-send-email-andrew@lunn.ch>
 <1463414932-1152-11-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart69689421.Q9LhpXqADO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 10/11] batman-adv: add B.A.T.M.A.N.
	Dump BLA claims via netlink
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

--nextPart69689421.Q9LhpXqADO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 18:08:51 Andrew Lunn wrote:
> @@ -143,6 +153,7 @@ enum batadv_nl_commands {
>         BATADV_CMD_GET_ORIGINATORS,
>         BATADV_CMD_GET_NEIGHBORS,
>         BATADV_CMD_GET_GATEWAYS,
> +       BATADV_CMD_GET_BLA_CLAIM,
>         /* add new commands above here */
>         __BATADV_CMD_AFTER_LAST,
>         BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1

Kerneldoc missing. The TODO line was just removed from the patch but no line 
describing the cmd was added.

Kind regards,
        Sven
--nextPart69689421.Q9LhpXqADO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOfhWAAoJEF2HCgfBJntGr0MQALdSpz0ccXApEoPWnag0BO3u
boTK9P8pb20zcT/AFHy+cFGjGNx+v16Yj5uNSlknZXNGyOwXYQ5a0cnsy3HPu/M+
PPqLWKcFtTOXew1P9X2951cFuzZKIEh1D1fsLp+O/fkr+H4PX/jbajY7N6BV6PSo
PD8k9Yx0rdZpP/BLpjLb5cKqw4zLeFAyioVLQHDSj2Fko52XHB5JEWXoFmWqA0+g
P/Ew6ATcaGXFJ7onq+kOzWUY6002uuACVNQtrLUUDZykUupd/+dQfFMcDAUs8/Y+
aLUbdTTUXJksE6WjSaFtTya18kZAS2k2+tFBLWt9+Oy0chJItbQwHW2sm2+5UX8r
tSSOTGGshMcViv6S20cOZGg6G3KBPDnoXTsr2rmvqJDinxz/N9lBKWsx8NkNpybT
qYzEQY9OnjzWx+nQNGaSBR4wV6uowJ9Pzxb+ACfHoYd1zpoizzm4zko+AigsW4bI
6vmmprPgI5g0wBcef4tF6WrlJvasMtMV2cnWBcJxkrm8a4x0WoApqQCAvYNi8uiT
+iE4+4I1CiHz2sx1Xp3ZW8jMoRPobwzUpAuArgKPpoYCEQVqrd67JfCN4cVz3Igq
SdVlz1RpS9TTzOdZoIh2TjeiG1jp4Rlc/7mm2aQ3Fx6DuaGooW8ZYpPe4SIxiW9d
dRIAspP5quYuyGnhSI8u
=Gf8c
-----END PGP SIGNATURE-----

--nextPart69689421.Q9LhpXqADO--

