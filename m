Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 01 Jul 2017 23:34:37 +0800
Message-ID: <3606832.Ug1eaxX1Ot@lafayette>
In-Reply-To: <20170623154826.7792-1-linus.luessing@c0d3.blue>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart35709541.tFLr3jMBsv";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT sync flag
 inconsistencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart35709541.tFLr3jMBsv
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, June 23, 2017 5:48:26 PM HKT Linus L=FCssing wrote:
> @@ -1946,6 +1977,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg,
> u32 portid, u32 seq, struct batadv_tt_orig_list_entry *orig, bool best)
>  {
> +       u16 flags =3D (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->fl=
ags;

Why do we need to output the combined global (partially masked) and the fla=
gs=20
propagated by originator ? Shouldn't writing orig->flags be what we want ?

Cheers,
Marek

--nextPart35709541.tFLr3jMBsv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAllXwQ0ACgkQU1VOj+62
HMD+nAf/X/Y+8r4lJcqZkWVITT3UPsqKD1f8w4fPzkoSWkbB9Bxua+pXbuJp6PqK
x0O4maYh/ju4RPfdOZoaNZeTlXxGsru24DmbA+HDVzrf0Mb/70ir6WgbcgA7lEwI
CSsOyyzAxxHjR0WOxbrFGY6JAyKdnX2DfWV8Zk5Ix3W33U0NzMnrgCa/2XNAGbRL
kosoHUHJcEesb/vY9TYtUbyVKq5wmTeXoAD4ovsl+evAq+7BgkKwdzcYfrtuLF+9
R2pEbsUymlHBjdROeVaQz6WSUB7snrm7x+flzSUXixcj76SUOPnTdNdyynT6hASZ
iPH4xxPH4mel9XneENPGMWlCPyFg+g==
=JeeC
-----END PGP SIGNATURE-----

--nextPart35709541.tFLr3jMBsv--

