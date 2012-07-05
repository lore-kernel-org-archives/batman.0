Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Jul 2012 23:59:59 +0200
References: <1341235378-3111-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1341235378-3111-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207060000.00086.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise size in bitarray
	API
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

On Monday, July 02, 2012 15:22:58 Antonio Quartulli wrote:
>         /* sequence number is much newer, probably missed a lot of packets
> */ -       if (seq_num_diff >= BATADV_TQ_LOCAL_WINDOW_SIZE &&
> +       if (seq_num_diff >= size &&
>             seq_num_diff < BATADV_EXPECTED_SEQNO_RANGE) {
>                 batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
>                            "We missed a lot of packets (%i) !\n",
>                            seq_num_diff - 1);
> -               bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
> +               bitmap_zero(seq_bits, size);
>                 if (set_mark)
> -                       batadv_set_bit(seq_bits, 0);
> +                       batadv_set_bit(seq_bits, 0, size);
>                 return 1;
>         }
>  
> @@ -80,15 +81,15 @@ int batadv_bit_get_packet(void *priv, unsigned long
> *seq_bits, * packet should be dropped without calling this function if the
> * seqno window is protected.
>          */
> -       if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
> +       if (seq_num_diff <= -size ||
>             seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {

Without addressing BATADV_EXPECTED_SEQNO_RANGE this change does not make sense 
for batadv_bit_get_packet(). Looking at the function as a whole I'd say it is 
very specific for the OGM handling. Thus, it will be difficult to use it for 
anything else or do you have a sample use case ?

Regards,
Marek
