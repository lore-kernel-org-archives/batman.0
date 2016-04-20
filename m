Return-Path: <mschiffer@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <57173083.6020305@universe-factory.net>
Date: Wed, 20 Apr 2016 09:32:19 +0200
MIME-Version: 1.0
In-Reply-To: <3565172.dz0c0eMaPu@prime>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hDhB293lqCpcaLNgsmB7u22WQ0XlT8FQX"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDhB293lqCpcaLNgsmB7u22WQ0XlT8FQX
Content-Type: multipart/mixed; boundary="vUf8uMhRC2LgLMjxSa5TKp8UGREHQ3JP7"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <57173083.6020305@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime>
In-Reply-To: <3565172.dz0c0eMaPu@prime>

--vUf8uMhRC2LgLMjxSa5TKp8UGREHQ3JP7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/18/2016 04:50 PM, Simon Wunderlich wrote:
> On Thursday 17 March 2016 17:45:30 Matthias Schiffer wrote:
>> Hi,
>> this is the second take of my netlink API patches. As mentioned before=
, the
>> netlink API is superior to the current debugfs API in many aspects:
>>
>> * debugfs is broken (see PATCH 1 for details)
>> * Netlink is namespace-aware, and can be used in unprivileged containe=
rs
>>   without problems
>> * Netlink packets are more machine-readable than text files, and can b=
e
>>   easily extended without potentially breaking userspace
>> * On older kernels, seq_file can't fall back to vmalloc if kmalloc fai=
ls,
>>   which often leads to OOM when reading "originators" in large meshes,=
 as
>>   the whole file must fit into a single buffer
>>
>> Of course, are also a few downsides; when the data is too big to fit i=
nto
>> a single netlink packet, the provided data may be inconsistent (entrie=
s may
>> be missing or duplicated.) This will happen in large meshes only, and =
be
>> improbable in any case.
>>
>> The patches have been developed on top of the netns patchset, but shou=
ld
>> be applicable independently (maybe with minor changes.)
>>
>> All netlink queries returning lists of any kind can only be used with
>> NLM_F_DUMP queries, so that arbitrarity large responses are possible (=
split
>> across multiple packets if necessary.)
>>
>> At the moment, the following debugfs files have corresponding netlink =
APIs:
>>
>> * routing_algos
>> * neighbors
>> * originators
>> * transtable_global
>> * transtable_local
>> * (hardinterfaces for a softif can be queried)
>>
>> The following files are still missing:
>>
>> * gateways
>> * bla_claim_table
>> * bla_backbone_table
>> * dat_cache
>> * nc_nodes
>>
>> Obviously, documentation is also a TODO. Comments about the API design=
 are
>> very welcome...
>>
>> Regards,
>> Matthias
>=20
> Hi Matthias,
>=20
> thanks for reposting this and sorry for the long silence. Since we have=
 the=20
> namespace work from Andrew now which would require netlink support, I t=
hink=20
> its a good time to integrate this. :)
>=20
> I'll try to look into your patchset this week into more detail and give=
=20
> feedback. In the meantime, just a few question:
>=20
>  * Would you like to add netlink support for the missing files as well?=
=20
> (gateways, bla, dat, nc)=20
>  * Would you also like to do the batctl support? I guess we can have ba=
tctl=20
> behave "compatible" by trying netlink first and fall back to debugfs fo=
r the=20
> next few years
>  * Also open is the icmp socket stuff, which we could postpone and impl=
ement=20
> later.
>=20
> Just wanted to check with your availability first, but we would like to=
=20
> support the netlink adoption. :)
>=20
> Thanks!
>      Simon
>=20


As Andrew has already started to integrate and extend my patchset, I'll
happily leave further development to him - I'm quite busy with other
projects at the moment, so it would probably take a lot longer if I were =
to
work on this myself.

As I've mentioned before, regarding the batctl support, I'd love to see a=

little library ("libbatadv"?) on top of libnl that could be used by batct=
l,
alfred and other monitoring tools (like the ones we are using in the Gluo=
n
Freifunk firmwares).

Regards,
Matthias


--vUf8uMhRC2LgLMjxSa5TKp8UGREHQ3JP7--

--hDhB293lqCpcaLNgsmB7u22WQ0XlT8FQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXFzCEAAoJEBbvP2TLIB2ckNAQALvVAwdO1KfYW86zFs+kgvfF
rNrPp1g27o9tkEyD3RBc0/F1ckyuShNOTk/7slDdHCtCyfrlm+yRkLm0cvPJvUAn
oKe3rE+GyXZu44jWIcKdeWr8ZZQv7LwFblXbVUiL28xvltsiOW2eziJ3ANRDBiI7
LvG4R8KORWry8TR73HZ8AL1vWy+zTVjJ7zUUnF5Th6yuLYncp3Q4vfNN42zRAsfN
CLnqATEtK0yd2cymAbW+0/2oO+7GRLEuDFNsob3os45oshwtyw5KuhkyAT9UJYPs
W0C/UJ4I6xvzwNTt7LgTsv/2fgQMx66Y1xoiy6ZdiNzngmAU3ZzZ6VfIjxB+YkkZ
TQcZYJKOSM2V8CTAiJHT3QxkGAF3rVvMLpZcRJPFlIi2hypmzOnu66kFyUAyj7uq
RkjIN8YSsBV12tsG4zX5iYqsIU/7BuYDb635w/eqm0LRAP3Xw/OaJEymxWBYVyM8
K+MAtTgBlaMEP5IMbUTYsmDSLLhdjih9nidPxFCCiekKUHMhpI77K9oVhbefD3yC
RQV3CVg2jZvUDf0lYl27fWz6CrHkHqo6rINmf9vkfHgagtr4a6/a9l7DeVUdEoQM
yAu42j4l7iaNJDQjt7DYudGVKgsavPov/V9rCi68i/4u11HNQpHLk8g51UD/BnnY
R2ddh3Rbr5FiyLMu2JbN
=gbp1
-----END PGP SIGNATURE-----

--hDhB293lqCpcaLNgsmB7u22WQ0XlT8FQX--
