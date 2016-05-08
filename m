Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 08 May 2016 18:59:56 +0200
Message-ID: <5189010.X6E9Ozq1lq@sven-edge>
In-Reply-To: <20160508163324.GC14515@prodigo>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <38489328.JjMjPGWWVN@sven-edge> <20160508163324.GC14515@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1496138.yiq0GAD1RA";
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

--nextPart1496138.yiq0GAD1RA
Content-Type: multipart/mixed; boundary="nextPart2456275.RPAxpKaa9q"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2456275.RPAxpKaa9q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 00:33:24 Antonio Quartulli wrote:
> On Fri, May 06, 2016 at 09:53:26AM +0200, Sven Eckelmann wrote:
> > So you either have to add it to kernel-doc or do it differently.
> 
> Thanks for checking this. I will split the structure in real substructures
> with their own definition and document the fields there.
> 
> About the result from IWUY: any easy way to run it locally ? I tried to run
> it by specifying the IWYU path via CC=, but I get way more noisy result
> that what you reported in your previous email. I'd like to learn this so
> that I can easily understand which patch requires which include.

The actual script can be found in build_test.git [1]. But you can also
download the repo, prepare the headers with generate_linux_headers.sh

    LINUX_REPOSITORY=/home/sven/tmp/linux-next ./generate_linux_headers.sh

and then mount it

    mkdir linux-build
    sudo    mount -o loop linux-build.img linux-build

Now you can for example run the build tests and receive the mail:

    REMOTE=/home/sven/tmp/qemu-batman/batman-adv TO=sven ./checkstuff.sh

Or you can extract the relevant part of the script (see attachment - file
paths have to be adjusted; build_test.git with prepared headers is still 
required) and run it manually. Please make sure that you've committed your 
changed before running it because it will remove your local changes.

    sh ~/tmp/testheaders.sh

If you wonder why a header was added then you should have a look at the "test" 
file which includes the "noisy" part which you've mentioned. You should at 
least use iwyu 3.5

> On top of that, the results you posted says that I should include
> <linux/stddef.h> in bat_v.c, but it already included in that file. no?

Marek added it recently [2].

Kind regards,
	Sven

[1] https://git.open-mesh.org/build_test.git
[2] https://git.open-mesh.org/batman-adv.git/commit/9685688ae7dd85804aec2f6ce760611551fe9635

=2D-nextPart2456275.RPAxpKaa9q
Content-Disposition: attachment; filename="testheaders.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="testheaders.sh"

#! /bin/sh

LINUX_HEADERS=/home/sven/projekte/build_test/linux-build
LINUX_DEFAULT_VERSION=linux-4.5
IWYU_KERNEL_MAPPINGS=/home/sven/projekte/build_test/testhelpers/kernel_mappings.iwyu

spath="./net/batman-adv/"
bpath="./net/batman-adv/"

MAKE_CONFIG="CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_BATMAN_V=y KBUILD_SRC=${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}"

# don't touch main.h, bat_algo.h and files which are required by linux/wait.h, packet.h
sed -i 's/#include "main.h"/#include "main.h" \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/#include "bat_algo.h"/#include "bat_algo.h" \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for linux\/wait.h \*\//\/\* for linux\/wait.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for packet.h \*\//\/\* for packet.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG || exit

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG clean
make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" -j1 -k CC="iwyu -Xiwyu --prefix_header_includes=keep -Xiwyu --no_default_mappings -Xiwyu --transitive_includes_only -Xiwyu --verbose=1 -Xiwyu --mapping_file=$IWYU_KERNEL_MAPPINGS" $MAKE_CONFIG 2> test


git add -f "${bpath}" "${spath}"
fix_include --nosafe_headers --noblank_lines --separate_project_includes="$(pwd)/${bpath}" < test

# remove extra noise
sed -i '/struct batadv_algo_ops;/d' "${bpath}"/main.h
sed -i '/struct batadv_hard_iface;/d' "${bpath}"/main.h
sed -i '/struct batadv_orig_node;/d' "${bpath}"/main.h
sed -i '/struct batadv_priv;/d' "${bpath}"/main.h
git diff > asd
git checkout -f
less asd

=2D-nextPart2456275.RPAxpKaa9q--
This is a multi-part message in MIME format.

--nextPart2456275.RPAxpKaa9q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 00:33:24 Antonio Quartulli wrote:
> On Fri, May 06, 2016 at 09:53:26AM +0200, Sven Eckelmann wrote:
> > So you either have to add it to kernel-doc or do it differently.
> 
> Thanks for checking this. I will split the structure in real substructures
> with their own definition and document the fields there.
> 
> About the result from IWUY: any easy way to run it locally ? I tried to run
> it by specifying the IWYU path via CC=, but I get way more noisy result
> that what you reported in your previous email. I'd like to learn this so
> that I can easily understand which patch requires which include.

The actual script can be found in build_test.git [1]. But you can also
download the repo, prepare the headers with generate_linux_headers.sh

    LINUX_REPOSITORY=/home/sven/tmp/linux-next ./generate_linux_headers.sh

and then mount it

    mkdir linux-build
    sudo    mount -o loop linux-build.img linux-build

Now you can for example run the build tests and receive the mail:

    REMOTE=/home/sven/tmp/qemu-batman/batman-adv TO=sven ./checkstuff.sh

Or you can extract the relevant part of the script (see attachment - file
paths have to be adjusted; build_test.git with prepared headers is still 
required) and run it manually. Please make sure that you've committed your 
changed before running it because it will remove your local changes.

    sh ~/tmp/testheaders.sh

If you wonder why a header was added then you should have a look at the "test" 
file which includes the "noisy" part which you've mentioned. You should at 
least use iwyu 3.5

> On top of that, the results you posted says that I should include
> <linux/stddef.h> in bat_v.c, but it already included in that file. no?

Marek added it recently [2].

Kind regards,
	Sven

[1] https://git.open-mesh.org/build_test.git
[2] https://git.open-mesh.org/batman-adv.git/commit/9685688ae7dd85804aec2f6ce760611551fe9635

--nextPart2456275.RPAxpKaa9q
Content-Disposition: attachment; filename="testheaders.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="testheaders.sh"

#! /bin/sh

LINUX_HEADERS=/home/sven/projekte/build_test/linux-build
LINUX_DEFAULT_VERSION=linux-4.5
IWYU_KERNEL_MAPPINGS=/home/sven/projekte/build_test/testhelpers/kernel_mappings.iwyu

spath="./net/batman-adv/"
bpath="./net/batman-adv/"

MAKE_CONFIG="CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_BATMAN_V=y KBUILD_SRC=${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}"

# don't touch main.h, bat_algo.h and files which are required by linux/wait.h, packet.h
sed -i 's/#include "main.h"/#include "main.h" \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/#include "bat_algo.h"/#include "bat_algo.h" \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for linux\/wait.h \*\//\/\* for linux\/wait.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h
sed -i 's/\/\* for packet.h \*\//\/\* for packet.h \*\/ \/\/ IWYU pragma: keep/' "${spath}"/*c "${spath}"/*.h

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG || exit

make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" $MAKE_CONFIG clean
make KERNELPATH="${LINUX_HEADERS}/${LINUX_DEFAULT_VERSION}" -j1 -k CC="iwyu -Xiwyu --prefix_header_includes=keep -Xiwyu --no_default_mappings -Xiwyu --transitive_includes_only -Xiwyu --verbose=1 -Xiwyu --mapping_file=$IWYU_KERNEL_MAPPINGS" $MAKE_CONFIG 2> test


git add -f "${bpath}" "${spath}"
fix_include --nosafe_headers --noblank_lines --separate_project_includes="$(pwd)/${bpath}" < test

# remove extra noise
sed -i '/struct batadv_algo_ops;/d' "${bpath}"/main.h
sed -i '/struct batadv_hard_iface;/d' "${bpath}"/main.h
sed -i '/struct batadv_orig_node;/d' "${bpath}"/main.h
sed -i '/struct batadv_priv;/d' "${bpath}"/main.h
git diff > asd
git checkout -f
less asd

--nextPart2456275.RPAxpKaa9q--

--nextPart1496138.yiq0GAD1RA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXL3CMAAoJEF2HCgfBJntGxFUQAKvcPwAqYbRuVvK0gy+28CDU
xNr2wB1cL7ceRE7j6MfPCdtWJbMlDBrArQeebQxe64aFtlhmV48LXy5CO3oiCvJG
R5gxzY7gJ/x/5QGAvKZNt0PaFHJ0SGImri1nLsuaphMUwnFJMrWjrhtAiUxhx1j3
DQY9aZVLMMQymsR1Fknysy0P5i3983Mn9JRautqBt64MrGzNg0oFEZ5M867jBecu
qhMtGZMHqDOT5YngNX5saI1gy0EkMF2PtW67Y9xz6xGCCpwhrjG9sGd2MPuIzAUr
wG9r8X0CeOiFrf9YJTOr0mzfFW8V7w/0M4gnc5ALKplFtSp8M5ep1lbpj/SF+Q4N
WM6pFeGwheL+jaeofTPdPG4cnr5PMzg2Tuqjdy6VPTld4G7RmtAUlyS0u1eGRX8g
P0oTC9Xo6EGnJgsGVXS7DEF7FujxSMmEmY9JABeuMQN3UQXtiIIqLvZGOWlHfRPO
YU2cLKMxzdeiOjydhPk0VSKDzeQqbpwTVQyKKzSe3EGSO6fGlMADqYd/vIkZ/rke
pWUA4p2abzkFKIUsxGNX14oy8aZOq3l/Cekw6zLRdBtDOtSMo+CWp22GEl1S5l5a
y7tI9GmciaRJ4vKeBI7EK12TtwzJTwYxLknb2w9X7iLZERAKOWQHSApFqTP9+qKI
hjW35DrRisyuciuz5qm4
=58fy
-----END PGP SIGNATURE-----

--nextPart1496138.yiq0GAD1RA--

