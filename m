Return-Path: <a@unstable.cc>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
 <20151219080405.GJ30160@otheros> <1831238.xY0O8bfIys@bentobox>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <56753ACE.1070302@unstable.cc>
Date: Sat, 19 Dec 2015 19:09:02 +0800
MIME-Version: 1.0
In-Reply-To: <1831238.xY0O8bfIys@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I2Q7F8xmjBeOafJwqOTgvPlsKiJnKfS3Q"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
 doing mcast_free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Simon Wunderlich <simon@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I2Q7F8xmjBeOafJwqOTgvPlsKiJnKfS3Q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 19/12/15 17:32, Sven Eckelmann wrote:
> On Saturday 19 December 2015 09:04:05 Linus L=FCssing wrote:
>>> From: Simon Wunderlich <simon@open-mesh.com>
>>>
>>> While testing, we got something like this:
>>>
>>> WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142 batadv_mca=
st_mla_tt_retract+0x94/0x205 [batman_adv]()
>>> [...]
>>> Call Trace:
>>> [<ffffffff815fc597>] dump_stack+0x4b/0x64
>>> [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
>>> [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205 [batman=
_adv]
>>> [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
>>> [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batman_a=
dv]
>>> [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
>>> [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
>>> [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
>>> [...]
>>>
>>> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
>>
>> Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with ext=
ernal lock via lockdep")
>> Acked-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> I am confused why this should fix a commit which is there to find such =
problems.

Am I wrong or also the commit message is misleading? Looks like it is
"fixing" a bogus lockdep check...but as far as I can say this patch is
making sure that the lock is held in that particular point.

If we want to "fix the lockdep" then we should remove the
lockdep_assert_held(), but I don't think this is the goal of the whole
discussion.

Cheers,

--=20
Antonio Quartulli


--I2Q7F8xmjBeOafJwqOTgvPlsKiJnKfS3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWdTrSAAoJENpFlCjNi1MRpS8QAIHDhwVTUKP+OBqdTUzFaPMu
uVcCYY9GlQvDu5N4lI0qyMxdev39OGX32NxQslxrKRehjB6c5DEKElv/ySZCKYaS
Qj7GZDiQ6DHTfnd4M5XCw0eN/jzzejpytAV1CvowgtyhvWBisA8DPF+TbzVQ+ljR
iDXBKN2Z+RWC8JTmZjCeCzRUjPydBNgQAI7OXOZeHeC2x+WOoH+KtWotAKiuhoLc
ZqIDlb7Q/LV+Jbd+3rzI1tjkCKcD29iqAlQRttAnjfpeD3DcOe7kxm7UK7441ZSk
eaGrOXicw6huPESnb2DrZnE0iSzNkNWfcMeXI/0kbH5M+j7UQW10ATK1J3OBuHjO
Xh9z/DxkBwQkJDM6cu/9Kwl9emfNSG1JziJvTV/T8dZ7VoL4AU+HqfXb2FFZPAPJ
qzNHJQtawH2FsCUHAPdYvcw1T7JuaWgiQeLy+xqkMokjNTr+TcrcOWtuMiwzWaU1
8dKv6FX0e1FiYOLSQqHCLylf/ifYZ8z9uYeswt8eUSqxXQHJhFKrEdxAM0VVdhp0
3mAvzt8g1Oaiy37zjAbU0AgheWx8MroZ6FzUdG/uy40bubuEyaikQbukS9ITbImg
QfmnpsH1ZXP6tGjW5rAZPBqgBAROC+JU38vNju6h99lYiS1cu/McAOgFHF5++hOt
r7O213zD9BG4yikVQGOx
=I83G
-----END PGP SIGNATURE-----

--I2Q7F8xmjBeOafJwqOTgvPlsKiJnKfS3Q--
