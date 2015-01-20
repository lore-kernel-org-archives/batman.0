Return-Path: <janphilipp@litza.de>
Message-ID: <54BE0B72.1070502@litza.de>
Date: Tue, 20 Jan 2015 09:01:54 +0100
From: Jan-Philipp Litza <janphilipp@litza.de>
MIME-Version: 1.0
References: <1421705011.612946.10937.nullmailer@sylar.jplitza.de>
 <3346859.V9Mt6glXr0@sven-edge>
In-Reply-To: <3346859.V9Mt6glXr0@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iWAAIaC03OpuIcX6dGvC78PfKmDCHfJbj"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Tighten size check on received
	packet
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
To: Sven Eckelmann <sven@narfation.org>, "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iWAAIaC03OpuIcX6dGvC78PfKmDCHfJbj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

> On Monday 19 January 2015 21:59:32 Jan-Philipp Litza wrote:
>> When first checking if a received packet is truncated, the size of the=

>> alfred_tlv structure is ignored, thus allowing packets that are
>> truncated by 4 bytes or less to pass the check unnoticed.
>>
>> Even the check itself might access memory after the packet if its size=

>> was only 2 bytes or less.
> [...]
>>  	/* drop truncated packets */
>> -	if (length < ((int)ntohs(packet->length)))
>> +	if (length < (int)sizeof(*packet) ||
>> +	    length < (int)(ntohs(packet->length) + sizeof(*packet)))
>>  		return -1;
>>
>>  	/* drop incompatible packet */
>=20
> Thanks for the patch. It is basically correct but maybe you can modify =
it
> slightly to make it also catch very small packets.

It already does that in the first line of the if statement. Your
modification only checks this earlier, but because no data from the
packet is accessed before the length check, it should not matter when we
do this. Or am I missing the point?

>=20
> diff --git a/recv.c b/recv.c
> index 90db0b3..288f577 100644
> --- a/recv.c
> +++ b/recv.c
> @@ -391,7 +391,12 @@ int recv_alfred_packet(struct globals *globals, st=
ruct interface *interface)
>  		return -1;
>  	}
> =20
> +	/* drop packets smaller than tlv */
> +	if (length < (int)sizeof(*packet))
> +		return -1;
> +
>  	packet =3D (struct alfred_tlv *)buf;
> +	length -=3D sizeof(*packet);
> =20
>  	/* drop packets not sent over link-local ipv6 */
>  	if (!is_ipv6_eui64(&source.sin6_addr))
>=20
> Kind regards,
> 	Sven
>=20


--iWAAIaC03OpuIcX6dGvC78PfKmDCHfJbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvgtyAAoJEPYGyZaJKubSuIAP/RJTpaikKUGU8oupjpp6hMdx
dzt5bUtZhU36Nun3yCoXjFuyxQzo9W+58SuctHs9oV9GLFuUnoC6wKhToVrKh0RS
WsHsT7CVercH7CLXH4OhcSZNXnNuYEHGcVZhmxjTmJbmC55owmKZOlcPgjvss7fP
Tz4VdoBCyLy/USyk50V786wYAdhrJD7n/jzn5oMGfj6enR2K+hD9CzrELNdbyimT
wmMZXu+x70g2c+aBz8kuOcKFvOXY1Y76kwCBYxzF3dPbeBac56YqpSun2FCtNNLO
jtqlkuhub/SpRQ2LdRC3evPIRTW0/qgOAfP1vQJMxQocSa1M+Ulhu6tZhMEZnpuU
qmOaSP+DetOiyG5GDfkwccYHcIzJWk2DMLJzgo+vBxBRZpM8nycSxqKJQk57JVNo
3uUMcTLUYHIuHfz4+E3rCR/BsCmQJnpsI3QgX8iqVR6MV3Xl/h2h7ofChTW/El4d
V7KF381aGm6RlvmEE/EG54WYTRfBfFoE3eaChvTq/KbofEpjc18l2PzA9VfqRB4n
JyQ3/sTdDi/WguDuzcOrHzEp+2w67cgiSdBeRtur50frCONAf3zlq1bvXLtMgQqB
EQ/dwa4dAlAlZxRT7V5wTcdflULfmhpHUhXRxQLro69s8b8ZDvPdMfq6w7DeqvEf
CTnt2iS5qALh6HdKnWCC
=DIG8
-----END PGP SIGNATURE-----

--iWAAIaC03OpuIcX6dGvC78PfKmDCHfJbj--
