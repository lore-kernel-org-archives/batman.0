Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 23 Feb 2011 19:14:52 +0100
References: <4D64BAFF.9050006@Radtke.eu> <4D654722.4030506@Radtke.eu>
In-Reply-To: <4D654722.4030506@Radtke.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1797997.N1dHJHINN9";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102231914.56033.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Problem after configuring a bridge
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1797997.N1dHJHINN9
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 February 2011 18:42:58 Dr. Stefan Radtke wrote:
> Hello Antonio, Sven,
>=20
> thanks for your comments. With your help I could set it up. The mistake
> was in fact the ip-address on bat0.
>=20
> I removed all IP addresses and set them to the bridge. That worked !
>=20
> For those who might run into the same problem, here is the correct setup:
> http://www.radtke.eu/tmp/Leitzberg-Mesh-corrected.gif

I've noticed two IPs for br0:0 in node1 but no for br0 - is this correct?

> But a question is remaining: once the mesh was running, I wanted to turn
> on enrcyption but this seems not working in ad-hoc mode with OpenWRT .
> If I select Access Point mode for wlan0 the WPA2 encryption works....but
> this is not supported with batman-adv since the wifis need to run in
> ad-hoc mode. Any hint for this if I want to run the mesh encrypted ?

This is wrong. batman-adv doesn't need a network which is setup in adhoc mo=
de.=20
It only needs a layer which has roughly the characteristics of ethernet (fr=
ame=20
header, broadcast/multicast addresses, ...).

If you want some kind of encryption in adhoc mode as part of the wifi layer=
=20
then please try WPA_NONE or similar protocols. Authorisation, authenticatio=
n=20
and encryption in higher layers are still highly recommended.

Best regards,
	Sven

--nextPart1797997.N1dHJHINN9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNZU6dAAoJEF2HCgfBJntG1fIP/RsE4Lh7O4JzZb/SAN2n6OLA
c2o7XrUgxE4tpPLxPwqP2jRsqRBJEvj6KFCG053s4BLXPOxJyo88GZvngbwfFYdZ
ovcrqRGRab5TpOD/XEBejbG5p9IebPLNi4+Rj3ZUC47utdncOwqpux07bm/PfcOn
EVWmS/gAoWwuJr5LMvhEe1esBZMVhnN74sbLrJRqMYp0Lh6GJF/GMN2kKR5v/h93
SSiSEnHvdqfEkJPSk3g/+rrxeVyXZWe4LWZj8XSExZPIPDic34QVhxm38strYd3u
D90sZI0eaE7WVptuUJOyOz2N1Vo5bH9Z7hKes4krP36sqpBVCB1Cx9x/T+PVIUJN
L39f5rj/sLP0Vz4UK5tcJPJ1tMhjT+pJpdsgQDpgQgqGhvrnC4yxoambjwJdwIpk
2yAd6NoF/6I1mB9E4gZqzQLg+CqvQcxfhk9aey8QB0BPvYoqb3/JKQ1YBZicTVoj
/h2ZxJzX2aE30EBL/f47H4ccuX1bs1wX88I8ddixHnpgmqa7OFpkSrvd0a6qO9Qb
9sw0CZKEh3F7no3hCASNCYhw8uw8+DfdeB8vqPLoPCogGrUZ42a/E4uc+R9se3kf
NLH8+XAcFqMK5cKPIc69CWZd105Jnx0np0Ysg8Hm24O2t8NwkWxMowU3nzHd2RHy
rY6F7U4p+OoE8Mw0HQo2
=jNA2
-----END PGP SIGNATURE-----

--nextPart1797997.N1dHJHINN9--
