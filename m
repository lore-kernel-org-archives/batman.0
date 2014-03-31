Return-Path: <antonio@meshcoding.com>
Message-ID: <53392C0D.2010404@meshcoding.com>
Date: Mon, 31 Mar 2014 10:49:17 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1396211704-4677-5-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="28ul0wgrLWBgNg5k75THTKHIUVvHuv4GQ"
Subject: Re: [B.A.T.M.A.N.] [RFCv2 4/6] mac80211: minstrel - implement
 get_expected_throughput() API
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: devel@lists.open80211s.org, Felix Fietkau <nbd@openwrt.org>, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--28ul0wgrLWBgNg5k75THTKHIUVvHuv4GQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/03/14 22:35, Antonio Quartulli wrote:
> +static u32
> +minstrel_get_expected_throughput(void *priv, void *priv_sta,
> +				 struct ieee80211_supported_band *sband)
> +{
> +	struct minstrel_sta_info *mi =3D priv_sta;
> +	int idx =3D mi->max_tp_rate[0];
> +	u32 bitrate, ret;
> +
> +	bitrate =3D sband->bitrates[mi->r[idx].rix].bitrate;
> +	ret =3D bitrate * MINSTREL_TRUNC(mi->r[idx].probability * 1000) / 100=
0;

Thanks to the point raised by Andrew Lunn I just realised that this
value is expressed in Mbps/10 and so should be converted to Mbps/100
before being returned (assuming we agree on using this unit).

Cheers,

--=20
Antonio Quartulli


--28ul0wgrLWBgNg5k75THTKHIUVvHuv4GQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIbBAEBCAAGBQJTOSwSAAoJEEKTMo6mOh1V8asP+J2bLE68i+RxFlJrzYzEllWq
bwB+MppRkMI++NicUZ0yefjcfwrakxLKBqA9DFz/kYPGmuVplJELwJKrIW2CRdHz
XuxkGRF0os53xeCkY+XiVXjLQbNHhx3bZmrtIaUhW09JGCLNiXVtGzgdwSIfn/i0
3EVd1mn5qwGnvZD+WmxssbJktxXCj19JLVnYHSo7qRHa602iiPgpBDZQxKU7ss1a
sb0Vx9ax7KBNDkRIkj+oINxHpT2B0mS+cuqsd5qo2YYFhkJAxW73MQNFIl4jEokS
MUT6LM+x7tl507vFPmWCikBdixuZKlb2n2yRUHVpomRYUKCzXqM7MmX2LpKtrEu4
kjfXNuIiFZkaJRAYcJr5FwzVW/SPmrauuQitME9kC2AQD3x0z993JOOiMmBloGK+
w4Wul/0viRmrj1syqNKtG75lv1qOJaclUc94m8jEUASJgGOzYt8bffCG1HmRcwBF
MwcNsONueDD+qgM6/sEmbOfWcYefJYcEdtKKf2x56RcMIOXqFl1be2eutnUkJ7OG
2zkAbobRiBXQJ1bAdyJDdmuNV91DQYUBAkfB6xnMRwj3T8NfutigRiM0GN/7GdQm
RXD1ihK58snPByb/1FoA7Ex7V9vJXtJc7WNnUpTFpxa6ZuelyAC0cBrl8k+A/adE
KqVgmrzYzlcfCHcKQm0=
=3Kbq
-----END PGP SIGNATURE-----

--28ul0wgrLWBgNg5k75THTKHIUVvHuv4GQ--
