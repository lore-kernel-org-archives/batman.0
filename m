Return-Path: <antonio@meshcoding.com>
Message-ID: <5321B5AE.9080005@meshcoding.com>
Date: Thu, 13 Mar 2014 14:42:06 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
 <53218FEB.8000100@meshcoding.com>
 <CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>
In-Reply-To: <CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I0U6It4T2A47s6oHIdvepXtmK7IiS6jJu"
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I0U6It4T2A47s6oHIdvepXtmK7IiS6jJu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 13/03/14 13:20, Itamar Landsman wrote:
> Thanks Antonio,
> I appreciate the quick reply.
>=20
> batctl -v returns: batctl debian-2012.1.0-1 [batman-adv: 2013.2.0]
>=20
> Should I compile and install from the latest git?
> I see that the batctl command is from a much older release.. It
> doesn't support the dat or dc parameters. Should I compile that one as
> well?

The recommendation is to always run the same version of batctl and
batman-adv, exactly to avoid this kind of situations where you have a
feature in the kernel module that cannot be used by batctl (I have to
say that you can use every feature *without* batctl, but if you want to
use the tool it is better to get the right version).

The batman-adv version you run is also rather old. I'd personally
recommend to wait one or two days for the next release and then download
it (yes, the developers are in the process of releasing it).

However, here[1] you have a description of the sysfs interface that you
can use to quickly check the DAT status without doing any upgrade.


Cheers,


[1] http://www.open-mesh.org/projects/batman-adv/wiki/Tweaking

--=20
Antonio Quartulli


--I0U6It4T2A47s6oHIdvepXtmK7IiS6jJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTIbW9AAoJEEKTMo6mOh1VTj8P/j6Wj+Kbk0CkB5gyCa/+e0QZ
/s6mmWqcc2A8aO9KoF+cMXPmBFGcNC0Z0EP4GqrK7bsUBhJUJBpPyGHs1v5Zxjlv
xdxYuHk06omWw5tr/mFmtxI9eNJRsfN0JLNgSp7JmYB1IwIMJShPG5aYUyM2T1Og
+QbN8ldl/+vq65O/eum5ZKnWBsQpDtHc8Ku8aVVtJcjqMl1cAtERRhw3ji9Qhhyw
+TCR3olWdnGcPTVzLox+VeopXuHlOyRYPtWGyPfwJPRko0GTnu9oZ8XYldr6SNAk
+Q58aoDRShvPk4rDchWF2PTPaqSoVpA4E/lxqKIvP2X/gXtuf/sL9pN058dsI5yk
XLwHqIFEHalHrCDDtTeHc18aKUhiXz+H+LElig2X+/NyVSAn7qyetK1sJMIOQ17z
5AQIlCrQ/OlqsSFfYN4bzAE03Qj6Ts5gEYu+jddteZQ/QSjlDh0O6RiO3Jt3OJy2
SXKEA/SRwTyMYQJW/zVj0q7/aq3QrCUrQTW5kLV+j0EiNIJ4vM0j7UlPu4ijlcjC
sKCSz8XZ/qTgf5n4CjFWLRWDtuhfMrp6L2kBlEzLDsvfF8xhE9c/B1NGTZdPxvyR
DJjhI/m/xZgCAXhUdfQJ5tzHmGyPcrSX+x91yLfiVxNiSgeWOvdXwQHIdPDdXIst
ZSovew2dQX8JQHrnO/CC
=4k5X
-----END PGP SIGNATURE-----

--I0U6It4T2A47s6oHIdvepXtmK7IiS6jJu--
