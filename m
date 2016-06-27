Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Jun 2016 09:52:45 +0200
Message-ID: <11032818.o7fJnuSa5X@bentobox>
In-Reply-To: <CAM3k=86OU_+ZX8TqiBrLAqe446Z1YNGpD7WtH+BxPanrksjoAA@mail.gmail.com>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <15442021.aXYrkMLT6N@sven-edge>
 <CAM3k=86OU_+ZX8TqiBrLAqe446Z1YNGpD7WtH+BxPanrksjoAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2724370.O0nLt11urT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sailash Moirangthem <sailashm@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2724370.O0nLt11urT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 June 2016 12:58:24 Sailash Moirangthem wrote:
> Hi Sven,
> This question may sound dumb. But I need your help in this please. I
> upgraded my openwrt to the latest version 15.05. I then tried
> installing kmod-batman-adv. It gave me error:
> 
> satisfy_dependencies_for: Cannot satisfy the following dependencies
> for kmod-batman-adv:
> kernel (= 3.18.14-1-406f55e08cbd4433be5683443e405921) *
> 
> I followed the following steps:
> 1 . Note: If you downloaded an Openwrt release but intend to build the
> latest batman-adv package you might need to modify your
> feeds.conf(.default). Make sure you have "src-git routing
> git://github.com/openwrt-routing/packages.git" instead of e.g.
> "src-git routing
> git://github.com/openwrt-routing/packages.git;for-12.09.x".
> 
> This doesnt seem to work. Can you please tell me the steps on how to
> install the latest batman-adv in my 15.05 openwrt firmware. Thanks a
> ton.

Not sure what this has to do with the the problem you quoted earlier.
I would just have done following to generate 15.05 images which already
include batman-adv:

    git clone git://git.openwrt.org/15.05/openwrt.git openwrt-15.05
    cd openwrt-15.05
    ./scripts/feeds update
    ./scripts/feeds install kmod-batman-adv
    ./scripts/feeds install batctl
    cat << EOF > .config
    CONFIG_TARGET_ar71xx=y
    CONFIG_TARGET_ar71xx_generic=y
    CONFIG_TARGET_ar71xx_generic_Default=y
    CONFIG_KMOD_BATMAN_ADV_BLA=y
    CONFIG_KMOD_BATMAN_ADV_DAT=y
    CONFIG_KMOD_BATMAN_ADV_MCAST=y
    CONFIG_PACKAGE_batctl=y
    CONFIG_PACKAGE_kmod-batman-adv=y
    CONFIG_PACKAGE_kmod-crypto-crc32c=y
    CONFIG_PACKAGE_kmod-crypto-hash=y
    CONFIG_PACKAGE_kmod-lib-crc16=y
    CONFIG_PACKAGE_kmod-lib-crc32c=y
    EOF
    make defconfig
    make -j$(nproc || echo 1)

(make sure you remove the "    " in front when you want to copy+paste the
commands).

You can find the generated images in bin/ar71xx/

Kind regards,
	Sven

--nextPart2724370.O0nLt11urT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXcNtNAAoJEF2HCgfBJntGvhsP/icdQQ6J+y+ztJ8U2CE0F52q
X1QGAtvUAG/gaMV8a2+2FndL/EPv/ri0QPDZj4PSuUC2jKsYE0IjuZxM7E2Y1SHg
stEPZVR3OCN9v4lvL1nzc/I3mp0x6G9JFSM2iLnD79c7MkBBWOW1jW6oylU1kLwF
aNcYPqySKpId/uWMkTNuZiWTATzb/RhISObeNJgGqDpji9QBpbJhUlTtGM/6hKPV
Ta/I0xfDIRd2472HLX/nq97ZQnqcZ1p8T4aS08mu0S+9nxPvAK6gDL72donqbjM4
vNXTb5Vkmoc4+JIlvvrgYu5xAtWl1Amq6q/1/AsA98QDTz346SgJ7zBtZDOItEKm
B+E/z4GMwHxtLUo4M/t48RB8ZJk5KYgyASSvSLJzHxxM1N+jdD77zQK3AvaB1pzP
sswkLMj1gCITpES8MchuVxE46Ea2LwGENzSTSnIY2EGMkurzqtFjDznZto/NrQnZ
5pk1hbUDE3TyGp4A16P3FAwT4DeCOhqg7dB+Ex/lpz1okR7tCH9gk0Xk0RRDCwoj
qdOHc1SdNj+P3RuRO06TYxN1/FVT8BtMykqz8ayVvj+fU9ykmBlm+QUvOgpxnUgS
PMsWbYyyDjvzLrYBdIEnNKhRu1WmVOXgdAa3lTj7YWYnlDpLT9t1Qj0InvFBPbnH
FtbeeEKvNxC3Z+sJSX4/
=a8g8
-----END PGP SIGNATURE-----

--nextPart2724370.O0nLt11urT--

