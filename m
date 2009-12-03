Return-Path: <linus.luessing@web.de>
Date: Thu, 3 Dec 2009 02:31:22 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091203013122.GA2223@Linus-Debian>
References: <20091129200950.GA19275@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20091129200950.GA19275@pandem0nium>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] Removing the big batman lock
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--kORqDWCi7qDJ0mEj
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Simon,

I just gave your patch a try on my laptop and could successfully,
reproduceably crash my kernel in the following way:
Setting up wifi to ad-hoc mode and connecting it to other
batman-wifi-nodes, insmodding batman-adv on my laptop and adding
this wifi interface to batman -> kernel hangs (see the two
attachements for more detailed error messages thrown by the kernel).

I'm not an expert in this, just a guess: Could it be, that
purge_orig() is executing the spinlock first and calling
free_orig_node() then, which tries to lock the same variable
again, resulting into a deadlock?

Cheers, Linus

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="20091202-batman-1489+simonspatch.log"
Content-Transfer-Encoding: quoted-printable

[21060.326349] batman-adv:Adding interface: wlan1
[21060.337123] batman-adv:Interface activated: wlan1
[21125.872005] BUG: soft lockup - CPU#0 stuck for 61s! [bat_events:5157]
[21125.872007] Modules linked in: batman_adv(-) tun nvidia(P) uinput ppdev =
lp parport sco bridge stp bnep rfcomm kvm_intel kvm acpi_cpufreq cpufreq_po=
wersave cpufreq_conservative cpufreq_userspace cpufreq_stats l2cap fuse dm_=
snapshot dm_mirror dm_region_hash dm_log firewire_sbp2 loop snd_hda_codec_r=
ealtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss uvcvideo snd_mixer=
_oss arc4 ecb btusb snd_pcm snd_seq_midi snd_rawmidi videodev snd_seq_midi_=
event snd_seq v4l1_compat snd_timer iwlagn v4l2_compat_ioctl32 snd_seq_devi=
ce iwlcore bluetooth snd i2c_i801 mac80211 soundcore i2c_core acer_wmi butt=
on processor ac battery snd_page_alloc cfg80211 psmouse evdev pcspkr serio_=
raw wmi rfkill ext3 jbd mbcache sha256_generic cryptd aes_x86_64 aes_generi=
c cbc dm_crypt dm_mod ide_cd_mod sd_mod crc_t10dif cdrom ata_generic ide_pc=
i_generic mmc_block ahci uhci_hcd libata piix ide_core sdhci_pci sdhci tg3 =
ricoh_mmc libphy firewire_ohci firewire_core crc_itu_t scsi_mod mmc_core le=
d_class intel_agp video output ehci_hcd thermal fan thermal_sys [last unloa=
ded: batman_adv]
[21125.872007] CPU 0:
[21125.872007] Modules linked in: batman_adv(-) tun nvidia(P) uinput ppdev =
lp parport sco bridge stp bnep rfcomm kvm_intel kvm acpi_cpufreq cpufreq_po=
wersave cpufreq_conservative cpufreq_userspace cpufreq_stats l2cap fuse dm_=
snapshot dm_mirror dm_region_hash dm_log firewire_sbp2 loop snd_hda_codec_r=
ealtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss uvcvideo snd_mixer=
_oss arc4 ecb btusb snd_pcm snd_seq_midi snd_rawmidi videodev snd_seq_midi_=
event snd_seq v4l1_compat snd_timer iwlagn v4l2_compat_ioctl32 snd_seq_devi=
ce iwlcore bluetooth snd i2c_i801 mac80211 soundcore i2c_core acer_wmi butt=
on processor ac battery snd_page_alloc cfg80211 psmouse evdev pcspkr serio_=
raw wmi rfkill ext3 jbd mbcache sha256_generic cryptd aes_x86_64 aes_generi=
c cbc dm_crypt dm_mod ide_cd_mod sd_mod crc_t10dif cdrom ata_generic ide_pc=
i_generic mmc_block ahci uhci_hcd libata piix ide_core sdhci_pci sdhci tg3 =
ricoh_mmc libphy firewire_ohci firewire_core crc_itu_t scsi_mod mmc_core le=
d_class intel_agp video output ehci_hcd thermal fan thermal_sys [last unloa=
ded: batman_adv]
[21125.872007] Pid: 5157, comm: bat_events Tainted: P           2.6.31-1-am=
d64 #1 =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=20
[21125.872007] RIP: 0010:[<ffffffff812de34a>]  [<ffffffff812de34a>] _spin_l=
ock+0xf/0x1b
[21125.872007] RSP: 0000:ffff88007dd99d98  EFLAGS: 00000297
[21125.872007] RAX: 0000000000000008 RBX: ffff88004f878b40 RCX: 00000000000=
00001
[21125.872007] RDX: 0000000000000007 RSI: ffffffffa0e8f02b RDI: ffff88004f8=
78b90
[21125.872007] RBP: ffffffff8101166e R08: ffff88007d5eca20 R09: 00000000000=
0000f
[21125.872007] R10: 0000000000000020 R11: 0000000000000000 R12: 00000000000=
00000
[21125.872007] R13: ffff88007d9d0000 R14: ffff88005f1f2c80 R15: ffff8800700=
52000
[21125.872007] FS:  0000000000000000(0000) GS:ffff880001643000(0000) knlGS:=
0000000000000000
[21125.872007] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[21125.872007] CR2: 00000000f39dc000 CR3: 0000000001001000 CR4: 00000000000=
026f0
[21125.872007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[21125.872007] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[21125.872007] Call Trace:
[21125.872007]  [<ffffffffa0e8c78a>] ? free_orig_node+0x26/0x84 [batman_adv]
[21125.872007]  [<ffffffffa0e8ca18>] ? purge_orig+0x198/0x1d8 [batman_adv]
[21125.872007]  [<ffffffffa0e8c880>] ? purge_orig+0x0/0x1d8 [batman_adv]
[21125.872007]  [<ffffffff8105b43b>] ? worker_thread+0x174/0x211
[21125.872007]  [<ffffffff8105f39e>] ? autoremove_wake_function+0x0/0x2e
[21125.872007]  [<ffffffff8105b2c7>] ? worker_thread+0x0/0x211
[21125.872007]  [<ffffffff8105f042>] ? kthread+0x8b/0x93
[21125.872007]  [<ffffffff81011baa>] ? child_rip+0xa/0x20
[21125.872007]  [<ffffffff8105efb7>] ? kthread+0x0/0x93
[21125.872007]  [<ffffffff81011ba0>] ? child_rip+0x0/0x20

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="20091203-batman-1489+simonspatch.log"
Content-Transfer-Encoding: quoted-printable

[ 4412.876146] wlan1: Trigger new scan to find an IBSS to join
[ 4417.816058] wlan1: Trigger new scan to find an IBSS to join
[ 4420.102974] wlan1: Creating new IBSS network, BSSID 1a:f2:51:40:bc:e9
[ 4421.761168] wlan1: Selected IBSS BSSID 02:22:b0:44:94:5d based on config=
ured SSID
[ 4433.902832] batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1489 (compatibi=
lity version 8) loaded
[ 4440.853737] batman-adv:Adding interface: wlan1
[ 4440.865090] batman-adv:Interface activated: wlan1
[ 4441.410248] NOHZ: local_softirq_pending 08
[ 4506.496007] BUG: soft lockup - CPU#0 stuck for 61s! [bat_events:13855]
[ 4506.496007] Modules linked in: batman_adv nvidia(P) uinput ppdev lp parp=
ort sco bridge stp rfcomm bnep kvm_intel kvm acpi_cpufreq cpufreq_powersave=
 cpufreq_conservative cpufreq_userspace cpufreq_stats l2cap fuse dm_snapsho=
t dm_mirror dm_region_hash dm_log firewire_sbp2 loop arc4 ecb iwlagn iwlcor=
e acer_wmi snd_hda_codec_realtek mac80211 snd_hda_intel snd_hda_codec snd_h=
wdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi snd_seq_mid=
i_event snd_seq uvcvideo snd_timer snd_seq_device videodev snd v4l1_compat =
soundcore i2c_i801 btusb v4l2_compat_ioctl32 snd_page_alloc bluetooth cfg80=
211 wmi rfkill i2c_core pcspkr psmouse evdev ac processor button serio_raw =
battery ext3 jbd mbcache sha256_generic cryptd aes_x86_64 aes_generic cbc d=
m_crypt dm_mod ide_cd_mod sd_mod cdrom crc_t10dif ata_generic ide_pci_gener=
ic ahci libata uhci_hcd piix ide_core scsi_mod tg3 libphy sdhci_pci sdhci r=
icoh_mmc firewire_ohci firewire_core crc_itu_t mmc_core led_class intel_agp=
 video output ehci_hcd thermal fan thermal_sys [last unloaded: batman_adv]
[ 4506.496007] CPU 0:
[ 4506.496007] Modules linked in: batman_adv nvidia(P) uinput ppdev lp parp=
ort sco bridge stp rfcomm bnep kvm_intel kvm acpi_cpufreq cpufreq_powersave=
 cpufreq_conservative cpufreq_userspace cpufreq_stats l2cap fuse dm_snapsho=
t dm_mirror dm_region_hash dm_log firewire_sbp2 loop arc4 ecb iwlagn iwlcor=
e acer_wmi snd_hda_codec_realtek mac80211 snd_hda_intel snd_hda_codec snd_h=
wdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi snd_seq_mid=
i_event snd_seq uvcvideo snd_timer snd_seq_device videodev snd v4l1_compat =
soundcore i2c_i801 btusb v4l2_compat_ioctl32 snd_page_alloc bluetooth cfg80=
211 wmi rfkill i2c_core pcspkr psmouse evdev ac processor button serio_raw =
battery ext3 jbd mbcache sha256_generic cryptd aes_x86_64 aes_generic cbc d=
m_crypt dm_mod ide_cd_mod sd_mod cdrom crc_t10dif ata_generic ide_pci_gener=
ic ahci libata uhci_hcd piix ide_core scsi_mod tg3 libphy sdhci_pci sdhci r=
icoh_mmc firewire_ohci firewire_core crc_itu_t mmc_core led_class intel_agp=
 video output ehci_hcd thermal fan thermal_sys [last unloaded: batman_adv]
[ 4506.496007] Pid: 13855, comm: bat_events Tainted: P           2.6.31-1-a=
md64 #1 =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
[ 4506.496007] RIP: 0010:[<ffffffff812de350>]  [<ffffffff812de350>] _spin_l=
ock+0x15/0x1b
[ 4506.496007] RSP: 0018:ffff88005d4cfd98  EFLAGS: 00000297
[ 4506.496007] RAX: 0000000000000008 RBX: ffff88005d990440 RCX: 00000000000=
00001
[ 4506.496007] RDX: 0000000000000007 RSI: ffffffffa101502b RDI: ffff88005d9=
90490
[ 4506.496007] RBP: ffffffff8101166e R08: ffff88005d507200 R09: 00000000000=
0000f
[ 4506.496007] R10: ffff880001652f20 R11: ffffffff81223a78 R12: 00000000000=
00000
[ 4506.496007] R13: 0000000000000286 R14: 0000000000000014 R15: ffff88005d4=
cfd58
[ 4506.496007] FS:  0000000000000000(0000) GS:ffff880001643000(0000) knlGS:=
0000000000000000
[ 4506.496007] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 4506.496007] CR2: 00000000f77d1000 CR3: 0000000001001000 CR4: 00000000000=
026f0
[ 4506.496007] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 4506.496007] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[ 4506.496007] Call Trace:
[ 4506.496007]  [<ffffffffa101278a>] ? free_orig_node+0x26/0x84 [batman_adv]
[ 4506.496007]  [<ffffffffa1012a18>] ? purge_orig+0x198/0x1d8 [batman_adv]
[ 4506.496007]  [<ffffffffa1012880>] ? purge_orig+0x0/0x1d8 [batman_adv]
[ 4506.496007]  [<ffffffff8105b43b>] ? worker_thread+0x174/0x211
[ 4506.496007]  [<ffffffff8105f39e>] ? autoremove_wake_function+0x0/0x2e
[ 4506.496007]  [<ffffffff8105b2c7>] ? worker_thread+0x0/0x211
[ 4506.496007]  [<ffffffff8105f042>] ? kthread+0x8b/0x93
[ 4506.496007]  [<ffffffff81011baa>] ? child_rip+0xa/0x20
[ 4506.496007]  [<ffffffff8105efb7>] ? kthread+0x0/0x93
[ 4506.496007]  [<ffffffff81011ba0>] ? child_rip+0x0/0x2

--PNTmBPCT7hxwcZjr--

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLFxTqAAoJEBKw7u43QNpffoIQAILDJpxqTQ9IBGXqhW2Y01dO
a9D2CHCrRVX74O/pXX33bqbUeL1ll4u6xUQubvzVSlh5svoFRt4/OM0spFiLmSnm
9Y0znTMatJ3cUbu1/6cvDk+k49IGop4WSeeC4tuA8D3rjso4eM24hwt/6HJcVe9i
HhtaJJTsckT+4Zphy50Nwu68m+vqF+ACsbmgJQfA6IpQgNvMcGZ/Oh3J6W0Q5Cgg
CaSE8pSVmHviuSArSeuCMOcsydlDjCZXV45AyZZD6f8mqKG/hRAmPEvIA7riItGn
EAiq2/T1ytTl9khYO4anAAohbq2jA3YjxVeTJXh9SSoE1Zi3syWxA5qZCn5DRq6l
a2ri81W1UYe1R5UBXve+yZ15vRgB31UHy3yYtYUDQKU0WlUzUQPCFmjdQylQ9WK4
etRdFHpYvLSsRLegFN/lqm+uxWZ+Mjcb5/vGtyf7m1ePWvK3tr9iNaIZkWKvfjKZ
fTemjtMOq3AiMBjP92GyzpSW10Ldav3wXnQ4gEpY9xINyDjlLF1uqXtnDHEmAyZ5
zg3N0Foz5ps9ULA8ZHHtR47VANus5zKI2Fi5XShn1KfVqGT1ltuBSqZmoDHIUuWK
ep/IopBFo/XXSuN2UjvyKqmGjrycDISw2f8CHshP4SQh93A5yE3Ma3ErP2X2cHqY
DwNkOfahcNa6hXiXxUjp
=5wNJ
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
