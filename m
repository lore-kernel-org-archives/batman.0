Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
 <2357913.Ue9Sgfg8BR@sven-edge>
 <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>
Message-ID: <b5dbfebb-0d14-e1e2-5e8f-3bdc35b664b9@universe-factory.net>
Date: Tue, 23 Jan 2018 10:12:30 +0100
MIME-Version: 1.0
In-Reply-To: <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lurJezHhueYsFIZni4M5dsZVRpFuh70au"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
 receive path
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@sdn.clinic>, Mephisto <mephisto@mephis.to>, Felix Kaechele <felix@kaechele.ca>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lurJezHhueYsFIZni4M5dsZVRpFuh70au
Content-Type: multipart/mixed; boundary="3Mc2nJeQ8emYEKAvN5TRLY8l1HoQ6LFoM";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@sdn.clinic>, Mephisto <mephisto@mephis.to>,
 Felix Kaechele <felix@kaechele.ca>
Message-ID: <b5dbfebb-0d14-e1e2-5e8f-3bdc35b664b9@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
 receive path
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
 <2357913.Ue9Sgfg8BR@sven-edge>
 <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>
In-Reply-To: <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>

--3Mc2nJeQ8emYEKAvN5TRLY8l1HoQ6LFoM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 10:18 PM, Matthias Schiffer wrote:
> On 01/22/2018 09:52 PM, Sven Eckelmann wrote:
>> On Montag, 22. Januar 2018 20:24:50 CET Matthias Schiffer wrote:
>>> skb_postpull_rcsum() is necessary after eth_type_trans() to adjust th=
e
>>> skb checksum, otherwise log spam of the form "bat0: hw csum failure" =
will
>>> result when packets with CHECKSUM_COMPLETE are received (at least in =
some
>>> setups, e.g. when stacking batman-adv on top of VXLAN).
>>
>> Would be nice to have a better explanation here.
>>
>> The comment previously assumed that skb_pull_rcsum would be enough. Bu=
t the=20
>> problem here is that the skb_pull_rcsum only pulls the batman-adv head=
ers. The=20
>> actual pull of the ethernet header (with skb_pull_inline) happens insi=
de=20
>> eth_type_trans. Or did I miss anything?
>=20
> This is correct, eth_type_trans() contains a simple skb_pull(), so the =
csum
> must be adjusted afterwards (grepping the kernel for eth_type_trans wil=
l
> find a lot of this). I can send a v2 with a better commit message later=
=2E
>=20
>>
>> [...]
>>> I don't know what the exact circumstances are that trigger the log sp=
am,
>>> but it seems this was broken forever (I could also reproduce the issu=
e with
>>> our compat-14 legacy branch)... so please ask David to queue this up =
for
>>> stable :)
>>
>> Yes, this is broken since earliest commits. The most relevant commit i=
n=20
>> batman-adv is:
>>
>> Fixes: fe28a94c01e1 ("batman-adv: receive packets directly using skbs"=
)
>>
>> But I would propose to use following in the kernel tree:
>>
>> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
>>
>> The 4.15 release will be soon(tm) and Simon is currently on vacation. =
So we=20
>> will most likely postpone the submission to David until Simon found a =
way out=20
>> of the snow and after 4.15 is released...
>>
>> But it would be nice when some people could test the patch [1] (togeth=
er with=20
>> vxlan?) on batman-adv or batman-adv-legacy. And please provide a=20
>> "Tested-by: Full Name <email@example.org>" [2] reply when it works.
>>
>> Thanks,> 	Sven
>=20
> I've tested this on Kernel 4.14.14 (everything working correctly now) a=
nd
> 4.4.110 (here, there are still checksum errors; it seems on older kerne=
ls,
> the checksum handling in VXLAN is broken too? Still debugging this...)

I've found the issue of this other checksum problem: batman-adv
fragmentation code doesn't handle the checksum on reassembly at all. I
think the best option here is to simply set ip_summed to CHECKSUM_NONE on=

reassembly, I will send another patch for that.

The IP fragmentation code does more fancy things when all fragments have
CHECKSUM_COMPLETE, adding up the checksums of the fragments under certain=

circumstances. This only works because IP fragments are guaranteed to be
split at even byte offsets (multiples of 8, actually); as far as I can
tell, batman-adv allows odd fragment sizes, making it impossible to add u=
p
the 16bit checksums in the general case.

Matthias


>=20
>=20
>=20
>>
>> [1] https://patchwork.open-mesh.org/patch/17250/
>> [2] https://www.kernel.org/doc/html/v4.12/process/submitting-patches.h=
tml#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>>
>=20
>=20



--3Mc2nJeQ8emYEKAvN5TRLY8l1HoQ6LFoM--

--lurJezHhueYsFIZni4M5dsZVRpFuh70au
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlpm/H4ACgkQFu8/ZMsg
HZz2eBAApV4LazQA/CPEtTZ/laz3N6ocAcjVWhMCYsdZPujARMoUdJbUTRCoTvy6
h7x5TShGkLh0rDXb3JNIVr2lreas1qpOT9XXl56GNdT9erjK9l0UEERvsShH7U4+
ydMXZiloiTSjFL8uhN+Yz2+1iJDROB9aH6LI5XzvMkK5OF1qPAOy+QXLoKXl3QAa
8xzwvn0lQnXtzfvcAMdb888uyEf6DCqWg+dx8Jm4VYChJnzZQzLan/tSCr8KoDWE
A29pabw1vHYT4D+kNKbXZySVzTQfioBE5R2L435CJ0xYFuoX/0wTcDQ+Ulgdzcp8
NKdeCFkmhXyejizDmP0uoU5Ow7hxI6VA/p114ioZn3m8mgG5kKF2kagt8yH5TXas
uMSCaKVjRXtT6GMADwZTavJupB/J41zdaByVLijpiHM6ItoqE/BRIgF8JohFBzWZ
ThTlq8Bv1zmNVEm/FHvjtgjwEHQJ33xn2wKSo0+WLNU1mPrfEzp3bnZZrdNUyl2+
0JYTrIxQ4LJy0uZNJv8dvCUioV58NK6EaoCgsQnKxlCcUBR+7koBjqAaUIW8Sbq5
EEjwNugP1m6FphTyPfcXeuDMdmJJmxYxUCeWyX37BDMFtErw1IH6aZ82yh9Y64YL
evztFTBXWj+6KN9/jtvHpUNDwYKdOf/dQqVy1UwXMAK95onFMxg=
=G6yD
-----END PGP SIGNATURE-----

--lurJezHhueYsFIZni4M5dsZVRpFuh70au--
