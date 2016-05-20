Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 17:45:14 +0800
Message-ID: <2925697.0li2FmKury@voltaire>
In-Reply-To: <1463564330-11178-2-git-send-email-sven.eckelmann@open-mesh.com>
References: <4816418.hDXNbSuFUQ@bentobox>
 <1463564330-11178-2-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13689675.S8uqQWqrKu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11 2/2] batman-adv: throughput meter
	implementation
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart13689675.S8uqQWqrKu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 18, 2016 11:38:49 Sven Eckelmann wrote:
> From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> 
> The throughput meter module is a simple, kernel-space replacement for
> throughtput measurements tool like iperf and netperf. It is intended to
> approximate TCP behaviour.
> 
> It is invoked through batctl: the protocol is connection oriented, with
> cumulative acknowledgment and a dynamic-size sliding window.
> 
> The test *can* be interrupted by batctl. A receiver side timeout avoids
> unlimited waitings for sender packets: after one second of inactivity, the
> receiver abort the ongoing test.
> 
> Based on a prototype from Edo Monticelli <montik@autistici.org>
> 
> Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> v11:
>  * moved batadv_tp_meter_init to batadv_init (main.c)
>  * fixed missing space in kerneldoc between "<" and "0"
>  * port to nla_put_u64_64bit
>  * add compat code for nla_put_u64_64bit
>  * introduce attribute BATADV_ATTR_PAD which is used for alignment
>  * rename batadv_real_genl_register_family back to genl_register_family in
>    compat-include
> v10:
>  * no changes
> v9:
>  * rebase on top of current master+"batman-adv: Include main.h in all
> files"+ "batman-adv: Keep includes ordered by filename"
>  * adjust BATADV_DBG_TP_METER to bit 7 to avoid conflicts with mcast
>  * Renamed BATADV_TP_SIGINT to BATADV_TP_REASON_CANCEL
>  * Renamed batadv_tp_meter_reason enumerals to BATADV_TP_REASON*
>  * Remove unrelated patch chunk in batadv_iv_ogm_orig_add_if
>  * Re-add accidentally removed empty line from batadv_recv_my_icmp_packet
>  * define BATADV_TP_PLEN via BATADV_TP_PACKET_LEN (increases it to 1476)
>  * fixed whitespace problems in compat code
>  * remove double "a" in kerneldoc for batadv_tp_meter_reason
> v8:
>  * rebase on top of current master
> v7:
>  * add compatibility code for v3.13
>  * make batadv_netlink_mcgrps non-const because v3.12 needs it writable
> v6:
>  * increase total_bytes to 64 bit to allow higher speeds/longer test times
> ---
>  compat-include/linux/netlink.h  |  113 +++
>  compat-include/net/genetlink.h  |  127 +++-
>  include/uapi/linux/batman_adv.h |   43 ++
>  net/batman-adv/Makefile         |    1 +
>  net/batman-adv/main.c           |    4 +
>  net/batman-adv/main.h           |   26 +-
>  net/batman-adv/netlink.c        |  234 +++++-
>  net/batman-adv/netlink.h        |    6 +
>  net/batman-adv/packet.h         |   54 ++
>  net/batman-adv/routing.c        |    8 +
>  net/batman-adv/soft-interface.c |    2 +
>  net/batman-adv/tp_meter.c       | 1503
> +++++++++++++++++++++++++++++++++++++++
> net/batman-adv/tp_meter.h       |   34 +
>  net/batman-adv/types.h          |  112 +++
>  14 files changed, 2255 insertions(+), 12 deletions(-)
>  create mode 100644 compat-include/linux/netlink.h
>  create mode 100644 net/batman-adv/tp_meter.c
>  create mode 100644 net/batman-adv/tp_meter.h

Applied in revision 98d7a76.

Thanks,
Marek

--nextPart13689675.S8uqQWqrKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtyqAAoJEFNVTo/uthzA5MkIAIQ7eEO7QRpuaOPUHa6Tw2W5
NepwtqFswIys/Yu5NRt1bMreaqMgx4befz0APD+aaA64j0avY7gaaryINyM4kpqv
B8PvH2r2hvW6yRDEZM0iY628Y088kT3UMXkhxv7L2wnnDJ88knVgIbylAAyI2H2s
hn0JIbzTsWnw9Cd0FIKOcUHEr22Z+pb3u+Hw8dIUiGCqyQv4AwwUqgbCr8gGwn0k
03fgsdHypgFcfhufD0RtdgUsV/51mP81z6Y4op8T6uS5a/HOqKmvsDFnk1DbZ79M
xh1dlGGuxS8hda1+k7t6s6UwPBSe91Ugjh1EvuhgCh/1IGM9XGcBFIaisoMwruk=
=vz0Y
-----END PGP SIGNATURE-----

--nextPart13689675.S8uqQWqrKu--

