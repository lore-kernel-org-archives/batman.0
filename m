Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 Apr 2012 10:07:02 +0200
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
	<1333370896-11295-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1333370896-11295-2-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204041007.02852.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add interface to keep stats
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

On Monday, April 02, 2012 14:48:15 Martin Hundeb=C3=B8ll wrote:
> @@ -265,6 +266,18 @@ static int vis_data_open(struct inode *inode, struct
> file *file) return single_open(file, vis_seq_print_text, net_dev);
>  }
>=20
> +static int bat_stats_open(struct inode *inode, struct file *file)
> +{
> +	struct net_device *net_dev =3D (struct net_device *)inode->i_private;
> +	return single_open(file, bat_stats_show, net_dev);
> +}=20

Did you consider using bat_priv->stats or ethtool->get_ethtool_stats() ?


> +static int bat_stats_clear_open(struct inode *inode, struct file *file)
> +{
> +	struct net_device *net_dev =3D (struct net_device *)inode->i_private;
> +	return single_open(file, bat_stats_clear, net_dev);
> +}

How about writing 0 to the stats file resets the counters, thus avoiding a=
=20
second file ?


> +/* Update one or more stat counters by passing the appropriate flags. */
> +void bat_stats_update(struct bat_priv *bat_priv, uint32_t flags)
> +{
> +	if (bat_priv && flags) {
> +		write_seqlock(&bat_priv->bat_stats->lock);
> +		if (flags & BAT_STAT_XMIT)
> +			atomic_inc(&bat_priv->bat_stats->transmitted);
> +		if (flags & BAT_STAT_RECV)
> +			atomic_inc(&bat_priv->bat_stats->received);
> +		if (flags & BAT_STAT_FORWARD)
> +			atomic_inc(&bat_priv->bat_stats->forwarded);
> +		if (flags & BAT_STAT_CODE)
> +			atomic_inc(&bat_priv->bat_stats->coded);
> +		if (flags & BAT_STAT_DECODE)
> +			atomic_inc(&bat_priv->bat_stats->decoded);
> +		if (flags & BAT_STAT_DECODE_FAIL)
> +			atomic_inc(&bat_priv->bat_stats->decode_failed);
> +		if (flags & BAT_STAT_RECODE)
> +			atomic_inc(&bat_priv->bat_stats->recoded);
> +		if (flags & BAT_STAT_OVERHEARD)
> +			atomic_inc(&bat_priv->bat_stats->overheard);
> +		write_sequnlock(&bat_priv->bat_stats->lock);
> +	}
> +}

The network coding flags should be added with the network coding patchset.


> +/* debugfs function to list statistics */
> +int bat_stats_show(struct seq_file *seq, void *offset)
> +{
> +	struct net_device *net_dev =3D (struct net_device *)seq->private;
> +	struct bat_priv *bat_priv =3D netdev_priv(net_dev);
> +	struct bat_stats *stats =3D bat_priv->bat_stats;
> +	seqlock_t *lock =3D &stats->lock;
> +	int transmitted, received, forwarded, coded, decoded, decode_failed,
> +	    recoded, overheard;
> +	unsigned long sval;
> +
> +	do {
> +		sval =3D read_seqbegin(lock);
> +		transmitted   =3D atomic_read(&stats->transmitted);
> +		received      =3D atomic_read(&stats->received);
> +		forwarded     =3D atomic_read(&stats->forwarded);
> +		coded         =3D atomic_read(&stats->coded);
> +		decoded       =3D atomic_read(&stats->decoded);
> +		decode_failed =3D atomic_read(&stats->decode_failed);
> +		recoded       =3D atomic_read(&stats->recoded);
> +		overheard     =3D atomic_read(&stats->overheard);
> +	} while (read_seqretry(lock, sval));
> +
> +	seq_printf(seq, "Transmitted:  %d\n", transmitted);
> +	seq_printf(seq, "Received:     %d\n", received);
> +	seq_printf(seq, "Forwarded:    %d\n", forwarded);
> +	seq_printf(seq, "Coded:        %d\n", coded);
> +	seq_printf(seq, "Recoded:      %d\n", recoded);
> +	seq_printf(seq, "Decoded:      %d\n", decoded);
> +	seq_printf(seq, "Failed:       %d\n", decode_failed);
> +	seq_printf(seq, "Overheard:    %d\n", overheard);
> +
> +	return 0;
> +}

Why not simply printing the atomic counters ?
I also don't quite understand why we need to add an additional layer of=20
locking. This potentially slows down the traffic forwarding.


> diff --git a/types.h b/types.h
> index 15f538a..41b2217 100644
> --- a/types.h
> +++ b/types.h
> @@ -240,6 +240,7 @@ struct bat_priv {
>  #endif
>  	struct vis_info *my_vis_info;
>  	struct bat_algo_ops *bat_algo_ops;
> +	struct bat_stats *bat_stats;
>  };

If you add an ifdef around the definition here would be no need to malloc=20
bat_stats separately, right ?


> +struct bat_stats {
> +	seqlock_t lock;			/* seqlock for fast write operation */
> +	struct timespec timestamp;	/* Timestamp of data */

What is the timestamp used for ?

Regards,
Marek

