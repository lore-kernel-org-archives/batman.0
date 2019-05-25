Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/3] batman-adv: allow broadcast packet type with unicast
 destination
Date: Sat, 25 May 2019 12:53:13 +0200
Message-ID: <3815968.0aduZrHPgI@sven-edge>
In-Reply-To: <20190514073859.2053-3-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
 <20190514073859.2053-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2243799.1lEaUpPoxr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2243799.1lEaUpPoxr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 14 May 2019 09:38:58 CEST Linus L=FCssing wrote:
> +
> +       /**
> +        * BATADV_ORIG_CAPA_HAS_BCAST_URCV: orig node is able to receive
> +        * batman-adv broadcast packets with a unicast ethernet frame
> +        * destination
> +        */
> +       BATADV_ORIG_CAPA_HAS_BCAST_URCV,
>  };

Here is a minor problem with the kerneldoc syntax:

    ./net/batman-adv/types.h:550: warning: Incorrect use of kernel-doc form=
at:          * BATADV_ORIG_CAPA_HAS_BCAST_URCV: orig node is able to receive
    ./net/batman-adv/types.h:555: warning: Enum value 'BATADV_ORIG_CAPA_HAS=
_BCAST_URCV' not described in enum 'batadv_orig_capabilities'

Kind regards,
	Sven
--nextPart2243799.1lEaUpPoxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpHpkACgkQXYcKB8Em
e0ZiNA//ZQ1XKgpCSaaaiQgsbCc3i4xZIgU65jABztlm3YYJTQY4NkyKTdszVOI3
dW+PIqMhKxSxezXEQIKoceH6PjyA0MTI5gvanaaH194o1a/z5TV3qFt2dudx+M6v
YCM8r1OufxNsJIMSL7GVUUmQCIfHmMn1X69Jl5s0sxDoxcN4+ErGPIETwPTRw6uK
iWiB6PJiItfad3I+M1D/3fzMZM95E6w0o6oBIZZgrP4HGug29haWimBzs+Zd4ECk
wtVVNyiuP+/jfIh8M/MD6nkb4iUONDMOn+5FgTu8RLiYXvWJIczCtc75alAc9HR/
6HDfcUk9QDUGKzzIyVDyW4QBFPvFAM60Sg6HM08fH3BGwmp1xLCqz5MtoZ28eskc
VWeRV/E65oPtXyYEddd5mOK3j1HOP6BxgK9kkTokJ00VVRmDyq11mcHG3FTaRajd
RffosVxrGw3z9vAWqEPIfd8wS3iNU9vv8JUt3mIKHklr8IdKJJLveNYPB/HwdXy5
qtPsN8j0fSRxOqguobY3fEidny3zCYiqjePEz+Ptg2pEgJ8n8puWVG5FttdIfTq3
NTTx7MYaFR5r+5MI8477KFgyqgJPrrVJP9c6N8Koi7IAN1l3DY7HZ+HclwMN9l5W
GJanrlLrzDpCouSDIODranSLf3db++rEDJCxJqI4DnT8b8jTsgA=
=2z1C
-----END PGP SIGNATURE-----

--nextPart2243799.1lEaUpPoxr--



