Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 18:44:24 +0200
Message-ID: <2753685.SqMtrV7uXX@sven-edge>
In-Reply-To: <1463414932-1152-8-git-send-email-andrew@lunn.ch>
References: <1463414932-1152-1-git-send-email-andrew@lunn.ch>
 <1463414932-1152-8-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2223565.Ie4FGFiuDU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 07/11] batman-adv: add B.A.T.M.A.N. IV
	bat_{orig, neigh}_dump implementations
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

--nextPart2223565.Ie4FGFiuDU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 16 May 2016 18:08:48 Andrew Lunn wrote:
> +                       if (batadv_iv_ogm_neigh_dump_hardif(
> +                                   msg, portid, cb->nlh->nlmsg_seq,
> +                                   bat_priv, hard_iface, &idx)) {
> +                               i_hardif--;
> +                               break;
> +                       }

Alignment was not fixed.

Kind regards,
	Sven
--nextPart2223565.Ie4FGFiuDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOfjoAAoJEF2HCgfBJntGyV8P/39Mpw1QNofwUsYMOC6l9aLM
Mznjdl7Rt4cPtNzLU4fLTPMROT3Pk0oMQQyC8i+cVo5sDh+vAqc9ghsUh35VXGKF
euFWvwGhkIuZ1yH6Elc7PMfw9ah+cfi+P5Y01jnQmYQ8qjMDwY0E99bF7XahYfhw
pVNCFolvUlL2uEy/bLlI1PMHR0NNcjWQiGU+tjHHQxeZvD9IAITLRiL0qLCfopLd
4emaXHg0qA7lGNjBvcxzGNyUrpMOA4omJUm/rXXqi02YMMyYAsOsp1O5syLsj6qp
UbtUlmhioJgvqGJkiQIU+gPCLxymfSsjxenXx9am1q+1aJ/Qq1EwSQoxu9ebzDBw
jqz16HxCDiCyGm1FkZBhp6HXWXR+YxsuA+l2KD1l0P3p+G+qZ+EjtQr3eXZ8RRF0
4UXnrL1yTraRPZTpOYiTFDGRriaDd9HeeegXPhmdBhhj8bOtz96JQh5f/t/qBR9Z
CmTtw3roWGMWnF14ggTZhwyI9FaeerAbRrA61iz2y1IGE5qrE0x2J+/Qu8yYRrab
VjvAyG1ThXBmXEgdafjX7NVkbbf/+MmIKT1JA0PmaoGMEEudO4l0HLrHSVa6lbXu
Mt4YZgr+Tu0rKLtYiopAY84rVKi0OcBLebXumYGN+CvqbPykZLzPvVQgH8UMaiaD
3uQk3dOn1u8GRsPoYBMe
=Apuk
-----END PGP SIGNATURE-----

--nextPart2223565.Ie4FGFiuDU--

