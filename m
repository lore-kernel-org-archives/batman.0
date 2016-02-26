Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 17:20:54 +0100
Message-ID: <2279019.udanyR4lfT@bentobox>
In-Reply-To: <20160226141638.169e15ae@ubuntu>
References: <20160226141638.169e15ae@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2147156.aNv2gj5fYA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [Patchv2 0/7] batman-adv: Optimizations for
	setups running dat and bla
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

--nextPart2147156.aNv2gj5fYA
Content-Type: multipart/mixed; boundary="nextPart5558910.ktjs2kg59P"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart5558910.ktjs2kg59P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:16:38 Andreas Pape wrote:
> This patchset introduces optimizations for batman-adv in setups having
> several gateways into a common (switched) Ethernet backbone network
> especially if dat is additionally enabled.
[...]

See my other comments directly to the patches. Please try to set the
in-reply-to of the patches to the message-id of the cover letter. Otherwise
the messages aren't correctly threaded on the mailinglist [1].

And you can set the version number of the patch directly using
git-format-patch:

    git format-patch -v 2 origin/master

I haven't done the complete build_test run but at least a quick test against 
4.4 only. The result is attached.

Kind regards,
	Sven


[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-February/thread.html

=2D-nextPart5558910.ktjs2kg59P
Content-Disposition: attachment; filename="build-test_andreas-pape_bla-fixes.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="build-test_andreas-pape_bla-fixes.mbox"

X-Original-To: sven
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: blabla Build check errors found: 2016-02-26
From: postmaster@open-mesh.org
Date: Fri, 26 Feb 2016 17:17:23 +0100 (CET)

Name of failed tests
====================

 * bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
 * bracket_align blabla ./net/batman-adv/distributed-arp-table.c
 * bracket_align blabla ./net/batman-adv/soft-interface.c
 * checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * sparse blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=n NC=n MCAST=n BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=n NC=n MCAST=n BATMAN_V=y

Output of different failed tests
================================

bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
=2D------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1661, was 33 but expected 37
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1662, was 33 but expected 37


bracket_align blabla ./net/batman-adv/distributed-arp-table.c
=2D------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1126, was 30 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1128, was 30 but expected 29


bracket_align blabla ./net/batman-adv/soft-interface.c
=2D-----------------------------------------------------

    Found wrong alignment at ./net/batman-adv/soft-interface.c:434, was 49 but expected 58


checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
=2D---------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #1661: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1661:
    +		batadv_handle_claim(bat_priv, primary_if,
    +				primary_if->net_dev->dev_addr,
    
    total: 0 errors, 0 warnings, 1 checks, 1995 lines checked


smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
=2D--------------------------------------------------------------------------

    net/batman-adv/routing.c:896 batadv_recv_unicast_packet warn: unused return: orig_node = batadv_orig_hash_find()
    net/batman-adv/soft-interface.c:433 batadv_interface_rx() warn: potential pointer math issue ('vhdr' is a 144 bit pointer)


sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer


unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=n NC=n MCAST=n BATMAN_V=y
=2D--------------------------------------------------------------------------

    batadv_bla_handle_local_claim


=2D-nextPart5558910.ktjs2kg59P--
This is a multi-part message in MIME format.

--nextPart5558910.ktjs2kg59P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:16:38 Andreas Pape wrote:
> This patchset introduces optimizations for batman-adv in setups having
> several gateways into a common (switched) Ethernet backbone network
> especially if dat is additionally enabled.
[...]

See my other comments directly to the patches. Please try to set the
in-reply-to of the patches to the message-id of the cover letter. Otherwise
the messages aren't correctly threaded on the mailinglist [1].

And you can set the version number of the patch directly using
git-format-patch:

    git format-patch -v 2 origin/master

I haven't done the complete build_test run but at least a quick test against 
4.4 only. The result is attached.

Kind regards,
	Sven


[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-February/thread.html

--nextPart5558910.ktjs2kg59P
Content-Disposition: attachment; filename="build-test_andreas-pape_bla-fixes.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="build-test_andreas-pape_bla-fixes.mbox"

X-Original-To: sven
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: blabla Build check errors found: 2016-02-26
From: postmaster@open-mesh.org
Date: Fri, 26 Feb 2016 17:17:23 +0100 (CET)

Name of failed tests
====================

 * bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
 * bracket_align blabla ./net/batman-adv/distributed-arp-table.c
 * bracket_align blabla ./net/batman-adv/soft-interface.c
 * checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * sparse blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=n NC=n MCAST=n BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=n NC=n MCAST=n BATMAN_V=y

Output of different failed tests
================================

bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
-------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1661, was 33 but expected 37
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1662, was 33 but expected 37


bracket_align blabla ./net/batman-adv/distributed-arp-table.c
-------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1126, was 30 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1128, was 30 but expected 29


bracket_align blabla ./net/batman-adv/soft-interface.c
------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/soft-interface.c:434, was 49 but expected 58


checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
----------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #1661: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1661:
    +		batadv_handle_claim(bat_priv, primary_if,
    +				primary_if->net_dev->dev_addr,
    
    total: 0 errors, 0 warnings, 1 checks, 1995 lines checked


smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
---------------------------------------------------------------------------

    net/batman-adv/routing.c:896 batadv_recv_unicast_packet warn: unused return: orig_node = batadv_orig_hash_find()
    net/batman-adv/soft-interface.c:433 batadv_interface_rx() warn: potential pointer math issue ('vhdr' is a 144 bit pointer)


sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=y NC=n MCAST=n BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer


unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=n NC=n MCAST=n BATMAN_V=y
---------------------------------------------------------------------------

    batadv_bla_handle_local_claim


--nextPart5558910.ktjs2kg59P--

--nextPart2147156.aNv2gj5fYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0HtmAAoJEF2HCgfBJntGXdUQAMxnC397n2279QjYM7bqIdic
y0G0TdjyYO16zdyQG6n4aumIpC2uxWuVNI/D5omvjI7YGOPS6jW0QshUf3SOLDAi
13I6yH8lZNgJQXveIDzhESOo7/YD6DIaYDYQP5fwckHzA7VQmPXxEUQwDel4LvZU
jGgPv74ZVP+7/IJUzg1BSLkuWKnCuguHFVz7R7GxXe7RTF1FrqwFZojW4BbNb4qD
p8jgY3V4vqctKf+s312eq5Ewrh4zGZdTwAaIWVlnhKNDb24ptlwQgoyT715VMUiU
IeQQpAdOELP1M42MVfT5WEx89opVIrMfAHbo5NFLlYMMmvUm3DJ0H3Ev4ICOtHO1
6lgDsJFbyErz3hrrH9YCXBXc4nYhyZZXc1atusTHjbRO09PDLH7oAINNyp9SMLF0
Dp723gNsyAuRpF6/elw1Q3S6lPFm2F95NycQSb9dgre4tN78guRMHml4bQjO9nqo
6lW0qvwJmxmP3tZDZuKvxcngiB7YpJwJzqGc3gplQ5HzD0Qmd+UXKz81u1v7zYCL
yzBvP8exmGuB86Km2FNUyhKXyFaWFCfglHZ1HNZRQoynInYeAkxkylXqIkiyInv0
0RTscp5b29dyRjBrw5rjgOSTu7a78Cd1qyzIVPtzoIkE0BdleRGESBL0Q41WlEsa
8pAi5sQKiOvQsISL+aRk
=pau5
-----END PGP SIGNATURE-----

--nextPart2147156.aNv2gj5fYA--

