Return-Path: <a@unstable.cc>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion> <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion> <20180327154307.GA2052@otheros>
 <20180520061954.GA2255@nanopsycho.orion>
 <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
 <20180804093632.GB2015@nanopsycho>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <f2964fca-072e-2a6c-4ce9-aa7963465195@unstable.cc>
Date: Sat, 4 Aug 2018 19:19:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180804093632.GB2015@nanopsycho>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vSaGjnBSPeYvfM4iVI2ZqdP1uqAd9BhMS"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vSaGjnBSPeYvfM4iVI2ZqdP1uqAd9BhMS
Content-Type: multipart/mixed; boundary="2FbyiASBSRDigE9z199I4UfusVK2RPcIr";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Jiri Pirko <jiri@resnulli.us>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>, netdev@vger.kernel.org, davem@davemloft.net
Message-ID: <f2964fca-072e-2a6c-4ce9-aa7963465195@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion> <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion> <20180327154307.GA2052@otheros>
 <20180520061954.GA2255@nanopsycho.orion>
 <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
 <20180804093632.GB2015@nanopsycho>
In-Reply-To: <20180804093632.GB2015@nanopsycho>

--2FbyiASBSRDigE9z199I4UfusVK2RPcIr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/08/18 17:36, Jiri Pirko wrote:
>>
>> Do you have any pointer about where this discussion took place? I
>> imagine it happened in conjunction with some patches intended to other=

>> drivers/netdev changes.
>>
>> Reading that could give us a sense of how strict/important/severe this=

>> decision was and how to prioritize future work.
>>
>> I am asking because we have been working on a new feature since severa=
l
>> months and this feature introduces a new sysfs knob.
>>
>> Now, although I understand the recommendation of switching to netlink,=
 I
>> find it a bit impractical to delay a new (and fairly big) feature,
>> simply because it uses a potentially obsolete, but current, API.
>>
>> Any opinion about this?
>=20
> I agree, that does not make sense.

Thanks for your reply, Jiri.

>=20
> I just wanted you to consider introducing netlink iface and migrate to
> it as it is generally the preffered way to comunicate with userspace in=

> networking area (I don't have pointer any specific discussion though -
> it is just a common knowledge :)).

That's ok. I was asking because in the past batman-adv was using debugfs
for dealing with settings and we were (properly) redirected to sysfs by
David.
Now it seems we need to migrate to the next thing :-) So I just wanted
to be sure we have to do it, but this seems to be the case..

> I will be more then happy to help you
> with that. You should look at net/core/devlink.c and net/wireless/nl802=
11.c
> to get some inspiration.

Actually we have already implemented a basic netlink API to be used when
sending information to userspace (i.e. routing tables, neighbour tables,
etc..), therefore I think we might be able to leverage on that.
But of course, any help will be appreciated :)

Thanks!

Cheers,



--=20
Antonio Quartulli


--2FbyiASBSRDigE9z199I4UfusVK2RPcIr--

--vSaGjnBSPeYvfM4iVI2ZqdP1uqAd9BhMS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltli8sACgkQB6U8WA7y
zXSoxxAAwcfNDtPpflOL3cBw+UzrbTBGvAg+m5j0jyMs8mllnlwU7jt6W2XXYD6Z
2WfqrhH6H2E1ODwh7Vhj1P4tat4ntKY+U8wMH6McOnn4/RH/m+cTA3Lsj//nIUS3
D78QVYqPtBFeQSREjSM4lNCxmzpByzwm6bEVgH4HAF+PFlMdbOSqULypHpNaP1d1
sWEudrTyxrvQrXOHRj3F9i4LDQi3Y1nisxxEU0etXS+iroQqAgT3JB0Ag8uEwRFI
BudiHAbYG+y7AApH0ZO0vV1/O1Qug1MxybWSpPzXs5fHokvbO0DNesKB+nS/ldY1
7hfYYUUF1muXqJHtxr8o37QNxdKK166OjB82UvBmw/jxMaD0UzEcQtrDBOvL1I4M
8CtoGl943M8ptyvMRIpXSdOu95yOw7BEjuMcZ/5PonsjTKE3dgC1kq9zpT/PtcC2
etwY/JMdBbbJZIyblnpmOIBeuQ5FHIb+tOFOwy90OsMienttM9K8G6Z8r+p+xQjt
e0wAOmxLWLAsbrBdjl7xzJuQ0po5Q4sr1LBIiqZpXOaianzHbeYWfY/WcYpJkjq0
zcS5fMwOD4U0xGDiiF+PPl5xXXeZkoDKCWTiNe4wM+QjfBe5pNDasr+BS5tigkbE
xD7kOPYSv8vPHTeON+8Ai03H/8312mGCpBNSH1DjxRelKjoM4+g=
=9C0J
-----END PGP SIGNATURE-----

--vSaGjnBSPeYvfM4iVI2ZqdP1uqAd9BhMS--
