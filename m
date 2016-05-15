Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 11:01:49 +0200
Message-ID: <14782760.76OAvrCygB@sven-edge>
In-Reply-To: <5189010.X6E9Ozq1lq@sven-edge>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <20160508163324.GC14515@prodigo> <5189010.X6E9Ozq1lq@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4170877.oAqXmWL42S";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
	attribute for sysfs helper function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch

--nextPart4170877.oAqXmWL42S
Content-Type: multipart/mixed; boundary="nextPart3946135.CqBrSdG93e"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart3946135.CqBrSdG93e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 08 May 2016 18:59:56 Sven Eckelmann wrote:
[....]
> Now you can for example run the build tests and receive the mail:
> 
>     REMOTE=/home/sven/tmp/qemu-batman/batman-adv TO=sven ./checkstuff.sh

The repo was updated to support the multicast patches. I've also introduced 
other helper code which automatically sets the TO to the current user and 
makes it easier to select the branches/Linux versions to test. For example a 
"fast" (like in "only enough time to make a cup of tea") test would be:

    REMOTE=/home/sven/tmp/qemu-batman/batman-adv \
    TESTBRANCHES="ecsv/misc_patches" INCOMING_BRANCH="ecsv/misc_patches" \
    LINUX_VERSIONS="linux-3.2 linux-4.5" \
    ./checkstuff.sh

> Or you can extract the relevant part of the script (see attachment - file
> paths have to be adjusted; build_test.git with prepared headers is still
> required) and run it manually. Please make sure that you've committed your
> changed before running it because it will remove your local changes.
> 
>     sh ~/tmp/testheaders.sh

Some adjustments were necessary for the support of the new multicast compat 
stuff. I have updated the minimal-test shellscript (see attachments).

Kind regards,
	Sven
=2D-nextPart3946135.CqBrSdG93e
Content-Disposition: attachment; filename="testheaders.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="testheaders.sh"

#! /bin/sh

LINUX_HEADERS=/home/sven/projekte/build_test/linux-build
LINUX_DEFAULT_VERSION=linux-4.5
IWYU_KERNEL_MAPPINGS=/home/sven/projekte/build_test/testhelpers/kernel_mappings.iwyu
FIX_INCLUDE_SORT=/home/sven/projekte/build_test/testhelpers/fix_includes_sort.py

spath="./net/batman-adv/"
bpath="./net/batman-adv/"

MAKE_CONFIG="CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_BATMAN_V=y KBUILD_SRC=${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}"

# don't touch main.h, bat_algo.h and files which are required by linux/wait.h, packet.h
sed -i 's/#include "main.h"/#include "main.h" \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for linux\/wait.h \*\//\/\* for linux\/wait.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for packet.h \*\//\/\* for packet.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG || exit

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG clean
make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" -j1 -k CC="iwyu -Xiwyu --prefix_header_includes=keep -Xiwyu --no_default_mappings -Xiwyu --transitive_includes_only -Xiwyu --verbose=1 -Xiwyu --mapping_file=$IWYU_KERNEL_MAPPINGS" $MAKE_CONFIG 2> test


git add -f "${bpath}" "${spath}"
fix_include --nosafe_headers --separate_project_includes="$(pwd)/${bpath}" < test

# remove extra noise
git checkout -f -- compat-sources
sed -i '/struct batadv_algo_ops;/d' "${bpath}"/main.h
sed -i '/struct batadv_hard_iface;/d' "${bpath}"/main.h
sed -i '/struct batadv_orig_node;/d' "${bpath}"/main.h
sed -i '/struct batadv_priv;/d' "${bpath}"/main.h
"${FIX_INCLUDE_SORT}" --sort_only "${bpath}"/*.c "${bpath}"/*.h

git diff > asd
git checkout -f
less asd

=2D-nextPart3946135.CqBrSdG93e--
This is a multi-part message in MIME format.

--nextPart3946135.CqBrSdG93e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 08 May 2016 18:59:56 Sven Eckelmann wrote:
[....]
> Now you can for example run the build tests and receive the mail:
> 
>     REMOTE=/home/sven/tmp/qemu-batman/batman-adv TO=sven ./checkstuff.sh

The repo was updated to support the multicast patches. I've also introduced 
other helper code which automatically sets the TO to the current user and 
makes it easier to select the branches/Linux versions to test. For example a 
"fast" (like in "only enough time to make a cup of tea") test would be:

    REMOTE=/home/sven/tmp/qemu-batman/batman-adv \
    TESTBRANCHES="ecsv/misc_patches" INCOMING_BRANCH="ecsv/misc_patches" \
    LINUX_VERSIONS="linux-3.2 linux-4.5" \
    ./checkstuff.sh

> Or you can extract the relevant part of the script (see attachment - file
> paths have to be adjusted; build_test.git with prepared headers is still
> required) and run it manually. Please make sure that you've committed your
> changed before running it because it will remove your local changes.
> 
>     sh ~/tmp/testheaders.sh

Some adjustments were necessary for the support of the new multicast compat 
stuff. I have updated the minimal-test shellscript (see attachments).

Kind regards,
	Sven
--nextPart3946135.CqBrSdG93e
Content-Disposition: attachment; filename="testheaders.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="testheaders.sh"

#! /bin/sh

LINUX_HEADERS=/home/sven/projekte/build_test/linux-build
LINUX_DEFAULT_VERSION=linux-4.5
IWYU_KERNEL_MAPPINGS=/home/sven/projekte/build_test/testhelpers/kernel_mappings.iwyu
FIX_INCLUDE_SORT=/home/sven/projekte/build_test/testhelpers/fix_includes_sort.py

spath="./net/batman-adv/"
bpath="./net/batman-adv/"

MAKE_CONFIG="CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_BATMAN_V=y KBUILD_SRC=${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}"

# don't touch main.h, bat_algo.h and files which are required by linux/wait.h, packet.h
sed -i 's/#include "main.h"/#include "main.h" \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for linux\/wait.h \*\//\/\* for linux\/wait.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for packet.h \*\//\/\* for packet.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG || exit

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG clean
make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" -j1 -k CC="iwyu -Xiwyu --prefix_header_includes=keep -Xiwyu --no_default_mappings -Xiwyu --transitive_includes_only -Xiwyu --verbose=1 -Xiwyu --mapping_file=$IWYU_KERNEL_MAPPINGS" $MAKE_CONFIG 2> test


git add -f "${bpath}" "${spath}"
fix_include --nosafe_headers --separate_project_includes="$(pwd)/${bpath}" < test

# remove extra noise
git checkout -f -- compat-sources
sed -i '/struct batadv_algo_ops;/d' "${bpath}"/main.h
sed -i '/struct batadv_hard_iface;/d' "${bpath}"/main.h
sed -i '/struct batadv_orig_node;/d' "${bpath}"/main.h
sed -i '/struct batadv_priv;/d' "${bpath}"/main.h
"${FIX_INCLUDE_SORT}" --sort_only "${bpath}"/*.c "${bpath}"/*.h

git diff > asd
git checkout -f
less asd

--nextPart3946135.CqBrSdG93e--

--nextPart4170877.oAqXmWL42S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXODr9AAoJEF2HCgfBJntGeM0P/1NXovcPrna+Fo/92siZZhbP
suFMZ8DpebLPG9Uvrl4EfgEvA0hh7QYYSUJOuJ5HlXGXBXWpfXDqaKQdqfkwHaTI
HNDbo5LAZka5GqraJYJ6B9NqAd4RrA7WIPfvi9SPKFGOhhDZkV/nXMF94MG0pHSk
ZEIEv/sJOLWm0cnLGs4CQk4sQOpuq6ViAts/Bh/brDZkpSDRUPx1M1JMq2PlIfjg
9YH5FlQXxAAJouUCl9SnMsMwkcc30/h8M0CL+8tGMF3JSlujssyErlW2OwvGmi1m
KyV6DdtFXauBhCPLjszKnGV4jUr6TcN5piSqBsykMgncU/rsqFFKWIBY6v8CnBTK
LkCZ3Ray+5aFxB5/5oPh75BiqAZHD6/OSmIxkVtXWgqBMR+mGBmjF4sAm0hrq9nK
/q6GW2i6gUWlEmD5xgv/IV354LvZOGRESz+T4AgxMs+N/Ce7CFH0WL9GSF8fXOjv
ZVXP4fpoO0zVDGpwpESORfGu2LNNabZrnNd/hwHj6nqFI/wtcjMbgZslDvs3ZtMw
oXKG8SyN2YB793zRrLQDHmzhS7bNxSENQTi9TyCzPA2FTszQbhUj44hX9RxlC+o3
Z3K/u/Qo78TsEez0PPoiGm0Ah7Z9LzaoLU+CGeV13Sm3fkpDba6UxF8tkQlwZVve
sQzs5bU7vJdu6ferSvNK
=D5+8
-----END PGP SIGNATURE-----

--nextPart4170877.oAqXmWL42S--

