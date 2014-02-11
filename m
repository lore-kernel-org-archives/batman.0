Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA6347.2050901@meshcoding.com>
Date: Tue, 11 Feb 2014 18:52:07 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-8-git-send-email-antonio@meshcoding.com>
 <20140211171207.GE24633@lunn.ch>
In-Reply-To: <20140211171207.GE24633@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OBRbMAGQ52xlwaqgrEP4Q4wi560Um4JqB"
Subject: Re: [B.A.T.M.A.N.] [RFC 07/23] batman-adv: OGMv2 - add basic
	infrastructure
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
--OBRbMAGQ52xlwaqgrEP4Q4wi560Um4JqB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 18:12, Andrew Lunn wrote:
>> +
>> +	batadv_v_ogm_start_timer(bat_priv);
>> +out:
>> +	return;
>=20
> If you jump to out because netdev_alloc_skb_ip_align() failed, don't
> you want to start the timer again? I would assume it is a transient
> problem not being able to get memory for the skb, and the next time
> the timer goes off it might work?

Now that I think about it I agree with you. If
netdev_alloc_skb_ip_align() fails either:
- the situation is permanent -> OOM soon
- or the situation is transient -> we should try re-scheduling the task.

>=20
>> +	bat_priv->bat_v.ogm_buff_len =3D BATADV_OGM2_HLEN;
>> +	ogm_buff =3D kmalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
>=20
> Maybe use kzalloc to ensure it is zero?

Not really needed because each field is explicitly assigned later. But
to be sure we sit on the safe side we can do that: in the end we are not
in the fastpath here.

Cheers,



--=20
Antonio Quartulli


--OBRbMAGQ52xlwaqgrEP4Q4wi560Um4JqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+mNKAAoJEEKTMo6mOh1VScgP+gKOJoiCEI3JUpSaRafkYqiY
KuL2bgoJnwuJGn3V4YMgPVRLcKizj5ZS8wHjXu1ZSnnn4xaQAj/3DsomPsDPjMfT
EvRQkI0dZodKGvvjanb2RPxUXb+ML0Gk+TA84Y8y7+hwOzqnM7pnW0fVUcqcCXa+
LWJqTJcMVGzy9EpGOJwNQNYaJpcxtZR5m/DDXYJ03AqPVQH/VQQ+scRLO7b5nN1b
+AVUneBoIK368vIO6y3SDYJbQy3ULNsZBPYiNG9Yq6oxROswzuApNIQjC5Oqb3Pt
tnYuc0ZHHD8TUbymZeDjT3ohKJ06q/xdJvJ/noQO5LH6/Im9dL5Wd7PxNoJbPAox
+MAKTQsclNn7jtnHUSWgGedjXDJNqglUicEpSYwgGF3iuoyCfL+m8m94DY19D0jU
BwV0Qr1+lZU/yDrG8CGmx0cbCJDv7V5msGvz9VEWA57eXcTnllsdUGkQqkW2rV1P
wYeOIq54f78Ais0vpdXwdEMF8JdIVn5Ncds4m/0wbCBGAzonb1xz9CZcp7o5V7o2
NrDK9l2kT3fMre4cBE9IX6HxrnVEJhOlAnp5onoVIOvLbqrTAWkcLcqy5c6yyC07
arXv07IiQngkelzjBR0jP63nmQdp4hzYKqzw+BrNKftQnqLf+FbpFlnwoGB2tZ/Z
u+mu/abSApW0ENjlw5pg
=+7Mh
-----END PGP SIGNATURE-----

--OBRbMAGQ52xlwaqgrEP4Q4wi560Um4JqB--
