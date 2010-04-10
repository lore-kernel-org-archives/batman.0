Return-Path: <linus.luessing@web.de>
Date: Sun, 11 Apr 2010 01:56:08 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100410235608.GA12381@Linus-Debian>
References: <20100405024603.GA11965@pandem0nium>
	<201004051321.45958.sven.eckelmann@gmx.de>
	<20100405144035.GA13768@pandem0nium>
	<20100405150605.GA15893@pandem0nium>
	<20100407081123.GA2378@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20100407081123.GA2378@pandem0nium>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Limit queue lengths for
 batman and broadcast	packets
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Okay, this third version seems to get rid of the nasty OOMs very
well and after stopping the ping-broadcast on Node A in a setup of
A - B - C, the broadcast storm stops nearly immediately.

However, in my VM setup (no matter if qemu or kvm) I'm getting a
soft-lockup on B. After about 10 seconds I'm not able to send any
commands to B via ssh or via a serial console. But if I stop the
ping broadcast flood, B suddenly receives the input I've been
sending minutes before during the broadcast.

The kernel is outputting the following trace after 60 seconds of
soft-lockup:
--------------------------------------------------------------
mesh-node@mesh-node1:~$ uptime
 08:37:11 up 57 min,  2 users,  load average: 4.38, 4.40, 3.30
mesh-node@mesh-node1:~$ uptime
 08:37:12 up 57 min,  2 users,  load average: 4.38, 4.40, 3.30
mesh-node@mesh-node1:~$ uptime[ 3508.988304] BUG: soft lockup - CPU#0 stuck=
 for 61s! [bat_events:3034]
[ 3508.988304] Modules linked in: batman_adv ipv6 loop button psmouse parpo=
rt_pc parport i2c_piix4 i2c_core snd_pcsp serio_raw snd_pcm snd_timer snd e=
1000 soundcore snd_page_alloc evdev floppy ext3 jbd mbcache ide_cd_mod cdro=
m thermal processor fan thermal_sys ide_disk ide_pci_generic piix ide_core =
ata_generic libata scsi_mod dock [last unloaded: batman_adv]
[ 3508.988304]
[ 3508.988304] Pid: 3034, comm: bat_events Not tainted (2.6.26-2-686 #1)
[ 3508.988304] EIP: 0060:[<d091bc11>] EFLAGS: 00000286 CPU: 0
[ 3508.988304] EIP is at e1000_clean_tx_irq+0xfc/0x263 [e1000]
[ 3508.988304] EAX: 0000009c EBX: 0000009c ECX: 0000f601 EDX: cf23bba0
[ 3508.988304] ESI: cf23bba0 EDI: cfb5d3e0 EBP: cf3019c0 ESP: cf93bef0
[ 3508.988304]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3508.988304] CR0: 8005003b CR2: 081eb008 CR3: 0f3d1000 CR4: 00000690
[ 3508.988304] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 3508.988304] DR6: 00000000 DR7: 00000000
[ 3508.988304]  [<d091e752>] ? e1000_clean+0x3c/0x216 [e1000]
[ 3508.988304]  [<c025a8af>] ? net_rx_action+0x9c/0x1b9
[ 3508.988304]  [<c0126629>] ? __do_softirq+0x66/0xd3
[ 3508.988304]  [<c01266db>] ? do_softirq+0x45/0x53
[ 3508.988304]  [<c0126912>] ? local_bh_enable+0x66/0x71
[ 3508.988304]  [<c025b279>] ? dev_queue_xmit+0x287/0x2be
[ 3508.988304]  [<d09b52bf>] ? send_outstanding_bcast_packet+0x0/0xa5 [batm=
an_adv]
[ 3508.988304]  [<d09b531e>] ? send_outstanding_bcast_packet+0x5f/0xa5 [bat=
man_adv]
[ 3508.988304]  [<c012f03e>] ? run_workqueue+0x74/0xf2
[ 3508.988304]  [<c012f719>] ? worker_thread+0x0/0xbd
[ 3508.988304]  [<c012f7cc>] ? worker_thread+0xb3/0xbd
[ 3508.988304]  [<c01319d4>] ? autoremove_wake_function+0x0/0x2d
[ 3508.988304]  [<c0131913>] ? kthread+0x38/0x5d
[ 3508.988304]  [<c01318db>] ? kthread+0x0/0x5d
[ 3508.988304]  [<c01044f7>] ? kernel_thread_helper+0x7/0x10
[ 3508.988304]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

 08:38:55 up 59 min,  2 users,  load average: 8.59, 5.64, 3.84
mesh-node@mesh-node1:~$
mesh-node@mesh-node1:~$
mesh-node@mesh-node1:~$
--------------------------------------------------------------

I'm not sure yet, whether the issue is just that
send_broadcast_packet() is being called so often (~7000 times/
second) or if it is locking something somewhere for too long or
both.

I tried to investigate a little further what might take most of
the time send_outstanding_packets(). There I noticed, that at this
high burden send_skb_packet() in send_outstanding_packets() needs
most of the time: ~12 times (of ~7000) it needs more then 20ms
(~80ms usually) during one second. So those ~12 strange times are
holding the rcu_lock for 99% of the time on node B. Could this be
the cause for the soft-lockups? what is still confusing me is, if
it's send_skb_packet() and not send_outstanding_packets() itself
that takes so long, why isn't send_skb_packet() showing up in the
trace?

I've been using the following patch for the measurments on top of
rev 1616 + Simon's seqno patch v2 + Simon's limit patch v3:

--------------------------------------------------------------
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -431,6 +431,7 @@ int add_bcast_packet_to_list(struct sk_buff *skb)

 void send_outstanding_bcast_packet(struct work_struct *work)
 {
+unsigned long start, timespent;
        struct batman_if *batman_if;
        struct delayed_work *delayed_work =3D
                container_of(work, struct delayed_work, work);
@@ -449,8 +450,15 @@ void send_outstanding_bcast_packet(struct work_struct =
*work)
                /* send a copy of the saved skb */
                skb1 =3D skb_copy(forw_packet->skb, GFP_ATOMIC);
                if (skb1)
+{
+start =3D jiffies;
                        send_skb_packet(skb1,
                                batman_if, broadcastAddr);
+timespent =3D jiffies - start;
+if(printk_ratelimit() || timespent > 5) {
+printk("Took %d jiffies (%d ms)\n", timespent, (timespent*1000)/HZ);
+}
+}
        }
        rcu_read_unlock();

--------------------------------------------------------------

The resulting output on node B is the following:
(hmm, okay, in this output it's about 8, not 12 times per second as it
had been in previous tests)
--------------------------------------------------------------
[ 4164.437463] Took 19 jiffies (76 ms)
[ 4164.552022] Took 22 jiffies (88 ms)
[ 4164.654244] Took 20 jiffies (80 ms)
[ 4164.758564] Took 20 jiffies (80 ms)
[ 4164.858450] Took 19 jiffies (76 ms)
[ 4164.962935] Took 22 jiffies (88 ms)
[ 4165.067755] Took 19 jiffies (76 ms)
[ 4165.172166] Took 23 jiffies (92 ms)
[ 4165.276810] Took 19 jiffies (76 ms)
[ 4165.381937] Took 19 jiffies (76 ms)
[ 4165.487952] Took 18 jiffies (72 ms)
[ 4165.591722] Took 19 jiffies (76 ms)
[ 4165.696384] Took 19 jiffies (76 ms)
[ 4165.800138] Took 19 jiffies (76 ms)
[ 4165.903559] Took 19 jiffies (76 ms)
[ 4166.007544] Took 22 jiffies (88 ms)
[ 4166.116471] Took 20 jiffies (80 ms)
[ 4169.372036] __ratelimit: 9633 messages suppressed
[ 4169.372036] Took 1 jiffies (4 ms)
[ 4169.452787] Took 20 jiffies (80 ms)
[ 4169.558822] Took 21 jiffies (84 ms)
[ 4169.662983] Took 20 jiffies (80 ms)
[ 4171.180022] Took 6 jiffies (24 ms)
[ 4171.281675] Took 20 jiffies (80 ms)
[ 4171.387203] Took 20 jiffies (80 ms)
[ 4171.486460] Took 19 jiffies (76 ms)
[ 4174.370508] __ratelimit: 12882 messages suppressed
[ 4174.372021] Took 1 jiffies (4 ms)
[ 4174.460143] Took 21 jiffies (84 ms)
[ 4174.564234] Took 23 jiffies (92 ms)
[ 4174.668185] Took 19 jiffies (76 ms)
[ 4174.772064] Took 19 jiffies (76 ms)
[ 4174.876539] Took 18 jiffies (72 ms)
[ 4174.984752] Took 23 jiffies (92 ms)
[ 4175.088186] Took 20 jiffies (80 ms)
[ 4175.200019] Took 21 jiffies (84 ms)
[ 4175.300615] Took 20 jiffies (80 ms)
[ 4175.404180] Took 20 jiffies (80 ms)
[ 4175.506979] Took 21 jiffies (84 ms)
[ 4175.611148] Took 21 jiffies (84 ms)
[ 4175.712018] Took 19 jiffies (76 ms)
[ 4175.816150] Took 22 jiffies (88 ms)
[ 4175.921259] Took 19 jiffies (76 ms)
[ 4176.026627] Took 20 jiffies (80 ms)
[ 4176.135124] Took 20 jiffies (80 ms)
[ 4176.243757] Took 21 jiffies (84 ms)
[ 4176.349231] Took 21 jiffies (84 ms)
[ 4176.444639] Took 18 jiffies (72 ms)
[ 4176.543197] Took 18 jiffies (72 ms)
[ 4176.643360] Took 18 jiffies (72 ms)
[ 4176.741147] Took 17 jiffies (68 ms)
[ 4176.840095] Took 18 jiffies (72 ms)
[ 4176.938419] Took 18 jiffies (72 ms)
[ 4177.036107] Took 17 jiffies (68 ms)
[ 4177.139641] Took 18 jiffies (72 ms)
--------------------------------------------------------------

Cheers, Linus


On Wed, Apr 07, 2010 at 10:11:23AM +0200, Simon Wunderlich wrote:
> This patch limits the queue lengths of batman and broadcast packets. BATM=
AN
> packets are held back for aggregation and jittered to avoid interferences.
> Broadcast packets are stored to be sent out multiple times to increase
> the probability to be received by other nodes in lossy environments.
>=20
> Especially in extreme cases like broadcast storms, the queues have been s=
een
> to run full, eating up all the memory and triggering the infamous OOM kil=
ler.
> With the queue length limits introduced in this patch, this problem is
> avoided.
>=20
> Each queue is limited to 256 entries for now, resulting in 1 MB of maximum
> space available in total for typical setups (assuming one packet including
> overhead does not require more than 2000 byte). This should also be reaso=
nable
> for smaller routers, otherwise the defines can be tweaked later.
>=20
> This third version of the patch does not increase the local broadcast=20
> sequence number when the queue is already full.
>=20
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> Index: a/batman-adv-kernelland/send.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/send.c	(revision 1616)
> +++ a/batman-adv-kernelland/send.c	(working copy)
> @@ -378,18 +378,35 @@
>  			   send_time);
>  }
> =20
> -void add_bcast_packet_to_list(struct sk_buff *skb)
> +#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
> +/* add a broadcast packet to the queue and setup timers. broadcast packe=
ts
> + * are sent multiple times to increase probability for beeing received.
> + *
> + * This function returns NETDEV_TX_OK on success and NETDEV_TX_BUSY on
> + * errors.
> + *
> + * The skb is not consumed, so the caller should make sure that the
> + * skb is freed. */
> +int add_bcast_packet_to_list(struct sk_buff *skb)
>  {
>  	struct forw_packet *forw_packet;
> =20
> +	if (!atomic_dec_not_zero(&bcast_queue_left)) {
> +		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
>  	forw_packet =3D kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
> -	if (!forw_packet)
> -		return;
> +	if (!forw_packet) {
> +		atomic_inc(&bcast_queue_left);
> +		return NETDEV_TX_BUSY;
> +	}
> =20
>  	skb =3D skb_copy(skb, GFP_ATOMIC);
>  	if (!skb) {
> +		atomic_inc(&bcast_queue_left);
>  		kfree(forw_packet);
> -		return;
> +		return NETDEV_TX_BUSY;
>  	}
> =20
>  	skb_reset_mac_header(skb);
> @@ -401,6 +418,7 @@
>  	forw_packet->num_packets =3D 0;
> =20
>  	_add_bcast_packet_to_list(forw_packet, 1);
> +	return NETDEV_TX_OK;
>  }
> =20
>  void send_outstanding_bcast_packet(struct work_struct *work)
> @@ -435,8 +453,10 @@
>  	if ((forw_packet->num_packets < 3) &&
>  	    (atomic_read(&module_state) !=3D MODULE_DEACTIVATING))
>  		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
> -	else
> +	else {
>  		forw_packet_free(forw_packet);
> +		atomic_inc(&bcast_queue_left);
> +	}
>  }
> =20
>  void send_outstanding_bat_packet(struct work_struct *work)
> @@ -462,6 +482,10 @@
>  	    (atomic_read(&module_state) !=3D MODULE_DEACTIVATING))
>  		schedule_own_packet(forw_packet->if_incoming);
> =20
> +	/* don't count own packet */
> +	if (!forw_packet->own)
> +		atomic_inc(&batman_queue_left);
> +
>  	forw_packet_free(forw_packet);
>  }
> =20
> Index: a/batman-adv-kernelland/send.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/send.h	(revision 1616)
> +++ a/batman-adv-kernelland/send.h	(working copy)
> @@ -33,7 +33,7 @@
>  			     struct batman_packet *batman_packet,
>  			     uint8_t directlink, int hna_buff_len,
>  			     struct batman_if *if_outgoing);
> -void add_bcast_packet_to_list(struct sk_buff *skb);
> +int  add_bcast_packet_to_list(struct sk_buff *skb);
>  void send_outstanding_bcast_packet(struct work_struct *work);
>  void send_outstanding_bat_packet(struct work_struct *work);
>  void purge_outstanding_packets(void);
> Index: a/batman-adv-kernelland/soft-interface.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/soft-interface.c	(revision 1616)
> +++ a/batman-adv-kernelland/soft-interface.c	(working copy)
> @@ -227,10 +227,10 @@
>  		/* set broadcast sequence number */
>  		bcast_packet->seqno =3D htons(bcast_seqno);
> =20
> -		bcast_seqno++;
> +		/* broadcast packet. on success, increase seqno. */
> +		if (add_bcast_packet_to_list(skb) =3D=3D NETDEV_TX_OK)
> +			bcast_seqno++;
> =20
> -		/* broadcast packet */
> -		add_bcast_packet_to_list(skb);
>  		/* a copy is stored in the bcast list, therefore removing
>  		 * the original skb. */
>  		kfree_skb(skb);
> Index: a/batman-adv-kernelland/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/main.c	(revision 1616)
> +++ a/batman-adv-kernelland/main.c	(working copy)
> @@ -46,6 +46,9 @@
> =20
>  atomic_t originator_interval;
>  atomic_t vis_interval;
> +atomic_t bcast_queue_left;
> +atomic_t batman_queue_left;
> +
>  int16_t num_hna;
>  int16_t num_ifs;
> =20
> @@ -85,6 +88,8 @@
>  	atomic_set(&originator_interval, 1000);
>  	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
>  					 * for debugging now. */
> +	atomic_set(&bcast_queue_left, BCAST_QUEUE_LEN);
> +	atomic_set(&batman_queue_left, BATMAN_QUEUE_LEN);
> =20
>  	/* the name should not be longer than 10 chars - see
>  	 * http://lwn.net/Articles/23634/ */
> Index: a/batman-adv-kernelland/aggregation.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/aggregation.c	(revision 1616)
> +++ a/batman-adv-kernelland/aggregation.c	(working copy)
> @@ -95,6 +95,7 @@
>  	return false;
>  }
> =20
> +#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
>  /* create a new aggregated packet and add this packet to it */
>  static void new_aggregated_packet(unsigned char *packet_buff,
>  			   int packet_len,
> @@ -106,13 +107,26 @@
>  	struct forw_packet *forw_packet_aggr;
>  	unsigned long flags;
> =20
> +	/* own packet should always be scheduled */
> +	if (!own_packet) {
> +		if (!atomic_dec_not_zero(&batman_queue_left)) {
> +			bat_dbg(DBG_BATMAN, "batman packet queue full\n");
> +			return;
> +		}
> +	}
> +
>  	forw_packet_aggr =3D kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
> -	if (!forw_packet_aggr)
> +	if (!forw_packet_aggr) {
> +		if (!own_packet)
> +			atomic_inc(&batman_queue_left);
>  		return;
> +	}
> =20
>  	forw_packet_aggr->packet_buff =3D kmalloc(MAX_AGGREGATION_BYTES,
>  						GFP_ATOMIC);
>  	if (!forw_packet_aggr->packet_buff) {
> +		if (!own_packet)
> +			atomic_inc(&batman_queue_left);
>  		kfree(forw_packet_aggr);
>  		return;
>  	}
> Index: a/batman-adv-kernelland/main.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/main.h	(revision 1616)
> +++ a/batman-adv-kernelland/main.h	(working copy)
> @@ -70,6 +70,8 @@
>  #define MODULE_ACTIVE 1
>  #define MODULE_DEACTIVATING 2
> =20
> +#define BCAST_QUEUE_LEN		256
> +#define BATMAN_QUEUE_LEN 	256
> =20
>  /*
>   * Debug Messages
> @@ -133,6 +135,8 @@
> =20
>  extern atomic_t originator_interval;
>  extern atomic_t vis_interval;
> +extern atomic_t bcast_queue_left;
> +extern atomic_t batman_queue_left;
>  extern int16_t num_hna;
>  extern int16_t num_ifs;
> =20
>=20

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLwRAXAAoJEBKw7u43QNpf/TcQALmOMEi8G4PWshRSrt2W4Tj5
txlSWWxA1rswTwjaEACp9e7H3cGEhylLqFTLHpsg8mk+3fl9E2XNHWR+czxY80AL
bVgewAoyu1EhoE3TUkO4y34vijoaS55TTCg62XbDwJJ9kj6ZcfK8AWH0WxC+NUfY
MEP5vWSQ55WLkNO9hRWwmsF0nYZ8YiVcC/Qd0oxb0TUYa30pJC8qW0Omuf219HkN
AdWQG0Hcxp4+/gqiEmv0ElU/02cKRhPtYA9IjDWGVPxl0AuMP0lIEhsyYao+n8R5
F6Wps6kcn38S8Kaf5Vr70zF2yc9SSdIqAk0TOzF48/uEuOwV3MZZLFXmBzeyHYmv
0lWkVkf5TX/JZj5ouDyokBqbIYW+N+cvus/siH5Ukg4cJ0/wxbtl40nuhKP0bjBT
mrMf55GSwSCsnJR5eyEnn4w3GUWl3n8nEybLQELlw8KmlRN3HyJbZTsYfHCzehgG
CVd7i/upQPoKXs6geiDn+i/49CTvNWGshouaP14gSj6guL4QGltoXFWrJIS67blS
21gq8PsaUKRZLM+NS+TtEYsaJdumU34FAENHXzU4Nfomo1uCdlW5cl5uyUJc8Ol8
SDynaje84JkbbcLe17K+uE+xhAbGYMVPEefLzjG7w3J32Vg7zoMuWbqxIBD1+iuH
hLf1FnEASuzNtQJ9x5sF
=E5aR
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
