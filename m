Return-Path: <a@unstable.cc>
Date: Mon, 3 Jul 2017 12:08:01 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20170703040801.GD27857@prodigo.unstable.cc>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
 <3606832.Ug1eaxX1Ot@lafayette> <20170701173456.GB13650@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <20170701173456.GB13650@otheros>
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


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 01, 2017 at 07:34:56PM +0200, Linus L=FCssing wrote:
> On Sat, Jul 01, 2017 at 11:34:37PM +0800, Marek Lindner wrote:
> > On Friday, June 23, 2017 5:48:26 PM HKT Linus L=FCssing wrote:
> > > @@ -1946,6 +1977,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *=
msg,
> > > u32 portid, u32 seq, struct batadv_tt_orig_list_entry *orig, bool bes=
t)
> > >  {
> > > +       u16 flags =3D (common->flags & (~BATADV_TT_SYNC_MASK)) | orig=
->flags;
> >=20
> > Why do we need to output the combined global (partially masked) and the=
 flags=20
> > propagated by originator ? Shouldn't writing orig->flags be what we wan=
t ?
>=20
> With this patch orig->flags only stores the TT SYNC bits.
> Everything other flag in there is always 0. So printing just orig->flags
> would only display the isolation and wireless flag and would omit
> the roaming and temporary flag.
>=20
> Compare with:
>=20
> @@ -1723,7 +1753,8 @@ static bool batadv_tt_global_add(struct batadv_priv=
 *bat_priv,
>         }
>  add_orig_entry:
>         /* add the new orig_entry (if needed) or update it */
> -       batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn);
> +       batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn,
> +                                       flags & BATADV_TT_SYNC_MASK);

Linus,

each originator announces flags covered by BATADV_TT_REMOTE_MASK (0x00FF),
however you are extracting only those covered by BATADV_TT_SYNC_MASK (0x00F=
0).

Am I wrong or this is preventing the other 4 REMOTE flags (0x000F) to be se=
t in
tt_global_entry->common->flags (because you always filter them out when upd=
ating
the entry)?


Cheers,


--=20
Antonio Quartulli

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllZwx4ACgkQ0+HICM1s
oFCLrA/9EaKQdEy/uWEtrpUSDt6WsPOkWThzeGQ66PjnBen7gLMStHRNJGeAqZu/
X/IUO2kT74Ee1NtipzoUsmxgb9T5USP48uOy5+MdRD/k3R667yoCrs1SdtWALLDI
E0U9Zwl4odeuSIj+J31AiSTcpMK//4/qRxtwJJ5227+rVj0rn7BSWGFEyRb0jj5r
pFU2ZhJQ2HrM1IRz/GTI+vOc41JGJmjjgiCkh1afh6xEpVIv6ujeFl/9Vh2tD5hu
gd//OZo/I6SXMK1Ft3QB7kWtIeHM4gN8x+vsrnFneYHSbW2ty75c/Dv0sz2M/4Do
5OaBPFH+SmDskEawBOLEC3+svlJ41KjUwuZCFclWoWyBF+OiDtEZAAGBtLDlyxho
wbLX1nJdV6sEWDpDpPk5ixqT1xcxTT8WWQ/8HXDQLovf2fGNNGPem6nOZlmKPbM4
UeTRrqE46U42xYLpcCnJJoPiuoBQKm1b52HaHdPy+FkbCaQgPaz4Gm0Ua0I8wzaJ
JsMWmxYsmTIsiV+OSOdKvZFCa8eO5aR/xwQxwRntvN8XeW+gWzijlX0fmFFsvKe1
EtI5LtjaaiAZFAgLzLyP1DyIZjCYGp6pFPd7+Rv7u5xfvZsd22BsXSkxybTYhYX/
SIwq6OlDoEiEwA54C5710SbHF3Hn3MpsJnviwXLX3XVYeehPpMQ=
=zsh+
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
