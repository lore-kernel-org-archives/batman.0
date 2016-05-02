Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 03 May 2016 01:34:37 +0800
Message-ID: <1644824.JdrMyOTENZ@voltaire>
In-Reply-To: <1452150672-11174-2-git-send-email-linus.luessing@c0d3.blue>
References: <1452150672-11174-1-git-send-email-linus.luessing@c0d3.blue>
 <1452150672-11174-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1670325.90i4OrrO9g";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid duplicate neigh_node
	additions
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

--nextPart1670325.90i4OrrO9g
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, January 07, 2016 08:11:12 Linus L=FCssing wrote:
> Two parallel calls to batadv_neigh_node_new() might race for creating=

> and adding the same neig_node. Fix this by including the check for an=
y
> already existing, identical neigh_node within the spin-lock.
>=20
> This fixes splats like the following:
>=20
> [  739.535069] ------------[ cut here ]------------
> [  739.535079] WARNING: CPU: 0 PID: 0 at
> /usr/src/batman-adv/git/batman-adv/net/batman-adv/bat_iv_ogm.c:1004
> batadv_iv_ogm_process_per_outif+0xe3f/0xe60 [batman_adv]() [  739.535=
092]
> too many matching neigh_nodes
> [  739.535094] Modules linked in: dm_mod tun ip6table_filter ip6table=
_mangle
> ip6table_nat nf_nat_ipv6 ip6_tables xt_nat iptable_nat nf_nat_ipv4 nf=
_nat
> xt_TCPMSS xt_mark iptable_mangle xt_tcpudp xt_conntrack iptable_filte=
r
> ip_tables x_tables ip_gre ip_tunnel gre bridge stp llc thermal_sys
> kvm_intel kvm crct10dif_pclmul crc32_pclmul sha256_ssse3 sha256_gener=
ic
> hmac drbg ansi_cprng aesni_intel aes_x86_64 lrw gf128mul glue_helper
> ablk_helper cryptd evdev pcspkr ip6_gre ip6_tunnel tunnel6 batman_adv=
(O)
> libcrc32c nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 nf_defra=
g_ipv4
> nf_conntrack autofs4 ext4 crc16 mbcache jbd2 xen_netfront xen_blkfron=
t
> crc32c_intel [  739.535177] CPU: 0 PID: 0 Comm: swapper/0 Tainted:
> G        W  O    4.2.0-0.bpo.1-amd64 #1 Debian 4.2.6-3~bpo8+2
> [  739.535186]  0000000000000000 ffffffffa013b050 ffffffff81554521
> ffff88007d003c18 [  739.535201]  ffffffff8106fa01 0000000000000000
> ffff8800047a087a ffff880079c3a000 [  739.735602]  ffff88007b82bf40
> ffff88007bc2d1c0 ffffffff8106fa7a ffffffffa013aa8e [  739.735624] Cal=
l
> Trace:
> [  739.735639]  <IRQ>  [<ffffffff81554521>] ? dump_stack+0x40/0x50
> [  739.735677]  [<ffffffff8106fa01>] ? warn_slowpath_common+0x81/0xb0=

> [  739.735692]  [<ffffffff8106fa7a>] ? warn_slowpath_fmt+0x4a/0x50
> [  739.735715]  [<ffffffffa012448f>] ?
> batadv_iv_ogm_process_per_outif+0xe3f/0xe60 [batman_adv]
> [  739.735740]  [<ffffffffa0124813>] ? batadv_iv_ogm_receive+0x363/0x=
380
> [batman_adv] [  739.735762]  [<ffffffffa0124813>] ?
> batadv_iv_ogm_receive+0x363/0x380 [batman_adv]
> [  739.735783]  [<ffffffff810b0841>] ?
> __raw_callee_save___pv_queued_spin_unlock+0x11/0x20
> [  739.735804]  [<ffffffffa012cb39>] ? batadv_batman_skb_recv+0xc9/0x=
110
> [batman_adv] [  739.735825]  [<ffffffff81464891>] ?
> __netif_receive_skb_core+0x841/0x9a0 [  739.735838]  [<ffffffff810b08=
41>] ?
> __raw_callee_save___pv_queued_spin_unlock+0x11/0x20
> [  739.735853]  [<ffffffff81465681>] ? process_backlog+0xa1/0x140
> [  739.735864]  [<ffffffff81464f1a>] ? net_rx_action+0x20a/0x320
> [  739.735878]  [<ffffffff81073aa7>] ? __do_softirq+0x107/0x270
> [  739.735891]  [<ffffffff81073d82>] ? irq_exit+0x92/0xa0
> [  739.735905]  [<ffffffff8137e0d1>] ? xen_evtchn_do_upcall+0x31/0x40=

> [  739.735924]  [<ffffffff8155b8fe>] ? xen_do_hypervisor_callback+0x1=
e/0x40
> [  739.735939]  <EOI>  [<ffffffff810013aa>] ?
> xen_hypercall_sched_op+0xa/0x20 [  739.735965]  [<ffffffff810013aa>] =
?
> xen_hypercall_sched_op+0xa/0x20 [  739.735979]  [<ffffffff8100a39c>] =
?
> xen_safe_halt+0xc/0x20
> [  739.735991]  [<ffffffff8101da6c>] ? default_idle+0x1c/0xa0
> [  739.736004]  [<ffffffff810abf6b>] ? cpu_startup_entry+0x2eb/0x350
> [  739.736019]  [<ffffffff81b2af5e>] ? start_kernel+0x480/0x48b
> [  739.736032]  [<ffffffff81b2d116>] ? xen_start_kernel+0x507/0x511
> [  739.736048] ---[ end trace c106bb901244bc8c ]---
>=20
> Reported-by: Martin Weinelt <martin@darmstadt.freifunk.net>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/originator.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision 8013ae2.

Thanks,
Marek

--nextPart1670325.90i4OrrO9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXJ4+tAAoJEFNVTo/uthzACpQIALonZAZ9I8hdvgSUmnGPYU4Q
rQZfr3b9SCHI9YwYFW1TurOik67rY44LnOUl/h9qaBV8dEnmf3/ki1j/gQTfN+6l
jtZg1fNB1b5fsgPbKV0FkFG0r9dwWLyYxtxmnd+YS21RLGqmloUPT9yiiFbQKaIh
oLIXe29SLodlPkKTTuBhxQ0hBI0prBtS7GSz9EJxGKSI2vyHd0V6y9djuTvaucHh
hTqW9fzlf/y2IJ2JKV3Pa3zld81bEyEMo+HGGDTTAW/wHSnu4R7vMFCdN4Pg7qGS
6JnLlIpIhpgWA3zhYFpj+WgA//7dqPuWb8USCp26PyCS6BhRY83ImuVKI6HRy9U=
=r3TT
-----END PGP SIGNATURE-----

--nextPart1670325.90i4OrrO9g--

