Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 16 Oct 2012 02:09:23 +0200
Message-ID: <32156311.f7ZhntrIpV@bentobox>
In-Reply-To: <1350244981-14026-2-git-send-email-ordex@autistici.org>
References: <1350244981-14026-1-git-send-email-ordex@autistici.org>
 <1350244981-14026-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17098201.EVT5bpWmvg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: export compatibility
	version via debugfs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart17098201.EVT5bpWmvg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 14 October 2012 22:03:01 Antonio Quartulli wrote:
> Different versions of the batman-adv module may use the same compatibility
> version, but this is not understandable at runtime (the only way is to parse
> the kernel log and fetch the batman-adv advertisement message on loading).
> The user may want to know whether two nodes using different versions can
> communicate or not. For this purpose the module has to export this value
> through debugfs.
> 
> Reported-by: Moritz Warning <moritzwarning@web.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
[...]
> +/**
> + * batadv_compat_seq_print_text - print the compatibility version
> + * @seq: not used
> + * @offset: not used
> + */
> +int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
> +{
> +	seq_printf(seq, "%d\n", BATADV_COMPAT_VERSION);
> +
> +	return 0;
> +}
> +

seq is not used? Marek also segfaulted after reading this.

Kind regards,
	Sven
--nextPart17098201.EVT5bpWmvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQfKWzAAoJEF2HCgfBJntGAm8QAJLO/vyb5TM4raNwEjwij3Ua
XcHfuDsb9ck6pbi4EGNPHhpKcLbu7g9w4d+NPZvhYAEY75e4q1/zb27UXMvsZDl+
Ub9b1iZTxBNLey/IdnjbktinJIWr7f5wBPofcPJPtxT0JDkSwG2nropgIDaT28mT
i4JDdDZxu/E18fWcZL7wqfpeSy3jZpSu/DE3V3M8f95l/YbUPAMOTsNrGrPy7mJW
+gXDSw/rnHYGW+gzqgFGupI4Sygk9AUfcmXTSE601NQQfPCxfC2+M5mao6NGYxNQ
9rnE3FK7IcmIb0gi7TW13h8sMh0AHoIWT2q+GCS1O2QIRP2GRUac+/ceAZ9POvRZ
35kSH30Uj0WMCTuN4lPgfierIpxITwt3bizwHRtLNlIdxZ8Q+EVbl/qCJndTOZYK
1maLMlVAQmbA0J90eC71gG5gFY+S6MfyJXzbUM/7rgZD1WJ1ENcEgE6SHjV9UJdy
HXwvAlv8etSuoNWAaS/D1AOPRQ4NzDjivjbC6hsIICONQNRW1g0gFSmY1CBnhhSa
przIufMg9bE0YdUuFXMwYKx9kqeW98kutcROAoV5KQGbWC5/igvnlU06jUjWOPXU
x36N7QqdaTrW5URY/cFQhwATePnimxQiZ82D4uhkx1WKePz85qrGbDHf8vCQwzkO
7y+6xXAYjJyT13AjpFvs
=Kdpz
-----END PGP SIGNATURE-----

--nextPart17098201.EVT5bpWmvg--

