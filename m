Return-Path: <a@unstable.cc>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521150114.GP7162@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <0ebfb8b9-22bc-6d25-f498-b054dbd75820@unstable.cc>
Date: Sat, 4 Aug 2018 16:59:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180521150114.GP7162@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NsyWZUaqfRssA1hb1OVzmsv9hL5rSxFcm"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NsyWZUaqfRssA1hb1OVzmsv9hL5rSxFcm
Content-Type: multipart/mixed; boundary="EkKTVB2T7rPIbHp3IkHXyFTz8Bj2s7WgA";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <0ebfb8b9-22bc-6d25-f498-b054dbd75820@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521150114.GP7162@otheros>
In-Reply-To: <20180521150114.GP7162@otheros>

--EkKTVB2T7rPIbHp3IkHXyFTz8Bj2s7WgA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 21/05/18 23:01, Linus L=C3=BCssing wrote:
> On Fri, May 18, 2018 at 09:47:53AM +0800, Marek Lindner wrote:
>> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
>> index 0a9bee88..148f23ad 100644
>> --- a/net/batman-adv/types.h
>> +++ b/net/batman-adv/types.h
>> @@ -583,6 +583,20 @@ struct batadv_hardif_neigh_node_bat_v {
>> =20
>>  	/** @metric_work: work queue callback item for metric update */
>>  	struct work_struct metric_work;
>> +
>> +	/**
>> +	 * @tp_meter_running: tp meter measurements towards this neighbor in=

>> +	 * progress
>> +	 */
>> +	unsigned char tp_meter_running:1;
>=20
> I'm currently wondering: Would it make sense to prevent parallel
> tp meter execution not only to a specific neighbor but parallel
> executions on a hard-interface in general?
>=20

This flag prevents scheduling new measurements to this neighbour if one
has already been scheduled and has not returned any result yet.

What you are looking for is implemented in patch 1/7: a system-wide
queue prevents concurrent measurements at all. All the measurements are
serialized and performed one after the other.


Cheers,

--=20
Antonio Quartulli


--EkKTVB2T7rPIbHp3IkHXyFTz8Bj2s7WgA--

--NsyWZUaqfRssA1hb1OVzmsv9hL5rSxFcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltlaw4ACgkQB6U8WA7y
zXRGvQ/9GWa+Jc3I7yNay/ej1c0as0GcP71/HBQrTTeNu79CLhAYRnTuUI7mrwgw
/r9FGUF3Wfi7FWmlsgUHxUYdW+Fd19DdwTVM7i2kfGYsuReSleQlAdp/8krR4bFG
qOew6murrqxZAdbv7hxPP0Hpg+wuN71X2SnYXf4ibXyyw162UoXmMSGzfwZfzvi7
/XWNm8Ajo4ofwx16d8PWHLsMSjITxT8ZvYXkUNJxHIw8WaRugLq+Bj8qQUBRvCK5
lcHG+sqWl6Pa7qiODVRLKJMBKSEgBfMxPBOKRj8gVeRAvdbVLZr4oW2mgmyVUfUI
SmQp8KLZL3t/lcLeU1mQIso7jLF1JlVZSoJW1bPwXqfz9u6tqdirRB92t1sBwYHe
RbjY8pvztNlqVa+xNJn6I/HQSQAVMRlj3zedjGZsRX2mC3ko5slWdywmFaRQPWOw
sGwuFOjr5ThJaA4U0UD0cr9iSeuA4hb46pKYuynxDZ49YmbT6rqZ9pIdYVQG2ldy
7qmOsRscZYFz6TsbS4B5n4A/7Yvtj5akPSnC1XAZH9M8iGkaVdoliYnnjLc2LnkY
T9VFlne1spcp5jJOm0O+025BkG983cvxcPt8H0lurQQjCHTE15WFICvCUTkvs8Sf
RbUwyoim7jkLi79KYJPi+Rl+KndhWdGdptFC9UyXhJXyAv4kVMQ=
=J3IF
-----END PGP SIGNATURE-----

--NsyWZUaqfRssA1hb1OVzmsv9hL5rSxFcm--
