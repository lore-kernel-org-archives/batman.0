Return-Path: <antonio@meshcoding.com>
Message-ID: <53392B5D.5070806@meshcoding.com>
Date: Mon, 31 Mar 2014 10:46:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-2-git-send-email-antonio@meshcoding.com>
 <20140331082245.GC4311@lunn.ch>
In-Reply-To: <20140331082245.GC4311@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pTvwLOBjKrVLaAAwx2P3vHjLnnimSbLvG"
Subject: Re: [B.A.T.M.A.N.] [RFCv2 1/6] cfg80211: export expected throughput
 through get_station()
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
To: Andrew Lunn <andrew@lunn.ch>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: devel@lists.open80211s.org, Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@openwrt.org>, Antonio Quartulli <antonio@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pTvwLOBjKrVLaAAwx2P3vHjLnnimSbLvG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 31/03/14 10:22, Andrew Lunn wrote:
>>  /**
>> @@ -1013,6 +1015,9 @@ struct sta_bss_parameters {
>>   * @local_pm: local mesh STA power save mode
>>   * @peer_pm: peer mesh STA power save mode
>>   * @nonpeer_pm: non-peer mesh STA power save mode
>> + * @expected_throughput: expected throughput as reported by the RC al=
gorithm
>> + *  about the bitrate having the maximum throughput. This field can b=
e filled
>> + *  only by drivers using Minstrel
>>   */
>>  struct station_info {
>>  	u32 filled;
>> @@ -1051,6 +1056,8 @@ struct station_info {
>>  	enum nl80211_mesh_power_mode peer_pm;
>>  	enum nl80211_mesh_power_mode nonpeer_pm;
>> =20
>> +	u32 expected_throughput;
>> +
>=20
> It would be nice to comment on what the units are. I known from our
> BATMAN V discussions, it is something odd.
>=20

Thanks for raising the point.

Actually this is something we could discuss with Felix: at the moment
this value uses the same unit used by the cur_tp member of the
minstrel_ht_sta structure.

It should be Mbps/100 --> expected_throughput =3D 1 =3D=3D> 0.01Mbps

When exposing this value to the user (i.e. iw output) I'd recommend to
convert it to Mbps, but for internal purposes I don't see a clear
problem in exporting a value in this form.

Thoughts? Suggestions?

Cheers,

--=20
Antonio Quartulli


--pTvwLOBjKrVLaAAwx2P3vHjLnnimSbLvG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTOSthAAoJEEKTMo6mOh1VVlgP/R9e2t9chrUPfXn5kq5Mw4B4
IMdZCbq4Z2eMRwepJalpjeI0vbup485XttJp/LJ/FpQxRkUQ7SFwyU8M9xqS2Oi7
82af30+Zqmk0SSt/IneDVBX/zVHRtoRrXK0v0Lqv9ejBqXI4WGUj3wxAyMltc+t0
AleMyes+34lJZynDNWW9Nd8mj5KmWrHOdUMHLNOQcOoS2f6yIVT1bGYtHUuAdw/q
ehlpiQqcz/ti63huHfTDkDXsA0DYvKzzEDR+irs476p1YBhVuGUvTpvbiJ806vV8
ZRZ+30Kr5e3nSd0yWr7n0/OSJO0L8igck8+JVgDtojX0QHznv4OgDAhN/FOzL2HX
siuN3BEjTo8z5X9YPIfhbUg/OUD2znzJ3nTKrW1Bz229WxClB8rtR7ps4Vw34Wrk
iDo2+IpOac+UQoOfN78wQDATcHQ6HOa62BXDw1OP/pbDhbyEWC6z5GFWx2MTn07k
jPRI33bjneTTVkTMsyYRy5PJugIjExmydVQpPOII+TD68INyQigxJ6dcNZtOUEau
clAE/o8aqKgOY1H3MkKtY6ga0vSPeSPFegjm7g9vbZpqnr+h9ZBcPjsGXu1ZTg1E
6BIg3ghzmZbR0H8JUMpZpfNJUdrEOZ29OxvulmOQmpGp9yx4Fxm0JIhmYyzDfEY2
7NWOu96qYwk2ALnY0ett
=fQvx
-----END PGP SIGNATURE-----

--pTvwLOBjKrVLaAAwx2P3vHjLnnimSbLvG--
