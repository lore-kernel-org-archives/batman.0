Return-Path: <linus.luessing@web.de>
Date: Wed, 27 Jan 2010 01:10:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100127001049.GA15002@Linus-Debian>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<201001261516.39057.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201001261516.39057.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Marek,

nope, does not seem to work, still the same issue
I also tried it on my laptop here with the patch installed 
and it is a very similar call trace, although here it is 
send_vis_packets instead of vis_quit in the call trace.

Cheers, Linus

On Tue, Jan 26, 2010 at 03:16:38PM +0800, Marek Lindner wrote:
> On Tuesday 26 January 2010 14:13:11 Linus Lüssing wrote:
> > I'm now able to reproduce the second problem as well:
> > Activating the vis-server on one node causes the vis-clients to
> > throw this call trace with its slow path warning imediately.
> > Nevertheless, vis output works anyway, clients are sending
> > vis-packets and the server is drawing nice graphs.
> > See the attachment for an example call trace.
> 
> Please try the attached patch and see if it helps.
> 
> Regards,
> Marek

> diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
> index b118d1e..a6c235f 100644
> --- a/batman-adv-kernelland/vis.c
> +++ b/batman-adv-kernelland/vis.c
> @@ -405,6 +405,9 @@ static void purge_vis_packets(void)
>  {
>  	HASHIT(hashit);
>  	struct vis_info *info;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vis_hash_lock, flags);
>  
>  	while (hash_iterate(vis_hash, &hashit)) {
>  		info = hashit.bucket->data;
> @@ -416,13 +419,17 @@ static void purge_vis_packets(void)
>  			free_info(info);
>  		}
>  	}
> +
> +	spin_unlock_irqrestore(&vis_hash_lock, flags);
>  }
>  
>  static void broadcast_vis_packet(struct vis_info *info, int packet_length)
>  {
>  	HASHIT(hashit);
>  	struct orig_node *orig_node;
> +	struct batman_if *batman_if;
>  	unsigned long flags;
> +	uint8_t dstaddr[ETH_ALEN];
>  
>  	spin_lock_irqsave(&orig_hash_lock, flags);
>  
> @@ -431,45 +438,60 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
>  		orig_node = hashit.bucket->data;
>  
>  		/* if it's a vis server and reachable, send it. */
> -		if (orig_node &&
> -		    (orig_node->flags & VIS_SERVER) &&
> -		    orig_node->batman_if &&
> -		    orig_node->router) {
> +		if ((!orig_node) || (!orig_node->batman_if) ||
> +		    (!orig_node->router))
> +			continue;
>  
> -			/* don't send it if we already received the packet from
> -			 * this node. */
> -			if (recv_list_is_in(&info->recv_list, orig_node->orig))
> -				continue;
> +		if (!(orig_node->flags & VIS_SERVER))
> +			continue;
>  
> -			memcpy(info->packet.target_orig,
> -			       orig_node->orig, ETH_ALEN);
> +		/* don't send it if we already received the packet from
> +		 * this node. */
> +		if (recv_list_is_in(&info->recv_list, orig_node->orig))
> +			continue;
>  
> -			send_raw_packet((unsigned char *) &info->packet,
> -					packet_length,
> -					orig_node->batman_if,
> -					orig_node->router->addr);
> -		}
> +		spin_unlock_irqrestore(&orig_hash_lock, flags);
> +
> +		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
> +		batman_if = orig_node->batman_if;
> +		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
> +
> +		send_raw_packet((unsigned char *)&info->packet,
> +				packet_length, batman_if, dstaddr);
> +
> +		spin_lock_irqsave(&orig_hash_lock, flags);
>  	}
> -	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
> +
>  	spin_unlock_irqrestore(&orig_hash_lock, flags);
> +	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
>  }
>  
>  static void unicast_vis_packet(struct vis_info *info, int packet_length)
>  {
>  	struct orig_node *orig_node;
> +	struct batman_if *batman_if;
>  	unsigned long flags;
> +	uint8_t dstaddr[ETH_ALEN];
>  
>  	spin_lock_irqsave(&orig_hash_lock, flags);
>  	orig_node = ((struct orig_node *)
>  		     hash_find(orig_hash, info->packet.target_orig));
>  
> -	if ((orig_node != NULL) &&
> -	    (orig_node->batman_if != NULL) &&
> -	    (orig_node->router != NULL)) {
> -		send_raw_packet((unsigned char *) &info->packet, packet_length,
> -				orig_node->batman_if,
> -				orig_node->router->addr);
> -	}
> +	if ((!orig_node) || (!orig_node->batman_if) || (!orig_node->router))
> +		goto out;
> +
> +	/* don't lock while sending the packets ... we therefore
> +	 * copy the required data before sending */
> +	batman_if = orig_node->batman_if;
> +	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
> +	spin_unlock_irqrestore(&orig_hash_lock, flags);
> +
> +	send_raw_packet((unsigned char *)&info->packet,
> +			packet_length, batman_if, dstaddr);
> +
> +	return;
> +
> +out:
>  	spin_unlock_irqrestore(&orig_hash_lock, flags);
>  }
>  
> @@ -502,17 +524,18 @@ static void send_vis_packets(struct work_struct *work)
>  	struct vis_info *info, *temp;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&vis_hash_lock, flags);
>  	purge_vis_packets();
>  
>  	if (generate_vis_packet() == 0)
>  		/* schedule if generation was successful */
>  		list_add_tail(&my_vis_info->send_list, &send_list);
>  
> +	spin_lock_irqsave(&vis_hash_lock, flags);
>  	list_for_each_entry_safe(info, temp, &send_list, send_list) {
>  		list_del_init(&info->send_list);
>  		send_vis_packet(info);
>  	}
> +
>  	spin_unlock_irqrestore(&vis_hash_lock, flags);
>  	start_vis_timer();
>  }


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="call-trace-0104-27-01-10.log"
Content-Transfer-Encoding: quoted-printable

[22933.613178] ------------[ cut here ]------------
[22933.613199] WARNING: at /tmp/buildd/linux-2.6-2.6.31/debian/build/source=
_i386_none/kernel/softirq.c:143 _local_bh_enable_ip+0x41/0x97()
[22933.613206] Hardware name: =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD
[22933.613211] Modules linked in: batman_adv isofs udf nvidia(P) ppdev lp p=
arport sco bridge stp bnep rfcomm kvm_intel kvm acpi_cpufreq cpufreq_powers=
ave cpufreq_conservative cpufreq_userspace cpufreq_stats l2cap nfsd exportf=
s nfs lockd fscache nfs_acl auth_rpcgss sunrpc fuse dm_snapshot dm_mirror d=
m_region_hash dm_log firewire_sbp2 loop snd_hda_codec_realtek snd_hda_intel=
 snd_hda_codec arc4 ecb acer_wmi iwlagn snd_hwdep iwlcore snd_pcm_oss snd_m=
ixer_oss snd_pcm mac80211 snd_seq_midi snd_rawmidi snd_seq_midi_event snd_s=
eq snd_timer snd_seq_device uvcvideo videodev snd soundcore i2c_i801 cp210x=
 v4l1_compat btusb snd_page_alloc cfg80211 v4l2_compat_ioctl32 psmouse blue=
tooth wmi serio_raw rfkill i2c_core usbserial evdev pcspkr ac processor but=
ton battery ext3 jbd mbcache sha256_generic cryptd aes_x86_64 aes_generic c=
bc dm_crypt dm_mod sd_mod crc_t10dif ide_cd_mod cdrom ata_generic ide_pci_g=
eneric ahci sdhci_pci sdhci uhci_hcd mmc_core libata tg3 led_class libphy f=
irewire_ohci firewire_core crc_itu_t ricoh_mmc video output piix ide_core s=
csi_mod ehci_hcd intel_agp thermal fan thermal_sys [last unloaded: batman_a=
dv]
[22933.613436] Pid: 14882, comm: bat_events Tainted: P           2.6.31-1-a=
md64 #1
[22933.613442] Call Trace:
[22933.613453]  [<ffffffff810503fa>] ? _local_bh_enable_ip+0x41/0x97
[22933.613462]  [<ffffffff810503fa>] ? _local_bh_enable_ip+0x41/0x97
[22933.613471]  [<ffffffff8104af08>] ? warn_slowpath_common+0x77/0xa3
[22933.613480]  [<ffffffff810503fa>] ? _local_bh_enable_ip+0x41/0x97
[22933.613490]  [<ffffffff812c821f>] ? run_filter+0x33/0x3a
[22933.613498]  [<ffffffff812c8c56>] ? packet_rcv+0xa9/0x2fb
[22933.613511]  [<ffffffff812389e5>] ? dev_hard_start_xmit+0x143/0x2ba
[22933.613521]  [<ffffffff8124ac7e>] ? __qdisc_run+0xe2/0x1ec
[22933.613529]  [<ffffffff81238e8f>] ? dev_queue_xmit+0x232/0x32c
[22933.613551]  [<ffffffffa0fe8945>] ? send_vis_packets+0x4f5/0x5d5 [batman=
_adv]
[22933.613571]  [<ffffffffa0fe8450>] ? send_vis_packets+0x0/0x5d5 [batman_a=
dv]
[22933.613581]  [<ffffffff8105b43b>] ? worker_thread+0x174/0x211
[22933.613590]  [<ffffffff8105f39e>] ? autoremove_wake_function+0x0/0x2e
[22933.613599]  [<ffffffff8105b2c7>] ? worker_thread+0x0/0x211
[22933.613606]  [<ffffffff8105f042>] ? kthread+0x8b/0x93
[22933.613616]  [<ffffffff81011baa>] ? child_rip+0xa/0x20
[22933.613623]  [<ffffffff8105efb7>] ? kthread+0x0/0x93
[22933.613631]  [<ffffffff81011ba0>] ? child_rip+0x0/0x20
[22933.613636] ---[ end trace 1758b3e01bf5c445 ]---

--h31gzZEtNLTqOjlF--
