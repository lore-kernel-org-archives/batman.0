Return-Path: <a@unstable.cc>
References: <20180505153020.29636-1-linus.luessing@c0d3.blue>
 <4312006.8fiAyFea1e@sven-edge> <2938343.Lhb7MQrGW1@lafayette>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <8b0bb0a1-5c5b-ebeb-a9f7-23f2ad2ef6f4@unstable.cc>
Date: Wed, 9 May 2018 03:55:17 +0800
MIME-Version: 1.0
In-Reply-To: <2938343.Lhb7MQrGW1@lafayette>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ReEDW51YoilnnrTPT3SKGdXqYoU2c0Xmb"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ReEDW51YoilnnrTPT3SKGdXqYoU2c0Xmb
Content-Type: multipart/mixed; boundary="iWQJM9TeddQdaRpR3ECv6Rv6unIarPcBh";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <8b0bb0a1-5c5b-ebeb-a9f7-23f2ad2ef6f4@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix TT sync flags for
 intermediate TT responses
References: <20180505153020.29636-1-linus.luessing@c0d3.blue>
 <4312006.8fiAyFea1e@sven-edge> <2938343.Lhb7MQrGW1@lafayette>
In-Reply-To: <2938343.Lhb7MQrGW1@lafayette>

--iWQJM9TeddQdaRpR3ECv6Rv6unIarPcBh
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 09/05/18 03:20, Marek Lindner wrote:
> On Sunday, May 6, 2018 4:23:37 AM HKT Sven Eckelmann wrote:
>>> * batadv_tt_tvlv_generate() - fill the tvlv buff with the tt entries =
from
>>> the *  specified tt hash
>>> * @bat_priv: the bat priv with all the soft interface information
>>> @@ -2934,6 +2969,7 @@ static void batadv_tt_tvlv_generate(struct
>>> batadv_priv *bat_priv, struct batadv_tvlv_tt_change *tt_change;
>>> struct hlist_head *head;
>>> u16 tt_tot, tt_num_entries =3D 0;
>>> +       int flags;
>>> u32 i;
>>>
>>> tt_tot =3D batadv_tt_entries(tt_len);
>>> @@ -2951,8 +2987,12 @@ static void batadv_tt_tvlv_generate(struct
>>> batadv_priv *bat_priv, if ((valid_cb) && (!valid_cb(tt_common_entry,
>>> cb_data)))
>>> continue;
>>>
>>> +                       flags =3D batadv_tt_get_flags(tt_common_entry=
,
>>> cb_data); +                       if (flags < 0)
>>> +                               continue;
>>
>> The second argument of batadv_tt_get_flags is a little bit tricky here=
=2E The
>> kernel-doc says that cb_data is "data passed to the filter function as=

>> argument" and is of type "void *". But you are now using it here as if=
 would
>> always be of type "struct batadv_orig_node *". This doesn't make probl=
em=20
>> for now because only two functions are using this argument - luckily t=
hey
>> are either set it to NULL or to "batadv_orig_node *".
>>
>> I would propose to make it clear that this argument must be
>> "struct batadv_orig_node *" and not an arbitrary argument which is onl=
y used
>> by the valid_cb callback.
>=20
> I second that concern. An alternative suggestion: Modify=20
> batadv_tt_local_valid() / batadv_tt_global_valid() to return the flags =
as=20
> those functions already distinguish between the local and global case. =

> Moreover, you save the extra batadv_tt_global_orig_entry_find() call wh=
ich=20
> already happens in  batadv_tt_global_valid().

I like Marek's idea, but I'd suggest to change the name of the
tt_*_valid() functions to something a bit more generic.


Apart from that I agree that that the flags retrieval could directly be
done within the callback which already knows if we are in the local or
global case.

Cheers,


--=20
Antonio Quartulli


--iWQJM9TeddQdaRpR3ECv6Rv6unIarPcBh--

--ReEDW51YoilnnrTPT3SKGdXqYoU2c0Xmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlryAKUACgkQB6U8WA7y
zXQh+w/+Nof6i+gdfUem6C/BWYJqaLlIR/X4lfPLjr7fB8wKxmhf2iX3x7qt5HR6
tx/Ehqf5FSclgM/Pk/z7owQBu/7W0zoFartt98d5yKb6BKMrwmhmaKzpkcVT9VyK
yE1pt2STu5wzP2cWT/KW7ru5DWmcWQEwGpoFM3km0nkTKj8UgYg+7qbmNhmqzqRt
JNx6uHyp5NPlBIMdIvZWgCUPtHT/QYnb0/tP1hRZVkFoAFloqIkdkkTHHXja3I5p
fdh3ZedYBHALvv0UUR4gVGPxjVCzVTT5+wg6iAIgeb0ne2/Bm3UBxb5O0TJ4kqv/
emcLQthowZPMB8Il8rliPoji5kY0PlbcJRWu/lv6JBfxtPiiG3RTnz30s1IABhkV
4lJtpWbeHA871I8ZFfeTzDaxkbDTFbdwciqaegJmxvaIlUgM2Lrk3FjhxWvo4h2i
hZsw7b/GULYy7S4yax9vCs053iuuj7G3SNXwWB6JAVprbIEgvS44i3aCIqnyFrJY
p21BE6twLjgGV++yCF7dgLg4ttEFCalC5S+PDpIGGbYrIMLSXSQaPjhLHR1k+XlB
7tlxzUsCeOHPYO2kcuBBGOyvhhYLJnp6Ge5/tBbzY2vKOrwkwcV+LqW3wA8Qmkk4
PrNJD7SNgcnMl2JS8KXkffucI5RVbHFPn3iTShfOkP7YVScmxcA=
=uKBc
-----END PGP SIGNATURE-----

--ReEDW51YoilnnrTPT3SKGdXqYoU2c0Xmb--
