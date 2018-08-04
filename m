Return-Path: <a@unstable.cc>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-8-mareklindner@neomailbox.ch>
 <8211925.JcgYpGFXDF@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <314bf0ac-4c10-da7a-d527-45afe92423fa@unstable.cc>
Date: Sat, 4 Aug 2018 16:41:09 +0800
MIME-Version: 1.0
In-Reply-To: <8211925.JcgYpGFXDF@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2grUkswf9r86Ead9MTHJtvSAE0jAuBWjU"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2grUkswf9r86Ead9MTHJtvSAE0jAuBWjU
Content-Type: multipart/mixed; boundary="pYODuKUdasrShx1cryhq6ZCKSvRBbUTJQ";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <314bf0ac-4c10-da7a-d527-45afe92423fa@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-8-mareklindner@neomailbox.ch>
 <8211925.JcgYpGFXDF@sven-edge>
In-Reply-To: <8211925.JcgYpGFXDF@sven-edge>

--pYODuKUdasrShx1cryhq6ZCKSvRBbUTJQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 21/05/18 22:34, Sven Eckelmann wrote:
> On Freitag, 18. Mai 2018 03:47:54 CEST Marek Lindner wrote:
>> When the ELP throughput meter fallback kicks in to trigger
>> a throughput meter measurement the test duration can be
>> configured via this attribute.
>>
>> Default tp test duration: 1000ms
>>
>> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
>> ---
>>  Documentation/ABI/testing/sysfs-class-net-batman-adv | 7 +++++++
>=20
> Please discuss this with Jiri [1].
>=20

After re-reading Jiri's points I can't really understand why we should
now switch to netlink. I think all our sysfs knobs are used to inject
settings *to* userspace, therefore his point 1) does not really apply to
us. Point 2) is a bit generic and does not really explain why we should
*switch*.

This said, I'd rather keep this patch as it is and possibly discuss the
matter when sending this code to netdev for merging.

I've discussed this with Marek too and he is fine with this approach.

Cheers,
>=20
> [1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-May/017814.h=
tml
>=20

--=20
Antonio Quartulli


--pYODuKUdasrShx1cryhq6ZCKSvRBbUTJQ--

--2grUkswf9r86Ead9MTHJtvSAE0jAuBWjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltlZqUACgkQB6U8WA7y
zXRl3xAAj6e1GPkow6yN6ZRmz3vriqCKYRPazEd8SofiNkQxjE4blyeGFuVtWBDb
opDR8bfP+22fKWDHYxxonwDR2cXQnvUpe9JwXC7Qj0HxuRHvv224HTnyii3N9mu/
fqA1mh+myDk0XLOfsqovmsg0A8oBQg3bruDdW6SI4UZcWsWi7j5NbDikzy3PH0s9
ioim+qcFu43fc7cuSx4Bb6uCYMG0PsAM2YDdylsrgq3HieE97ETiqYRMn0o1WUH2
gUoPZun1XVhPZe8QXTDK/Mjtiw3J3nmSWzjClsnQfJvQKocVWP8WlUAiDUXzBkBC
cGT25S7hQPErtY4sFRSqNxTzEYmkK1cnZePpf/dB234gliKWPEGDjPpEkLz7JLW1
r3Ob+jaqDrAixpAPQRdrM0WeYh4WPCZeUPvxw5UhYYe7JXAdt6bmpn9eAAjvUW1v
NGEo4cnNlKG+BG7fa7pjg2r4VmRffpojuuF/3lJRx9ikCF8V8OU554rwRqhEO66c
QH2XUYmUwsK/Cef3l33/TKsPTeI9BbBL3r13jEm3mNpL16b+s+XX7/9blVz9Tnj5
rZo6uZVkTQU5unzjBZcuXOQRiFDJGOVE3l/A7fvDjz+AL7hgYv/YHD5mTxCPtSiC
R1bzezS1ItUERxH2owpQUeQ6Kip8SqvB9NxD+nZ7z1maxJF/Jd8=
=mYwx
-----END PGP SIGNATURE-----

--2grUkswf9r86Ead9MTHJtvSAE0jAuBWjU--
