Return-Path: <antonio@meshcoding.com>
Message-ID: <5300FEED.6090406@meshcoding.com>
Date: Sun, 16 Feb 2014 19:09:49 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392552062-17927-1-git-send-email-linus.luessing@web.de>
 <5300BFA0.9080903@meshcoding.com>
In-Reply-To: <5300BFA0.9080903@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VOtTRHWFOGJCdN5d60GC02bTtNO0DdcTb"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix null pointer
 exception for kernels < 3.9
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VOtTRHWFOGJCdN5d60GC02bTtNO0DdcTb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/02/14 14:39, Antonio Quartulli wrote:
> On 16/02/14 13:01, Linus L=C3=BCssing wrote:
>> @@ -371,12 +372,13 @@ static int __batadv_interface_tx(struct sk_buff =
*skb, \
>> =20
>>  #ifndef netdev_master_upper_dev_get_rcu
>>  #define netdev_master_upper_dev_get_rcu(dev) \
>> -	NULL; \
>> +	upper; \
>>  	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
>>  		rcu_read_unlock(); \
>>  		dev_hold(dev); \
>>  		return dev; \
>> -	}
>> +	} else \
>> +		dev =3D NULL;
>> =20
>=20
> Following your patch the code in multicast.c will become:
>=20
> 172         do {
> 173                 upper =3D upper;
> 			if (dev->priv_flags & IFF_BRIDGE_PORT) {
> 				rcu_read_unlock();
> 				dev_hold(dev);
> 				return dev;
> 			} else
> 				dev =3D NULL;
> 174         } while (upper && !(upper->priv_flags & IFF_EBRIDGE));
>=20
> am I wrong or this is going to break the while? I think there is a
> missing '}'.
>=20

I was wrong. I just dreamt of a '{' after "else".
Forget about this comment.

Cheers,

--=20
Antonio Quartulli


--VOtTRHWFOGJCdN5d60GC02bTtNO0DdcTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTAP7yAAoJEEKTMo6mOh1VeuwP/08MmxPXXyrP87fmb0r0B5Ik
uGINCI+FXNXImLqCVcY906EHmjSbugE9/fk7bKFjTBqiSJ1zzMCCU2YHV7+lm9wE
+O4B40ywnN4rHO49+d3VDw8hXzu9CTYXip+PKTW16nNYha549gqqkU1snxyHA2Ik
3vqQP0bmWGmy12DljCcQ0rapkqlpp9F9XMcIR0XnHvLt6k5i/mXBlnouZpFSOz7T
nvZw9xtv11Pwc8ik2fHibrlHZlGLikbkD78Fv9oD/XhoUquKU22RUEDsG5bbd3/7
rOdtvRAUrRoIUKFBQHz4D9dGdCXvJ2QXfoOgncJ51J+l8lTD8lQMY+3OEdaSn2Dn
zh8J9R+1BbFN4AzkyJR10nydVA09yA/fw0ZzMnAl8LfyFJ8GMzPINZv6UXmJAI/w
N3OAsL1PXvvfabSFxHHG93PxJsvbsYD8jkslKIiIU9yvEB6V7G//M8/uKMUUBHch
ICBILSZYbIihuO7u5dxX9/j7bpdXUhZA7lAPMMtFl1CCBPoBa1cMUpMVVN+kcWw/
IB+kknhB5srDsntjnK+FnYreR1A3iBFCzz2raLTpQrfAyp6zzrv2zod8bjMG/Oh9
l4YvCthc71YtLLY5JgDT+nVr/fdJayhl4E35w9WsQfVMlmiAg/q6xuF5GyNeccbO
quUguEJaXeJsdJGcFS57
=UG/o
-----END PGP SIGNATURE-----

--VOtTRHWFOGJCdN5d60GC02bTtNO0DdcTb--
