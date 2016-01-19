Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:20:09 +0800
Message-ID: <2036597.61FfIG3QWA@voltaire>
In-Reply-To: <1452933619-6712-8-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-8-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3598351.n9Im3lK8Vk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 08/12] batman-adv: keep track of when
	unicast packets are sent
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

--nextPart3598351.n9Im3lK8Vk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:15 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> To enable ELP to send probing packets over wireless links
> only if needed, batman-adv must keep track of the last time
> it sent a unicast packet towards every neighbour.
> 
> For this purpose a 2 main changes are introduced:
> 1) a new member of the elp_neigh_node structure stores the
>    last time a unicast packet was sent towards this neighbour;
> 2) a wrapper function for sending unicast packets is
>    implemented. This function will simply update the member
>    describe din point 1) and then forward the packet to the
>    real sending routine.
> 
> Point 2) implies that any code-path leading to a unicast
> sending now has to use the new wrapper.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  net/batman-adv/bat_iv_ogm.c            |  2 +-
>  net/batman-adv/bat_v_elp.c             |  2 +-
>  net/batman-adv/bat_v_ogm.c             |  2 +-
>  net/batman-adv/distributed-arp-table.c |  4 +--
>  net/batman-adv/fragmentation.c         |  8 ++---
>  net/batman-adv/icmp_socket.c           |  2 +-
>  net/batman-adv/network-coding.c        | 22 +++++++-------
>  net/batman-adv/send.c                  | 55
> +++++++++++++++++++++++++++++----- net/batman-adv/send.h                  |
> 10 +++++--
>  net/batman-adv/types.h                 |  2 ++
>  10 files changed, 75 insertions(+), 34 deletions(-)

Applied in revision cdc4545.

Thanks,
Marek

--nextPart3598351.n9Im3lK8Vk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlQpAAoJEFNVTo/uthzAWmEIAKSV9eUDTy08oRFi80knUsTZ
LDj0atUJBQEp8Kt2ZqUYLPeoRD3zoTZ+3UKRTytjVkUMpiea5zxNaK19RDY/W5Po
roFNCSbWhB8ys4/HZJxgeMgLK7EztmuAMudoTegndnWGSD7cmL/o3LWpcmrkkIhl
Fc0KxF6klp7MhmiBkuUSlYVZ/NC+8OwxeDv41QuZZYQymtI+CJ77FgSldq1rD/gN
YnZzGXiLnMElLuJYUCgIOBUNtgrA8DvIQUJC25/Ou4hpnkdgQnL70fRD3MjKodhC
V7cS5xoRtW15ggh5qJSUb49L18G6zoittciyQIJwuJVqefmGb/tudvYLuWbrOJw=
=PJ9W
-----END PGP SIGNATURE-----

--nextPart3598351.n9Im3lK8Vk--

