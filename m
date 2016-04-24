Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 24 Apr 2016 09:07:48 +0200
Message-ID: <34799063.arva0MJYP7@sven-edge>
In-Reply-To: <20160419022218.GE17647@otheros>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <3374405.0Pi9Duaxya@bentobox> <20160419022218.GE17647@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1575058.BFnV4fj8cR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 2/4] batman-adv: Add multicast
	optimization support for bridged setups
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1575058.BFnV4fj8cR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 19 April 2016 04:22:18 Linus L=FCssing wrote:
[...]
> > Why must there be a special compat-sources/*.c file for these tiny
> > functions?
>=20
> I think it is necessary because of the missing stubs in 3.16.
> 3.16 has the function declarations in if_bridge.h but without
> function definitions if the kernel is build without bridge
> (snooping) support.
>=20
> Adding simple inline functions in compat-include/linux/if_bridge.h
> for these functions would yield a compile-time error for the 3.16
> kernel without bridge (snooping) support case: The declaration is
> always there in 3.16's if_bridge.h include which would clash
> with a self-made inline function in our compat-include's
> if_bridge.h.

Couldn't you #define the names to a different name which you then use. =
An
example for this can be found at

https://git.open-mesh.org/batman-adv.git/blob/HEAD:/compat-include/linu=
x/ethtool.h

Kind regards,
=09Sven
--nextPart1575058.BFnV4fj8cR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXHHDEAAoJEF2HCgfBJntG9toQAIkzD6e8SOGefIg93t6/Ofcb
jblpP9es08p6X4yP5CmHuwlFcfPop8s/oH/Zi/20L6WwWIg2k+0UI6kByNgPSwgC
ArynfQlP4sYSWJ2c6wNuLSbszz1169Ma4IzSRSYfhSBPl7JqsoF12Yd2RD8lUZnO
dfJAg6cSmxv/Vchg0H+9ZBSSIc9ujvnSBges6q5OZ+rAXIgnzT2nQn3yAh4pKoxg
xm8IZY9B+vK9N7hxgWDjZUOw20FkWw1lAa/7Uhb0QbSP9Pm48c/dOOrd4d26ybnE
JjTJYu28Is4D4ZWgfgJDYNXAUKYF5g931kRNl/beBiLKWcyYZpC1GLnYeSnZeZod
/6LvwD/qZuxeD0kVDrnapcL3HBcaK8xP/Jjy7nl/3OLhwd1NOEGxJc+g+yP5luG1
s41vXVjVaA194q3AA9h8ymKnxHkmeh+7ASPWmtQub5s/9ZwHm8y1kjRFQCIZJbjJ
gZZvo75+SjANxpirSZ1cIUk45JvQxz40zMcTllOrQOGSO6s9hsExEzq99o7qY2+3
OhNNAXWG0IUeebzVNNOvVRuxr+ltcclWFjJlzy7bFXrrv2E9YEIs1dRhxdm4X4zp
X2CRhJE9eHZfan/hDsiHSo1hAt1bnn4nHYh4pj0fdriQDeEK14EMy2VR7hJ1QKrz
lV0Cwf7mnpHZPcHCAfu0
=Do1f
-----END PGP SIGNATURE-----

--nextPart1575058.BFnV4fj8cR--

