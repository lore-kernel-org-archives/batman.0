Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Dec 2010 10:01:43 +0100
References: <20101218233342.GC30203@ritirata.org>
In-Reply-To: <20101218233342.GC30203@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1924490.Qjde18uPMG";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012201001.45712.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Modifing
	hna_local_fill_buffer() return value
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1924490.Qjde18uPMG
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> After changeset 1888, the return value of hna_local_fill_buffer() has
> not been changed to _count_. In this way an eroneous num_hna was
> calculated before sending the new OGM packet.
>=20
> Signed-off-by: Antonio Quartulli <ordex@ritirata.org>
> ---
>  translation-table.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index a19e16c..a633b5a 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -162,7 +162,7 @@ int hna_local_fill_buffer(struct bat_priv *bat_priv,
>                 atomic_set(&bat_priv->hna_local_changed, 0);
>=20
>         spin_unlock_bh(&bat_priv->hna_lhash_lock);
> -       return i;
> +       return count;
>  }
>=20
>  int hna_local_seq_print_text(struct seq_file *seq, void *offset)

Your mail program mangled the patch. Please use git-send-mail or check how =
to=20
fix your mailing program (see for example Documentation/email-clients.txt=20
inside the linux tree).

Also correct your DNS entries for DKIM (you seem to sign your mails with it=
) -=20
they aren't available and every DKIM aware receiving server will not accept=
=20
the mails without adsp._domainkey. and mail._domainkey. TXT DNS entries.

Best regards,
	Sven

--nextPart1924490.Qjde18uPMG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNDxt4AAoJEF2HCgfBJntGn3oP/itQ+sVKLhu+tGjSzUnqVvnb
efNlcpsup9+KB1rsfJUZzfqxCKkTArYUck1YTxvEUtDGeI+KXW9oBPGc+/SVBbZf
zAvJBMUUjBIkbcmhtNMRTRKhRQpaeDdz8jKWSLuLSpFYpNwdXNBVCzFnbOETtyvQ
SnOUoa+pRdnqn5LWf1dme5BQVrSpRaF6qAWI6ZPm15+7pyYB3wFarwd4Kg7Ub8PP
JsyFxcgtoGucdCyFlcBaSPCr3JbW48L5pkEXKVqm7pYa1yUaSeXPSSBbPSdoK/Ey
lE/po9ZEf0qylyCXZ7cfj7B22Rs+cwTMdle+FOOLF12pOwfpXibaBRLA5xd1wiPa
i6Ca0XkhRZf8cnfPVoZIr4AUuFo9SSbVkVLpfZa52DBwaNCvItY2UEQ9Dv6Jek2c
bMLjAnUYj4VixKgfjk5P+ZUtpmf9ffbBqgRlVmw+S7O4zpOVZ7ByfmA0pvXuGpTp
PJxhj350wgQnwRf8W1gwGMM7d8isDlvwyZb/kqn8b2GcBDF6dmqLVq++xWCjm6ZV
sv954Fngm/ub/PPD78riBWDgMsunP87TliENBIKkIA98ItRgk+IaO720rwQAkCeN
oL0TFju7L1/DOoC+m5kaVqH2c2e28TM6M60S2f1Dft1ovUgK4rCcZHaguZqzfa6Y
xgNJ+v1jef8M+/79cqDw
=0bl5
-----END PGP SIGNATURE-----

--nextPart1924490.Qjde18uPMG--
