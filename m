Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB6701.5000406@meshcoding.com>
Date: Wed, 12 Feb 2014 13:20:17 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-13-git-send-email-antonio@meshcoding.com>
 <20140212084022.GE30814@lunn.ch>
In-Reply-To: <20140212084022.GE30814@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6tm9XAcwKO9J9bFBAh5ETwBipfgSekW8O"
Subject: Re: [B.A.T.M.A.N.] [RFC 12/23] batman-adv: add base throughput
	attribute
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6tm9XAcwKO9J9bFBAh5ETwBipfgSekW8O
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 09:40, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:12PM +0100, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@open-mesh.com>
>>
>> when batman-adv is asked to estimate/compute the throughput
>> of an interface, but it fails for whatever reason, then the
>> value in this attribute is used
>>
>> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>> ---
>>  bat_v.c | 3 +++
>>  main.h  | 7 +++++++
>>  sysfs.c | 7 +++++++
>>  types.h | 1 +
>>  4 files changed, 18 insertions(+)
>>
>> diff --git a/bat_v.c b/bat_v.c
>> index d5457b3..3aa42ec 100644
>> --- a/bat_v.c
>> +++ b/bat_v.c
>> @@ -75,6 +75,9 @@ static struct batadv_algo_ops batadv_batman_v __read=
_mostly =3D {
>> =20
>>  int batadv_v_mesh_init(struct batadv_priv *bat_priv)
>>  {
>> +	atomic_set(&bat_priv->bat_v.base_throughput,
>> +		   BATADV_DEFAULT_BASE_THROUGHPUT);
>> +
>>  	return batadv_v_ogm_init(bat_priv);
>>  }
>> =20
>> diff --git a/main.h b/main.h
>> index 47fb9ed..5699c9f 100644
>> --- a/main.h
>> +++ b/main.h
>> @@ -33,6 +33,13 @@
>>  #define BATADV_MAX_METRIC 0xFFFFFFFF
>>  #define BATADV_JITTER 20
>> =20
>> +/**
>> + * BATADV_DEFAULT_BASE_THROUGHPUT - default value used as throughput =
for
>> + * hard_ifaces for which it is not possible to measure/estimate the r=
eal one.
>> + * Value is expressed in Mbps/10
>=20
> Mbps/10 is a rather odd unit. How about just Kbps?

This is the unit used in cfg/mac80211 because most of the rates are
either in the form of XX.0Mbps of XX.YMbps (so just one decimal number
needs to be saved).
Moreover I thought that having an higher precision is not very useful
because the routing decision cannot be taken on such a fine grained value=
=2E
Actually the originator table prints the metric in Mbps (XX.YMbps).

Do you think we should really go for the Kbps? this means losing one
order of magnitude on the highest value we can store (yeah, it's large
enough right now..but in the future who knows!)

Cheers,




--=20
Antonio Quartulli


--6tm9XAcwKO9J9bFBAh5ETwBipfgSekW8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+2cFAAoJEEKTMo6mOh1V/7IP/3LO1j8hAkIcfnVHN1CB1d7t
/bTuJutqfOAQe6cpo6uLSHx+hIKtKHMAHv9Kzw3stwd/TfNzREvxpFz5T0qehAMq
0WL2yYZqGCqEi2ZTLJ+XdrOxS9cBh0Q/c5+rJEU0bdaaiTMmwQ7B8ngHfrQsVDeF
oDivrhAsmG0rb8OSrrmOoBlxPVKWe8vV8xXzMBOm9dPRLpTAvvNYsjouj3e4cX49
8NwPe6VWzkfn95ZSK9+dIBZnxcM0w9pNl9T4hfXYNEDZHTnVxvbzM5mmrFuxNJrT
nn6BB4VkPpuIzJC66Co0ByAg2nazxps/D7l0EZ5dHirTW0wdRI853pQ0rz8r0T6L
liU7xeCseCe0sOLplNRtr9tXzgKJNJkN9bmfmbMHogszPSmHGacWSjHF/GbZm4bk
KzGUWTAvEVzgY7yFsEkrlxvbJcXMmysPSGMMj1JY8dj49i4vdX2wfcdRJ1nubJrm
cEBa6IMi7rFoJMMTqGL1+LOEYxBl9lVMx3dtCalpQRJ38h9gP9gQYY17lygbrGUr
BohHXMcKfspuJuqccPS6o4farbfve4TNpTr7ZNGM1zvNX1sUBr74fJkIsm0XRXiK
UL7iMTd3cKh9727iK38n03eQQTyrdnV7ZAlob9a0RO3hj55BFYoR2pWgDriIG8Uc
LvwajXu9LQeWOSym2x9C
=H/oK
-----END PGP SIGNATURE-----

--6tm9XAcwKO9J9bFBAh5ETwBipfgSekW8O--
