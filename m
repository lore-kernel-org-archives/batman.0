Return-Path: <linus.luessing@web.de>
Date: Sat, 27 Feb 2010 03:11:57 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100227021157.GA4116@Linus-Debian>
References: <1267235382-4026-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <1267235382-4026-1-git-send-email-linus.luessing@web.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: only modify hna-table on
	active module
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--19uQFt6ulqmgNgg1
Content-Type: multipart/mixed; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just for some more clarification about this bug (have a look at
the attached call trace): It always occurs when I haven't put an
interface into batman-adv and when I'm then changing the
mac-address of bat0. I've now added a little check in
interface_set_mac_addr() which seems to work nicely here in my
setup. I'm also wondering if we should add another sanity check
somewhere in hna_local_add() to directly avoid any racy null
pointer dereferences in there.

Cheers, Linus

On Sat, Feb 27, 2010 at 02:49:42AM +0100, Linus L=C3=BCssing wrote:
> If we haven't set the module to MODULE_ACTIVE state before (in general,
> no interface has yet been added to batman-adv) then the hna table is not
> initialised yet. If the kernel changes the mac address of the bat0
> interface at this moment then an hna_local_add() called by interface_set_=
mac_addr()
> then resulted in a null pointer derefernce. With this patch we are now
> explicitly checking before if the state is MODULE_ACTIVE right now so
> that we can assume having an initialised hna table.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  batman-adv-kernelland/soft-interface.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernella=
nd/soft-interface.c
> index f098a4f..582134f 100644
> --- a/batman-adv-kernelland/soft-interface.c
> +++ b/batman-adv-kernelland/soft-interface.c
> @@ -154,9 +154,13 @@ int interface_set_mac_addr(struct net_device *dev, v=
oid *p)
>  	if (!is_valid_ether_addr(addr->sa_data))
>  		return -EADDRNOTAVAIL;
> =20
> -	hna_local_remove(dev->dev_addr, "mac address changed");
> +	/* only modify hna-table if it has been initialised before */
> +	if (atomic_read(&module_state) =3D=3D MODULE_ACTIVE) {
> +		hna_local_remove(dev->dev_addr, "mac address changed");
> +		hna_local_add(addr->sa_data);
> +	}
> +
>  	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
> -	hna_local_add(dev->dev_addr);
> =20
>  	return 0;
>  }
> --=20
> 1.7.0
>=20

--GyRA7555PLgSTuth
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="call-trace-2010-02-25-2057.log"
Content-Transfer-Encoding: quoted-printable

[2236621.918952] batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta (compatibility=
 version 8) loaded
[2236634.418816] BUG: unable to handle kernel NULL pointer dereference at 0=
0000004
[2236634.418839] IP: [<e1bbe1cc>] hna_local_add+0xf3/0x15b [batman_adv]
[2236634.418867] *pde =3D 00000000
[2236634.418874] Oops: 0000 [#1]
[2236634.418881] last sysfs file: /sys/devices/virtual/net/bat0/flags
[2236634.418889] Modules linked in: batman_adv ip6table_filter ip6table_man=
gle ip6_tables tcp_diag inet_diag tun sit tunnel4 xt_TCPMSS xt_tcpmss xt_tc=
pudp iptable_mangle ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_=
conntrack nf_defrag_ipv4 ip_tables x_tables pppoe pppox ppp_generic fuse dm=
_snapshot dm_mirror dm_region_hash dm_log asb100 hwmon_vid loop tvaudio tda=
7432 msp3400 tuner_simple tuner_types tuner snd_wavefront bttv snd_cs4236 s=
nd_wss_lib ir_common arc4 snd_opl3_lib hisax_fcpcipnp i2c_algo_bit snd_hwde=
p hisax_isac ecb v4l2_common snd_intel8x0 snd_mpu401 ath5k snd_mpu401_uart =
videodev snd_ac97_codec hfcpci hisax snd_seq_midi mac80211 v4l1_compat vide=
obuf_dma_sg crc_ccitt ac97_bus snd_bt87x videobuf_core snd_rawmidi led_clas=
s snd_pcm_oss btcx_risc snd_seq_midi_event mISDN_core isdn tveeprom i2c_nfo=
rce2 slhc snd_mixer_oss snd_seq i2c_core btusb cfg80211 snd_pcm snd_timer s=
hpchp snd_seq_device pci_hotplug snd_page_alloc bluetooth pcspkr evdev proc=
essor button snd parport_pc ns558 gameport soundcore parport ext3 jbd mbcac=
he sha256_generic aes_i586 aes_generic cbc dm_crypt dm_mod ide_gd_mod ata_g=
eneric ohci_hcd ide_pci_generic sata_sil libata ehci_hcd amd74xx skge scsi_=
mod r8169 mii ide_core forcedeth usbcore nvidia_agp agpgart thermal fan the=
rmal_sys [last unloaded: batman_adv]
[2236634.419089]
[2236634.419097] Pid: 20863, comm: ifconfig Not tainted (2.6.30-2-486 #1) A=
7N8X-E
[2236634.419107] EIP: 0060:[<e1bbe1cc>] EFLAGS: 00010002 CPU: 0
[2236634.419123] EIP is at hna_local_add+0xf3/0x15b [batman_adv]
[2236634.419131] EAX: ffffffff EBX: 00000202 ECX: 00000000 EDX: de2b6de0
[2236634.419140] ESI: de2b6de0 EDI: df3bf53c EBP: df3bf400 ESP: ccf65e98
[2236634.419148]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[2236634.419156] Process ifconfig (pid: 20863, ti=3Dccf64000 task=3Dde14e00=
0 task.ti=3Dccf64000)
[2236634.419165] Stack:
[2236634.419170]  df3bf53c ccf65f0e ccf65f0c e1bbd3e9 ffffffed df3bf400 000=
00004 c04dfac8
[2236634.419184]  c0285c74 ccf65efc 00008924 c0286eb1 bfaf0898 00000000 000=
00000 00000000
[2236634.419199]  c0117c09 00000007 c13b52a0 00000000 00000000 c016b161 080=
4a440 decb68b4
[2236634.419216] Call Trace:
[2236634.419222]  [<e1bbd3e9>] ? interface_set_mac_addr+0x50/0x5e [batman_a=
dv]
[2236634.419240]  [<c0285c74>] ? dev_set_mac_address+0x36/0x52
[2236634.419253]  [<c0286eb1>] ? dev_ioctl+0x4f0/0x5a4
[2236634.419262]  [<c0117c09>] ? kunmap_atomic+0x59/0x68
[2236634.419276]  [<c016b161>] ? __do_fault+0x2e0/0x310
[2236634.419290]  [<c0278fc8>] ? sock_ioctl+0x0/0x1e4
[2236634.419302]  [<c0185a72>] ? vfs_ioctl+0x16/0x42
[2236634.419313]  [<c0185fa4>] ? do_vfs_ioctl+0x41d/0x454
[2236634.419323]  [<c018601c>] ? sys_ioctl+0x41/0x58
[2236634.419332]  [<c0102f1c>] ? sysenter_do_call+0x12/0x28
[2236634.419343] Code: 89 c3 fa 8d 44 20 00 90 a1 bc 4b bc e1 89 f2 e8 a9 0=
4 00 00 8b 0d bc 4b bc e1 66 ff 05 64 47 bc e1 c7 05 c0 4b bc e1 01 00 00 0=
0 <8b> 41 04 8b 51 08 c1 e0 02 39 d0 7e 1f 01 d2 89 c8 e8 d6 05 00
[2236634.419404] EIP: [<e1bbe1cc>] hna_local_add+0xf3/0x15b [batman_adv] SS=
:ESP 0068:ccf65e98
[2236634.419424] CR2: 0000000000000004
[2236634.419434] ---[ end trace 13f2007552b7b72b ]---

--GyRA7555PLgSTuth--

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLiH9tAAoJEBKw7u43QNpf8boQAIXZwlBgRHSL4SXpXNqCiey9
SHuDD/f3iOlXMD1vmTcPkp79b/8vD0ijRKPT/X/cWOThXtQFum5yLIHxNn+BqP8S
NSYWZhhoE3PUO9NWIIxgAXue1K4so93yDWn5E9lUPRuA7zSZuPXfq9i2CGYuR2R8
Y3poh6lEKWWa4Duq++1mi/nu9nZQvhD754EfZ39J0D56fDjgOvB2x7LyqG6mKz73
nbMXGM9iaNa3I038rr2LHY2Z0tJ1XEKvRP6QrnIqB5AhWfcOOCIqNjMSbjYRTF/m
P1zY4Qfjiknhx9A3r89YFAufkLQxVW52DgAdnBG1hYoF/53twUMBRUyEBQ1pQnV3
wfjw3HfuduK0ZcV3RDR9XVv0DaiaY+TfHNR6RAv6JIs87Dd4PCS3cVC53/KUfrtz
ZmFU7tCw/yGF10VIQ7EdLxrQR8kaEQhG10OlC9jcODqpzU76yb4b+STSh2mjfwut
Tjza7u40MNaK1Td+8/fQ+jG4ZPXgF0DfhJ2f9e7gMs+KA7/usZFABe8JfEdJ2Stx
JxVQz0w+D8KRlmQIJHN3+vKBfrb7fAfWVG0CFc/BVcqFJRWYFmFeK88ZFrFwbqMB
2igzS8TJ/V2dKVCsYT/ddniL7UtLuqAoKINmZjuSAt/qLR5oIcMipdAbS2+t6t4N
yvqaJnTqOIxUAf/IhjIS
=BT8u
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
