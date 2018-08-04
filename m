Return-Path: <a@unstable.cc>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion> <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion> <20180327154307.GA2052@otheros>
 <20180520061954.GA2255@nanopsycho.orion>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
Date: Sat, 4 Aug 2018 17:24:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180520061954.GA2255@nanopsycho.orion>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zKEHCdxDMaW6iRhJzhjkkKXQDZ6YrpOrD"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Jiri Pirko <jiri@resnulli.us>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zKEHCdxDMaW6iRhJzhjkkKXQDZ6YrpOrD
Content-Type: multipart/mixed; boundary="7dNBML8yO2ZstGVmnpwxMPuLThytOZ2w5";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, davem@davemloft.net
Message-ID: <113e9222-3310-71c6-7cec-c253b9b5d194@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
 mcast sysfs files to README
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-4-sw@simonwunderlich.de>
 <20161029103301.GD1692@nanopsycho.orion> <22392280.4UY6GoIrAk@sven-edge>
 <20161029105628.GE1692@nanopsycho.orion> <20180327154307.GA2052@otheros>
 <20180520061954.GA2255@nanopsycho.orion>
In-Reply-To: <20180520061954.GA2255@nanopsycho.orion>

--7dNBML8yO2ZstGVmnpwxMPuLThytOZ2w5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On 20/05/18 14:19, Jiri Pirko wrote:
> Tue, Mar 27, 2018 at 05:43:08PM CEST, linus.luessing@c0d3.blue wrote:
>> On Sat, Oct 29, 2016 at 12:56:28PM +0200, Jiri Pirko wrote:
>>>>> I strongly believe it is a huge mistake to use sysfs for things lik=
e
>>>>> this. This should be done via generic netlink api.
>>>>
>>>> This doesn't change the problem that it is already that way. This pa=
tch
>>>> only adds the list of available files to the README.
>>>
>>> Sure. Just found out you did it like that. Therefore I commented. I
>>> suggest to rework the api to use genl entirely.
>>
>> Hi Jiri,
>>
>> Thanks for sharing your thoughts!
>>
>> Could you explain a bit more on which disadvantages you see in
>> the usage of sysfs here?
>=20
> There are 2 major disadvantages.
> 1) You don't have any events on a change. An app has to poll in order t=
o
>    know what changed in kernel. Netlink handles this by sending
>    multicast messages on a specific socket while whoever is interested
>    gets the messages.
> 2) In sysfs, everything is string. There are even mixed values like
>    "1 (means something)". There are no well defined values. Every drive=
r
>    can expose same things differently. In Netlink, you have well-define=
d
>    attributes, with typed values. You can pass multiple attributes for
>    the same value if needed.
>=20
> In general, usage of sysfs in netdev subsystem is frowned upon. I would=

> suggest to convert your iface to Generic Netlink API and let the
> existing sysfs API to rot.

Do you have any pointer about where this discussion took place? I
imagine it happened in conjunction with some patches intended to other
drivers/netdev changes.

Reading that could give us a sense of how strict/important/severe this
decision was and how to prioritize future work.

I am asking because we have been working on a new feature since several
months and this feature introduces a new sysfs knob.

Now, although I understand the recommendation of switching to netlink, I
find it a bit impractical to delay a new (and fairly big) feature,
simply because it uses a potentially obsolete, but current, API.

Any opinion about this?


Thanks a lot


Regards,


--=20
Antonio Quartulli


--7dNBML8yO2ZstGVmnpwxMPuLThytOZ2w5--

--zKEHCdxDMaW6iRhJzhjkkKXQDZ6YrpOrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltlcLsACgkQB6U8WA7y
zXRorBAAk0cQrKKaZGW9G9FbEdMxNLftTU7dRHGTb7dzRxVclVDJG7JX9P7bOAnM
5/vjUAwX28mZws62xNaPbgKoOIQYLlh/KhnzLOvTV+2jqotBKsakLoJUfAf1iqqi
xiCc6IfnR5Mj9jdgzYU77/UjWN7mHSxnfNRX0Ndln+tE5O6me9pZgmNE62IKJe14
fyFmAz02QFavlb4tyfEGqWZlDnKdA1GJZLKsA3VyFTKEs2EmfLqIn5JM005Ur91s
xQRFtRtOct5qEOHuC86xEYDFnIO1xLlSZNPVxP/RFXNfyGEO5ff8ZJGFnVYBVnnn
3Ic5/3Pyur+N5Ad3rw27QPJCzYNFO9tla4iLBG/0/yzi11VUVMSN6h/uHkY0A2rK
ethb7bK/we2G+PL9V2YiagXxm1CZB3X29oGnKXyneQfpNbLe1Vs/4oTD4dT/k71S
O05Hs7njq+t/vKo2jQ5s38CpTMocKV5F/UBl1siJTx4x0wLhPIR+6HRqt0vkse+L
41eBhRfq28yFVdmQgdOo80APdvYKt0oqGl2m66goamLBLkVHpwkqi+TyFFczZG7T
qESJ1Raf4yZyRnxSxos1AFOz0OtYzAPyfhGSJ42XLWPLBvxSBEMtlRCtjjoAFCH/
QkEXIL3AyWtaJiHV+B5BPJnU3FQ/4xHHsobgGvpoWNHy9BD9SmE=
=pvXp
-----END PGP SIGNATURE-----

--zKEHCdxDMaW6iRhJzhjkkKXQDZ6YrpOrD--
