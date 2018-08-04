Return-Path: <a@unstable.cc>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <8211925.JcgYpGFXDF@sven-edge>
 <314bf0ac-4c10-da7a-d527-45afe92423fa@unstable.cc>
 <2057936.2F7DdePauk@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <b8b8da51-48f5-0553-ac02-4ea79c6e1389@unstable.cc>
Date: Sat, 4 Aug 2018 17:08:42 +0800
MIME-Version: 1.0
In-Reply-To: <2057936.2F7DdePauk@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IcuZg9aOu25iEFrcTEnbgMmM2jo5LYnic"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IcuZg9aOu25iEFrcTEnbgMmM2jo5LYnic
Content-Type: multipart/mixed; boundary="qRVayxhZpOpJMKwt9xq6gB3HTes2zhYwB";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner
 <mareklindner@neomailbox.ch>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org
Message-ID: <b8b8da51-48f5-0553-ac02-4ea79c6e1389@unstable.cc>
Subject: Re: [PATCH v2 7/7] batman-adv: ELP - add throughput meter test
 duration attribute
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <8211925.JcgYpGFXDF@sven-edge>
 <314bf0ac-4c10-da7a-d527-45afe92423fa@unstable.cc>
 <2057936.2F7DdePauk@sven-edge>
In-Reply-To: <2057936.2F7DdePauk@sven-edge>

--qRVayxhZpOpJMKwt9xq6gB3HTes2zhYwB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/08/18 17:02, Sven Eckelmann wrote:
> On Samstag, 4. August 2018 10:41:09 CEST Antonio Quartulli wrote:
> [...]
>>>>  Documentation/ABI/testing/sysfs-class-net-batman-adv | 7 +++++++
>>>
>>> Please discuss this with Jiri [1].
>>>
>>
>> After re-reading Jiri's points I can't really understand why we should=

>> now switch to netlink. I think all our sysfs knobs are used to inject
>> settings *to* userspace, therefore his point 1) does not really apply =
to
>> us. Point 2) is a bit generic and does not really explain why we shoul=
d
>> *switch*.
>=20
> Wouldn't it have been better when Jiri would also see your reply? Now h=
e isn't=20
> even aware of your criticism.
>=20
>> This said, I'd rather keep this patch as it is and possibly discuss th=
e
>> matter when sending this code to netdev for merging.
>>
>> I've discussed this with Marek too and he is fine with this approach.
>=20
> Interesting, I don't see it this way. This patch [0] is for netdev and =
we have=20
> the statement that "usage of sysfs in netdev subsystem is frowned upon"=
=2E Now=20
> you want that we ignore that and than maybe Simon have to deal with the=
=20
> fallout when he forwards it to David?

Nope, I'd rather step in myself, should David or anybody else complain
about the patch once sent to netdev. But I totally understand your point.=


Personally I did not see Jiri's statements as representative of netdev
as a whole, but it looked like his personal opinion to me (I might be
wrong).

I will reply to [1] directly so we can take the discussion from there the=
n.

Cheers,

>=20
> Kind regards,
> 	Sven
>=20
> [0] https://patchwork.open-mesh.org/patch/17372/
>=20
>>> [1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-May/017814=
=2Ehtml

--=20
Antonio Quartulli


--qRVayxhZpOpJMKwt9xq6gB3HTes2zhYwB--

--IcuZg9aOu25iEFrcTEnbgMmM2jo5LYnic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltlbRoACgkQB6U8WA7y
zXSVNA/+Lcuhvci75tP8uTEn8bs7NX3gMTLPGxFnAXMMb9WTDzLMTMLlGD0qLoEY
Kz0jwJcUFkd0xlsAvb/GVcmGFjvq1Oomrvj0rJGZM9p2LaETc+njCHBJEz7BFc2Z
odyjwtKp2mIsE6YG6LAVWnzc2SV1NAHeqZph6uZtlEZPGS7cukEtJGJBYoHlinxg
NFOOpVYg17LUNQSMdkGvxxPPpwAvQRGG54koppPwMD/Z6PwamzvCS5VuYvMO12gU
qs9W6cuUzEB4jpdkfbyUpQiJt6/f/QLDuuDazfgebxGSVSzDxIsrgALNmijgtHgi
YPjVt87P/xJNNaBwwiu3LnlnyJdxKj+1lqwrWVAJqBPvJf/xuNYoyArOfFZJDycV
2thhtpj0JCxr5lgouSzmg3jOQ4iCltxxtmBk30fRzxYM0vj0KXeNc97D0WAAgtNx
3O4LDKuJvwh4/uLCMtxLZ2xqBi+Dn97rSKx7cMgFvHSdTSxfsPIqZv5egyKEcVV7
vjdmLRBP+wQvjvpVfiCELP00Fu/GrC+SN9iQSmOCn8Z/0lq510Tkc/zpHXFIBtHF
JZUqtZ1pMSPR3KiBCSRSYNs9mt9vU94YP1uwiy8jol4qT8ntoKIMs49c/DEgPQoc
qIAWqZj9ZUeRXZJ6xpWcxv98YmYjULwXPjiJZiCGr+NH0GAUVj0=
=a4je
-----END PGP SIGNATURE-----

--IcuZg9aOu25iEFrcTEnbgMmM2jo5LYnic--
