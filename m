Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 Jan 2017 09:41:28 +0100
Message-ID: <6116302.bmDiC2Wi5O@sven-edge>
In-Reply-To: <20170129043943.11341-5-linus.luessing@c0d3.blue>
References: <20170129043943.11341-1-linus.luessing@c0d3.blue>
 <20170129043943.11341-5-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1619022.mHjZR2AazG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 4/4] batman-adv: Evaluate and use
	neighborhood hash TVLV
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

--nextPart1619022.mHjZR2AazG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 29. Januar 2017 05:39:43 CET Linus L=FCssing wrote:
> +       bool (*hardif_no_broadcast)
> +                 (struct batadv_hard_iface *if_outgoing,
> +                  struct batadv_hardif_neigh_node *hardif_neigh,
> +                  bool inverse_metric);

What about shortening it: https://git.open-mesh.org/batman-adv.git/blobdiff=
/0d0d03e14ca5e700e5c2e1f9cf7a3dce4dd1acc2..4311f0f294c539ce698f2c87f8b191ac=
f4184442:/net/batman-adv/types.h

Kind regards,
	Sven

--nextPart1619022.mHjZR2AazG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliNqrgACgkQXYcKB8Em
e0Y3xQ//dOfDOvvVMs4ehuSe1ouXlGK9BcN1xbPRuFht8kdZlrYFMSgP+ecXL76n
9RPT6Us3QSUeX4qVtYW+0xKVE6EAYN5PqJ5DwJtMEa00O3GzR2QFb+gZj8q1jaF5
2+4+CtDYK7W0FSG0q/kn22qQNyRzWZMEqc8i2vs+moJ5lFrKpQkdim70jeM+PJd0
wQ3+FmjGieRCms8zTdail6kflzVtXf0K5KjkI3GyIQepsd/gu6WOnJBbDkkZt2sT
l9ixaBMoVmSwpqqTOfNAn2OJwA+8KZCyMxMw26o4Uw2bvFvi/BVxZeUqBP9Xbfjd
efaBtoVDuAEu8llbSATvwobXjKcno0+JDpVw8oAxG0wbUxKsq1TFdhqr7zdBaI11
V7FYG2PE+V9XzMkAYAIXPtugFyF79YyUO3ClPNVBGCQXi8nf/U/EdRecqu0Zyxy/
8B7Yp23AsN871OhOlCqM6im8KSGalo2V/4aoFumQAJNz6Y9LjQ94YvPzdiUWF94w
KXhvTpS1F48O8hE5MM3yzdfEp6+83+O4oRUBz4ZfSx7nxKQ+RNckzJeXGrM50XYe
EMr4UaRrfgsXTTBSeBncf6WRHa9EXJbR4qfjIGcwzc7nVhKOThFTqwGPcXVGg0n1
+8/3u6KrKEEKKm7I8YGk72s93zSGh9Qk1skGIFgCDFa/mpu30jY=
=6Tfj
-----END PGP SIGNATURE-----

--nextPart1619022.mHjZR2AazG--

