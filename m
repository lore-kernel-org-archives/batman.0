Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Feb 2016 11:30:01 +0100
Message-ID: <4170150.MY2kasJMNI@bentobox>
In-Reply-To: <1456381687-29637-1-git-send-email-apape@phoenixcontact.com>
References: <1456381687-29637-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1573535.HtzZuLHv6t";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enabled
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

--nextPart1573535.HtzZuLHv6t
Content-Type: multipart/mixed; boundary="nextPart4077687.BaxcCkiCPS"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart4077687.BaxcCkiCPS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 25 February 2016 07:28:07 Andreas Pape wrote:
> This patch makes sure that only the backbone gw which has claimed the
> remote destination for the ARP request answers the ARP request directly
> if the MAC address is known due to the local DAT table. This prevents
> multiple ARP replies in a common backbone if more than one gateway
> already knows the remote mac searched for in the ARP request.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c |   59 ++++++++++++++++++++++++++++++++
>  net/batman-adv/bridge_loop_avoidance.h |    8 ++++
>  net/batman-adv/distributed-arp-table.c |   15 ++++++++
>  3 files changed, 82 insertions(+), 0 deletions(-)

I will answer to the first patch only because this patchset doesn't have a
cover letter. But it is about the whole patchset.

First thing: Good that you could convince the IT department that you have to
use git-send-email as alternative mailer.

I have not checked the actual content of the patchset ("This patch makes" in
the commit messages looks odd) but just started the build_test [1] on your
patchset. It looks like your patchset doesn't build in some configurations.
See the attached mail for more details.

And the test run without your patches looked good [2].

Kind regards,
	Sven

[1] https://git.open-mesh.org/build_test.git
[2] https://lists.open-mesh.org/pipermail/linux-merge/2016-February/002983.html

=2D-nextPart4077687.BaxcCkiCPS
Content-Disposition: inline; filename="build-test_andreas-pape_bla-fixes.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="build-test_andreas-pape_bla-fixes.mbox"

From=20postmaster@open-mesh.org Thu Feb 25 10:24:49 2016
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: blabla Build check errors found: 2016-02-25
From: postmaster@open-mesh.org
To: sven
Date: Thu, 25 Feb 2016 11:24:49 +0100 (CET)

Name of failed tests
====================

 * bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
 * bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.h
 * bracket_align blabla ./net/batman-adv/distributed-arp-table.c
 * bracket_align blabla ./net/batman-adv/distributed-arp-table.h
 * bracket_align blabla ./net/batman-adv/routing.c
 * bracket_align blabla ./net/batman-adv/soft-interface.c
 * checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
 * checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.h
 * checkpatch blabla ./net/batman-adv/distributed-arp-table.c
 * checkpatch blabla ./net/batman-adv/distributed-arp-table.h
 * checkpatch blabla ./net/batman-adv/routing.c
 * checkpatch blabla ./net/batman-adv/soft-interface.c
 * kerneldoc blabla ./net/batman-adv/bridge_loop_avoidance.c
 * smatch blabla linux-3.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.10 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.11 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.12 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.13 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.14 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.15 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.6 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.7 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.8 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.9 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * sparse blabla linux-2.6.29 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.30 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.31 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.32 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.33 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.34 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.35 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.36 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.37 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.38 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.39 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.16 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.17 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.18 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.19 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.0 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.1 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.2 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.3 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols blabla linux-3.16 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.17 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.18 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.19 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.0 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.1 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.2 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.3 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y

Output of different failed tests
================================

bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
=2D------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1199, was 41 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1203, was 41 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1204, was 41 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1655, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1656, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1658, was 33 but expected 37
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1659, was 33 but expected 37
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1942, was 17 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1961, was 27 but expected 40
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1968, was 33 but expected 41
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1982, was 41 but expected 45


bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.h
=2D------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.h:50, was 17 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.h:117, was 17 but expected 36


bracket_align blabla ./net/batman-adv/distributed-arp-table.c
=2D------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:375, was 34 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1028, was 33 but expected 52
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1030, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1031, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1124, was 33 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1125, was 33 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1127, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1128, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1129, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1130, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1264, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1265, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1266, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1285, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1286, was 25 but expected 28


bracket_align blabla ./net/batman-adv/distributed-arp-table.h
=2D------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/distributed-arp-table.h:84, was 34 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.h:178, was 34 but expected 29


bracket_align blabla ./net/batman-adv/routing.c
=2D----------------------------------------------

    Found wrong alignment at ./net/batman-adv/routing.c:908, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/routing.c:909, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/routing.c:910, was 33 but expected 36


bracket_align blabla ./net/batman-adv/soft-interface.c
=2D-----------------------------------------------------

    Found wrong alignment at ./net/batman-adv/soft-interface.c:423, was 65 but expected 40
    Found wrong alignment at ./net/batman-adv/soft-interface.c:434, was 49 but expected 58
    Found wrong alignment at ./net/batman-adv/soft-interface.c:436, was 49 but expected 56


checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
=2D---------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #1199: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1199:
    +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
    +					"bla_purge_claims(): timed out.\n");
    
    CHECK: Alignment should match open parenthesis
    #1203: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1203:
    +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
    +					"bla_purge_claims(): %pM, vid %d\n",
    
    WARNING: quoted string split across lines
    #1655: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1655:
    +		batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_rx(): Unclaimed MAC %pM found. "
    +			"Claim it. Local: %s\n",
    
    WARNING: line over 80 characters
    #1656: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1656:
    +			ethhdr->h_source, batadv_is_my_client(bat_priv, ethhdr->h_source, vid) ? "yes" : "no");
    
    CHECK: Alignment should match open parenthesis
    #1658: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1658:
    +		batadv_handle_claim(bat_priv, primary_if,
    +				primary_if->net_dev->dev_addr,
    
    CHECK: Alignment should match open parenthesis
    #1942: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1942:
    +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, uint8_t *addr,
    +		unsigned short vid)
    
    CHECK: Alignment should match open parenthesis
    #1961: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1961:
    +	claim = batadv_claim_hash_find(bat_priv,
    +			  &search_claim);
    
    CHECK: Alignment should match open parenthesis
    #1968: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1968:
    +		if (!batadv_compare_eth(claim->backbone_gw->orig,
    +				primary_if->net_dev->dev_addr))
    
    WARNING: quoted string split across lines
    #1978: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1978:
    +				   "bla_handle_local_claim(): Handle claim "
    +				   "locally for currently not claimed mac %pM.\n",
    
    WARNING: line over 80 characters
    #1982: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1982:
    +					primary_if->net_dev->dev_addr, addr, vid);
    
    CHECK: Alignment should match open parenthesis
    #1982: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1982:
    +			batadv_handle_claim(bat_priv, primary_if,
    +					primary_if->net_dev->dev_addr, addr, vid);
    
    total: 0 errors, 4 warnings, 7 checks, 1992 lines checked


checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.h
=2D---------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #50: FILE: ./net/batman-adv/bridge_loop_avoidance.h:50:
    +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, u8 *addr,
    +		unsigned short vid);
    
    CHECK: Alignment should match open parenthesis
    #117: FILE: ./net/batman-adv/bridge_loop_avoidance.h:117:
    +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, u8 *addr,
    +		unsigned short vid)
    
    total: 0 errors, 0 warnings, 2 checks, 124 lines checked


checkpatch blabla ./net/batman-adv/distributed-arp-table.c
=2D---------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #375: FILE: ./net/batman-adv/distributed-arp-table.c:375:
    +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
    +				 u8 *mac_addr, unsigned short vid)
    
    CHECK: Alignment should match open parenthesis
    #1028: FILE: ./net/batman-adv/distributed-arp-table.c:1028:
    +		if (!batadv_bla_handle_local_claim(bat_priv,
    +				dat_entry->mac_addr, vid)) {
    
    CHECK: Alignment should match open parenthesis
    #1030: FILE: ./net/batman-adv/distributed-arp-table.c:1030:
    +			batadv_dbg(BATADV_DBG_DAT, bat_priv,
    +				"Device %pM claimed by another backbone gw. Don't send ARP reply!",
    
    WARNING: line over 80 characters
    #1121: FILE: ./net/batman-adv/distributed-arp-table.c:1121:
    +			batadv_orig_hash_find(bat_priv, unicast_4addr_packet->src);
    
    WARNING: line over 80 characters
    #1123: FILE: ./net/batman-adv/distributed-arp-table.c:1123:
    +			if ((unicast_4addr_packet->u.packet_type == BATADV_UNICAST_4ADDR) &&
    
    WARNING: line over 80 characters
    #1124: FILE: ./net/batman-adv/distributed-arp-table.c:1124:
    +				(unicast_4addr_packet->subtype == BATADV_P_DAT_DHT_GET) &&
    
    CHECK: Alignment should match open parenthesis
    #1124: FILE: ./net/batman-adv/distributed-arp-table.c:1124:
    +			if ((unicast_4addr_packet->u.packet_type == BATADV_UNICAST_4ADDR) &&
    +				(unicast_4addr_packet->subtype == BATADV_P_DAT_DHT_GET) &&
    
    WARNING: line over 80 characters
    #1125: FILE: ./net/batman-adv/distributed-arp-table.c:1125:
    +				(batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))) {
    
    WARNING: quoted string split across lines
    #1127: FILE: ./net/batman-adv/distributed-arp-table.c:1127:
    +				batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP request removed: "
    +					"ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; originator: %pM\n",
    
    WARNING: line over 80 characters
    #1129: FILE: ./net/batman-adv/distributed-arp-table.c:1129:
    +					batadv_arp_hw_dst(skb, hdr_size), &ip_dst,
    
    WARNING: quoted string split across lines
    #1264: FILE: ./net/batman-adv/distributed-arp-table.c:1264:
    +		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: "
    +			"ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
    
    CHECK: Alignment should match open parenthesis
    #1285: FILE: ./net/batman-adv/distributed-arp-table.c:1285:
    +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
    +			"Device %pM claimed by another backbone gw. Drop ARP reply.\n",
    
    total: 0 errors, 7 warnings, 5 checks, 1359 lines checked


checkpatch blabla ./net/batman-adv/distributed-arp-table.h
=2D---------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #84: FILE: ./net/batman-adv/distributed-arp-table.h:84:
    +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
    +				 u8 *mac_addr, unsigned short vid);
    
    CHECK: Alignment should match open parenthesis
    #178: FILE: ./net/batman-adv/distributed-arp-table.h:178:
    +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
    +				 u8 *mac_addr, unsigned short vid)
    
    total: 0 errors, 0 warnings, 2 checks, 184 lines checked


checkpatch blabla ./net/batman-adv/routing.c
=2D-------------------------------------------

    CHECK: Alignment should match open parenthesis
    #908: FILE: ./net/batman-adv/routing.c:908:
    +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
    +				"recv_unicast_packet(): Dropped unicast pkt received "
    
    WARNING: quoted string split across lines
    #909: FILE: ./net/batman-adv/routing.c:909:
    +				"recv_unicast_packet(): Dropped unicast pkt received "
    +				"from another backbone gw %pM.\n",
    
    total: 0 errors, 1 warnings, 1 checks, 1145 lines checked


checkpatch blabla ./net/batman-adv/soft-interface.c
=2D--------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #423: FILE: ./net/batman-adv/soft-interface.c:423:
    +		batadv_dat_entry_check(bat_priv, iphdr->saddr, ethhdr->h_source,
    +								vid);
    
    CHECK: Alignment should match open parenthesis
    #436: FILE: ./net/batman-adv/soft-interface.c:436:
    +				batadv_dat_entry_check(bat_priv, iphdr->saddr,
    +						vhdr->h_source, vid);
    
    total: 0 errors, 0 warnings, 2 checks, 1176 lines checked


kerneldoc blabla ./net/batman-adv/bridge_loop_avoidance.c
=2D--------------------------------------------------------

    ./net/batman-adv/bridge_loop_avoidance.c:1930: warning: missing initial short description on line:
     * batadv_bla_handle_local_claim


smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
=2D--------------------------------------------------------------------------

    net/batman-adv/routing.c:896 batadv_recv_unicast_packet warn: unused return: orig_node = batadv_orig_hash_find()
    net/batman-adv/soft-interface.c:433 batadv_interface_rx() warn: potential pointer math issue ('vhdr' is a 144 bit pointer)


sparse blabla linux-3.17 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
=2D------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1f0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x800): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x810): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xde0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xdf0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1730): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x1270): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x18e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xf0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1e0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x1270): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.18 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
=2D------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x80): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x200): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4d0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x810): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xe20): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xe30): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x17a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x830): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1960): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x110): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1f0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x830): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.1 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x80): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x200): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4d0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x800): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x810): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xe20): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xe30): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1790): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1950): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x110): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1f0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.2 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1d0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x480): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x490): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x790): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xd80): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x15e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xca0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x480): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x7b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x1200): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x17a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xe0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x480): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x1200): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.3 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x460): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x470): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x780): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x790): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xd10): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xd20): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1580): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xc90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x460): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x7a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1730): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x460): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x450): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x460): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x780): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x790): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xd10): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xd20): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1590): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xc80): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x450): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x7a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1740): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D-----------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x450): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D-----------------------------------------------------------------------

    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer


unused_symbols blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D--------------------------------------------------------------------------

    batadv_bla_handle_local_claim
    init_module


unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
=2D--------------------------------------------------------------------------

    batadv_bla_handle_local_claim
    batadv_dat_entry_check
    init_module


=2D-nextPart4077687.BaxcCkiCPS--
This is a multi-part message in MIME format.

--nextPart4077687.BaxcCkiCPS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 25 February 2016 07:28:07 Andreas Pape wrote:
> This patch makes sure that only the backbone gw which has claimed the
> remote destination for the ARP request answers the ARP request directly
> if the MAC address is known due to the local DAT table. This prevents
> multiple ARP replies in a common backbone if more than one gateway
> already knows the remote mac searched for in the ARP request.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c |   59 ++++++++++++++++++++++++++++++++
>  net/batman-adv/bridge_loop_avoidance.h |    8 ++++
>  net/batman-adv/distributed-arp-table.c |   15 ++++++++
>  3 files changed, 82 insertions(+), 0 deletions(-)

I will answer to the first patch only because this patchset doesn't have a
cover letter. But it is about the whole patchset.

First thing: Good that you could convince the IT department that you have to
use git-send-email as alternative mailer.

I have not checked the actual content of the patchset ("This patch makes" in
the commit messages looks odd) but just started the build_test [1] on your
patchset. It looks like your patchset doesn't build in some configurations.
See the attached mail for more details.

And the test run without your patches looked good [2].

Kind regards,
	Sven

[1] https://git.open-mesh.org/build_test.git
[2] https://lists.open-mesh.org/pipermail/linux-merge/2016-February/002983.html

--nextPart4077687.BaxcCkiCPS
Content-Disposition: inline; filename="build-test_andreas-pape_bla-fixes.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="build-test_andreas-pape_bla-fixes.mbox"

From postmaster@open-mesh.org Thu Feb 25 10:24:49 2016
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: blabla Build check errors found: 2016-02-25
From: postmaster@open-mesh.org
To: sven
Date: Thu, 25 Feb 2016 11:24:49 +0100 (CET)

Name of failed tests
====================

 * bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
 * bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.h
 * bracket_align blabla ./net/batman-adv/distributed-arp-table.c
 * bracket_align blabla ./net/batman-adv/distributed-arp-table.h
 * bracket_align blabla ./net/batman-adv/routing.c
 * bracket_align blabla ./net/batman-adv/soft-interface.c
 * checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
 * checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.h
 * checkpatch blabla ./net/batman-adv/distributed-arp-table.c
 * checkpatch blabla ./net/batman-adv/distributed-arp-table.h
 * checkpatch blabla ./net/batman-adv/routing.c
 * checkpatch blabla ./net/batman-adv/soft-interface.c
 * kerneldoc blabla ./net/batman-adv/bridge_loop_avoidance.c
 * smatch blabla linux-3.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.10 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.11 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.12 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.13 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.14 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.15 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.17 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-3.19 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.6 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.7 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.8 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-3.9 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.1 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.2 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.3 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * sparse blabla linux-2.6.29 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.30 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.31 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.32 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.33 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.34 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.35 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.36 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.37 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.38 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-2.6.39 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.13 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.14 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.15 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.16 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.16 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.17 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.17 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.18 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.18 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.19 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-3.19 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.0 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.0 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.1 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.1 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.2 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.3 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse blabla linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols blabla linux-3.16 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.16 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.16 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.17 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.18 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.19 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.19 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-3.19 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.0 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.0 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.0 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.1 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.2 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.3 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y

Output of different failed tests
================================

bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.c
-------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1199, was 41 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1203, was 41 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1204, was 41 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1655, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1656, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1658, was 33 but expected 37
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1659, was 33 but expected 37
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1942, was 17 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1961, was 27 but expected 40
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1968, was 33 but expected 41
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.c:1982, was 41 but expected 45


bracket_align blabla ./net/batman-adv/bridge_loop_avoidance.h
-------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.h:50, was 17 but expected 36
    Found wrong alignment at ./net/batman-adv/bridge_loop_avoidance.h:117, was 17 but expected 36


bracket_align blabla ./net/batman-adv/distributed-arp-table.c
-------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:375, was 34 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1028, was 33 but expected 52
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1030, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1031, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1124, was 33 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1125, was 33 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1127, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1128, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1129, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1130, was 41 but expected 44
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1264, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1265, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1266, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1285, was 25 but expected 28
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.c:1286, was 25 but expected 28


bracket_align blabla ./net/batman-adv/distributed-arp-table.h
-------------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/distributed-arp-table.h:84, was 34 but expected 29
    Found wrong alignment at ./net/batman-adv/distributed-arp-table.h:178, was 34 but expected 29


bracket_align blabla ./net/batman-adv/routing.c
-----------------------------------------------

    Found wrong alignment at ./net/batman-adv/routing.c:908, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/routing.c:909, was 33 but expected 36
    Found wrong alignment at ./net/batman-adv/routing.c:910, was 33 but expected 36


bracket_align blabla ./net/batman-adv/soft-interface.c
------------------------------------------------------

    Found wrong alignment at ./net/batman-adv/soft-interface.c:423, was 65 but expected 40
    Found wrong alignment at ./net/batman-adv/soft-interface.c:434, was 49 but expected 58
    Found wrong alignment at ./net/batman-adv/soft-interface.c:436, was 49 but expected 56


checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.c
----------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #1199: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1199:
    +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
    +					"bla_purge_claims(): timed out.\n");
    
    CHECK: Alignment should match open parenthesis
    #1203: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1203:
    +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
    +					"bla_purge_claims(): %pM, vid %d\n",
    
    WARNING: quoted string split across lines
    #1655: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1655:
    +		batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_rx(): Unclaimed MAC %pM found. "
    +			"Claim it. Local: %s\n",
    
    WARNING: line over 80 characters
    #1656: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1656:
    +			ethhdr->h_source, batadv_is_my_client(bat_priv, ethhdr->h_source, vid) ? "yes" : "no");
    
    CHECK: Alignment should match open parenthesis
    #1658: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1658:
    +		batadv_handle_claim(bat_priv, primary_if,
    +				primary_if->net_dev->dev_addr,
    
    CHECK: Alignment should match open parenthesis
    #1942: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1942:
    +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, uint8_t *addr,
    +		unsigned short vid)
    
    CHECK: Alignment should match open parenthesis
    #1961: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1961:
    +	claim = batadv_claim_hash_find(bat_priv,
    +			  &search_claim);
    
    CHECK: Alignment should match open parenthesis
    #1968: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1968:
    +		if (!batadv_compare_eth(claim->backbone_gw->orig,
    +				primary_if->net_dev->dev_addr))
    
    WARNING: quoted string split across lines
    #1978: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1978:
    +				   "bla_handle_local_claim(): Handle claim "
    +				   "locally for currently not claimed mac %pM.\n",
    
    WARNING: line over 80 characters
    #1982: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1982:
    +					primary_if->net_dev->dev_addr, addr, vid);
    
    CHECK: Alignment should match open parenthesis
    #1982: FILE: ./net/batman-adv/bridge_loop_avoidance.c:1982:
    +			batadv_handle_claim(bat_priv, primary_if,
    +					primary_if->net_dev->dev_addr, addr, vid);
    
    total: 0 errors, 4 warnings, 7 checks, 1992 lines checked


checkpatch blabla ./net/batman-adv/bridge_loop_avoidance.h
----------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #50: FILE: ./net/batman-adv/bridge_loop_avoidance.h:50:
    +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, u8 *addr,
    +		unsigned short vid);
    
    CHECK: Alignment should match open parenthesis
    #117: FILE: ./net/batman-adv/bridge_loop_avoidance.h:117:
    +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv, u8 *addr,
    +		unsigned short vid)
    
    total: 0 errors, 0 warnings, 2 checks, 124 lines checked


checkpatch blabla ./net/batman-adv/distributed-arp-table.c
----------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #375: FILE: ./net/batman-adv/distributed-arp-table.c:375:
    +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
    +				 u8 *mac_addr, unsigned short vid)
    
    CHECK: Alignment should match open parenthesis
    #1028: FILE: ./net/batman-adv/distributed-arp-table.c:1028:
    +		if (!batadv_bla_handle_local_claim(bat_priv,
    +				dat_entry->mac_addr, vid)) {
    
    CHECK: Alignment should match open parenthesis
    #1030: FILE: ./net/batman-adv/distributed-arp-table.c:1030:
    +			batadv_dbg(BATADV_DBG_DAT, bat_priv,
    +				"Device %pM claimed by another backbone gw. Don't send ARP reply!",
    
    WARNING: line over 80 characters
    #1121: FILE: ./net/batman-adv/distributed-arp-table.c:1121:
    +			batadv_orig_hash_find(bat_priv, unicast_4addr_packet->src);
    
    WARNING: line over 80 characters
    #1123: FILE: ./net/batman-adv/distributed-arp-table.c:1123:
    +			if ((unicast_4addr_packet->u.packet_type == BATADV_UNICAST_4ADDR) &&
    
    WARNING: line over 80 characters
    #1124: FILE: ./net/batman-adv/distributed-arp-table.c:1124:
    +				(unicast_4addr_packet->subtype == BATADV_P_DAT_DHT_GET) &&
    
    CHECK: Alignment should match open parenthesis
    #1124: FILE: ./net/batman-adv/distributed-arp-table.c:1124:
    +			if ((unicast_4addr_packet->u.packet_type == BATADV_UNICAST_4ADDR) &&
    +				(unicast_4addr_packet->subtype == BATADV_P_DAT_DHT_GET) &&
    
    WARNING: line over 80 characters
    #1125: FILE: ./net/batman-adv/distributed-arp-table.c:1125:
    +				(batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))) {
    
    WARNING: quoted string split across lines
    #1127: FILE: ./net/batman-adv/distributed-arp-table.c:1127:
    +				batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP request removed: "
    +					"ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; originator: %pM\n",
    
    WARNING: line over 80 characters
    #1129: FILE: ./net/batman-adv/distributed-arp-table.c:1129:
    +					batadv_arp_hw_dst(skb, hdr_size), &ip_dst,
    
    WARNING: quoted string split across lines
    #1264: FILE: ./net/batman-adv/distributed-arp-table.c:1264:
    +		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: "
    +			"ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
    
    CHECK: Alignment should match open parenthesis
    #1285: FILE: ./net/batman-adv/distributed-arp-table.c:1285:
    +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
    +			"Device %pM claimed by another backbone gw. Drop ARP reply.\n",
    
    total: 0 errors, 7 warnings, 5 checks, 1359 lines checked


checkpatch blabla ./net/batman-adv/distributed-arp-table.h
----------------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #84: FILE: ./net/batman-adv/distributed-arp-table.h:84:
    +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
    +				 u8 *mac_addr, unsigned short vid);
    
    CHECK: Alignment should match open parenthesis
    #178: FILE: ./net/batman-adv/distributed-arp-table.h:178:
    +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
    +				 u8 *mac_addr, unsigned short vid)
    
    total: 0 errors, 0 warnings, 2 checks, 184 lines checked


checkpatch blabla ./net/batman-adv/routing.c
--------------------------------------------

    CHECK: Alignment should match open parenthesis
    #908: FILE: ./net/batman-adv/routing.c:908:
    +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
    +				"recv_unicast_packet(): Dropped unicast pkt received "
    
    WARNING: quoted string split across lines
    #909: FILE: ./net/batman-adv/routing.c:909:
    +				"recv_unicast_packet(): Dropped unicast pkt received "
    +				"from another backbone gw %pM.\n",
    
    total: 0 errors, 1 warnings, 1 checks, 1145 lines checked


checkpatch blabla ./net/batman-adv/soft-interface.c
---------------------------------------------------

    CHECK: Alignment should match open parenthesis
    #423: FILE: ./net/batman-adv/soft-interface.c:423:
    +		batadv_dat_entry_check(bat_priv, iphdr->saddr, ethhdr->h_source,
    +								vid);
    
    CHECK: Alignment should match open parenthesis
    #436: FILE: ./net/batman-adv/soft-interface.c:436:
    +				batadv_dat_entry_check(bat_priv, iphdr->saddr,
    +						vhdr->h_source, vid);
    
    total: 0 errors, 0 warnings, 2 checks, 1176 lines checked


kerneldoc blabla ./net/batman-adv/bridge_loop_avoidance.c
---------------------------------------------------------

    ./net/batman-adv/bridge_loop_avoidance.c:1930: warning: missing initial short description on line:
     * batadv_bla_handle_local_claim


smatch blabla linux-4.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
---------------------------------------------------------------------------

    net/batman-adv/routing.c:896 batadv_recv_unicast_packet warn: unused return: orig_node = batadv_orig_hash_find()
    net/batman-adv/soft-interface.c:433 batadv_interface_rx() warn: potential pointer math issue ('vhdr' is a 144 bit pointer)


sparse blabla linux-3.17 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
-------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1f0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x800): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x810): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xde0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xdf0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1730): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.17 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
-------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x1270): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x18e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.17 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
-------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xf0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1e0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x1270): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.18 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
-------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x80): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x200): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4d0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x810): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xe20): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xe30): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x17a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.18 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
-------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x830): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1960): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-3.18 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
-------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x110): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1f0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x830): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.1 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x80): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x200): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4d0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x800): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x810): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xe20): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xe30): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1790): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.1 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1f0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x4c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1950): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.1 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x110): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1f0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x140): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x4c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x820): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x12a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4e0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.2 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x70): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1d0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x480): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x490): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x790): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xd80): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xd90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x15e0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.2 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xca0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1c0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x480): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x7b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x1200): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x17a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4b0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.2 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xe0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x130): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x480): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x1200): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4d0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.3 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x460): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x470): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x780): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x790): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xd10): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xd20): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1580): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.3 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xc90): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x460): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x7a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1730): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.3 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x460): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=n DAT=n DEBUG=n NC=n MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0x60): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1c0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x450): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x460): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x780): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x790): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0xd10): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xf0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0xd20): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1590): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0xe0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/bridge_loop_avoidance.h:116:6: warning: symbol 'batadv_bla_handle_local_claim' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.o: In function `batadv_bla_handle_local_claim':
    distributed-arp-table.c:(.text+0xc80): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/hard-interface.o: In function `batadv_bla_handle_local_claim':
    hard-interface.c:(.text+0x50): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/main.o: In function `batadv_bla_handle_local_claim':
    main.c:(.text+0x1b0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/routing.o: In function `batadv_bla_handle_local_claim':
    routing.c:(.text+0x450): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_bla_handle_local_claim':
    soft-interface.c:(.text+0x7a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_bla_handle_local_claim':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    net/batman-adv/translation-table.o: In function `batadv_bla_handle_local_claim':
    translation-table.c:(.text+0x1740): multiple definition of `batadv_bla_handle_local_claim'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4a0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
------------------------------------------------------------------------

    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer
    net/batman-adv/distributed-arp-table.h:177:6: warning: symbol 'batadv_dat_entry_check' was not declared. Should it be static?
    net/batman-adv/hard-interface.o: In function `batadv_dat_entry_check':
    hard-interface.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/main.o: In function `batadv_dat_entry_check':
    main.c:(.text+0x1b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/originator.o: In function `batadv_dat_entry_check':
    originator.c:(.text+0x120): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/routing.o: In function `batadv_dat_entry_check':
    routing.c:(.text+0x450): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/send.o: In function `batadv_dat_entry_check':
    send.c:(.text+0xd0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/soft-interface.o: In function `batadv_dat_entry_check':
    soft-interface.c:(.text+0x7b0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    net/batman-adv/sysfs.o: In function `batadv_dat_entry_check':
    sysfs.c:(.text+0x11a0): multiple definition of `batadv_dat_entry_check'
    net/batman-adv/debugfs.o:debugfs.c:(.text+0x4c0): first defined here
    make[2]: *** [net/batman-adv/batman-adv.o] Error 1
    make[1]: *** [_module_net/batman-adv] Error 2
    make: *** [all] Error 2


sparse blabla linux-4.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
------------------------------------------------------------------------

    net/batman-adv/soft-interface.c:432:33: warning: restricted __be16 degrades to integer


unused_symbols blabla linux-4.4 cfg: BLA=n DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=y
---------------------------------------------------------------------------

    batadv_bla_handle_local_claim
    init_module


unused_symbols blabla linux-4.4 cfg: BLA=y DAT=n DEBUG=y NC=y MCAST=y BATMAN_V=y
---------------------------------------------------------------------------

    batadv_bla_handle_local_claim
    batadv_dat_entry_check
    init_module


--nextPart4077687.BaxcCkiCPS--

--nextPart1573535.HtzZuLHv6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWztepAAoJEF2HCgfBJntGKZAP/joKC9jMYzykisEzLS1X+274
IgLOOxIwXPddsHPD+2o9GjmD0p0/D6S+A5jjiTo1tOBsZf6O/p6qDEYeWTJfbtP2
C61wp5ORM49jbAE816g7kxUwEaeyB/XCML1TMaee+m0OQleX8cbMBKhNQv44CBoe
KCp9BqaHUOqrxj8ygbSJWQMarT1xHah7irTqoCmpkQwgEm58cpiUcnogkUtlpiC7
M4IRZeK0ofE0Az/S2jvPqjmE+Q/+ymXRm7Da3GF8UHjg4jzbxX7mI6Q9JbMpYF7J
XI33eh1g4fUZ+c7biMhSP7s7Sic6Lh62RAPu+zhmqfJ9HZ/H+5PmYq8m0mIKgUf3
dnhH9ULXegHVNbIzcuqa8KNkao0trjZ9pSgzePGvpAdV/syj9O6VQhm5Sj9dcZJB
cijxjfEnJQHrSX81+LyveOC4/6OZFpExcD5yJponrX0bhDA7citTR0N5MhWcCoxp
XKM81mnyWzuVKvQsFpQNkfOx6UEcSbX/OpN1rnWaSI492HnVZQ7h5Qj44lYL4gHN
CtW/muErxCR1QhrPp+861l4g0AH0M5K3eSbEBmaqyb1x4BexWSgOHg1uiIgUILyt
7lC+arYzIUkZN0TH69GTx6tivNFqfGuOFHhT8j/f3RRu9X/uM58mKYbc3Cotk0ZK
ehqJ1q9fayKqA87D7cHJ
=n0pZ
-----END PGP SIGNATURE-----

--nextPart1573535.HtzZuLHv6t--

