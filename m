Return-Path: <antonio@meshcoding.com>
Message-ID: <54A4388D.40202@meshcoding.com>
Date: Wed, 31 Dec 2014 18:55:25 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
 <549EC29D.1070408@meshcoding.com> <20141227170317.GB10331@pengutronix.de>
In-Reply-To: <20141227170317.GB10331@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FpTA12FdlhCigeE0Nik5xCqn44EJjt7R3"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 25/26] batman-adv: packet.h,
 add some missing includes
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Markus Pargmann <mpa@pengutronix.de>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FpTA12FdlhCigeE0Nik5xCqn44EJjt7R3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus,

On 27/12/14 18:03, Markus Pargmann wrote:
> Hi Antonio,
>=20
> On Sat, Dec 27, 2014 at 03:30:53PM +0100, Antonio Quartulli wrote:
>> Hi Markus,
>>
>> first of all you should know that I really appreciate your hard work.
>> Thank you very much for this!
>>
>> On 26/12/14 12:41, Markus Pargmann wrote:
>>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>>> ---
>>>  packet.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/packet.h b/packet.h
>>> index facd1feddd4e..5fd0d814b6de 100644
>>> --- a/packet.h
>>> +++ b/packet.h
>>> @@ -18,6 +18,11 @@
>>>  #ifndef _NET_BATMAN_ADV_PACKET_H_
>>>  #define _NET_BATMAN_ADV_PACKET_H_
>>> =20
>>> +#ifdef __KERNEL__
>>> +#include <linux/bitops.h>
>>> +#include <uapi/linux/if_ether.h>
>>> +#endif /* __KERNEL__ */
>>
>> Unfortunately we can't do this :-(
>>
>> Patches sent to the kernel cannot contain conditional code on being in=

>> the kernel or not (same is true for checks against a particular kernel=

>> version - such code can't be in the kernel).
>>
>> Patches sent to the kernel must assume that they are only for the kern=
el
>> (and for that particular version we are sending the patches against).
>=20
> Oh, I checked by grepping through the kernel before changing the patch
> like this.
> 	git grep "^#if.*def.*__KERNEL__" | grep -v include | wc -l
> 	145
>=20
> So there are 145 uses of an ifdef __KERNEL__ outside of include
> directories (I excluded include directories as they may be exported to
> userspace). So I thought it would be ok.

these are probably pieces of code that have not yet been cleaned up.
Still, this does not allow us to introduce more code like this: David
(the networking tree maintainer) would refuse such additions.


Cheers,

--=20
Antonio Quartulli


--FpTA12FdlhCigeE0Nik5xCqn44EJjt7R3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUpDiWAAoJEJgn97Bh2u9edbMQALFLMhQ4qTFFNDbIbTiBzCaf
ropj721bf/D5iIlCDQmY1caE6qSQ0QjEzRMaZpAZQ5QKfwf8ryRccpzGkyW77Rqy
JPhv6UBZr6nmnaOsldUy0GKFo6jWDFazfJiIwYF6gNEG0DSjaP66bbEPRbtMlnDI
yskZawgfznCnagQ4dJLk8k0/ffewG2vUjePkWn9ShcKPowRcr1BkMA3sdZtkQwi2
o+rLZX30/jACZN2JJiODDlEUVCIaKZwuq5uqXXF5tYEgINWtUJfw4ZyScVDRnNPT
7Yt5n9mhwa9ayqgTTwV+EhDmOqt3ZSPOt1XeMWKsUHl+nUfUfnooetNIILu+YjyX
lqItKKuUo5I2zEihT/+Hy0MhDnD5USpvXuhgr22y2RwgwaW9+/xUMq0ghx8eedHG
fJiGXwWNWiD4rAyoiRewiP/VRYlYUHZN6ZQP45Ku6AMnRVPbN4UJHx+/zc1xoIwl
OOnv6OWEeaG4pT9CtZyeQxwuleHoEn0iTxhCphKZ5WVxXMVdUXYtBSOcajwDJeyd
e7CbqSj5EZp60a5J3S1TPn5UwmpGl1jldArOI+ZoC71I9wDVbcbsPWtCh/lyrIP3
og9/fR6dLt6P3Da3krywbxdb/CCsdpepJdyHRILU+zxFNV4CVK2HqNfxVfBidl1M
8z+4lkJv+TLReNvh5Qv3
=70R6
-----END PGP SIGNATURE-----

--FpTA12FdlhCigeE0Nik5xCqn44EJjt7R3--
