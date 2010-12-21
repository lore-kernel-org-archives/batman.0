Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Dec 2010 00:52:51 +0100
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
	<1292320696-11983-4-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-4-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201012220052.52342.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: Adding workqueue for
	new ndp packets
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

On Tuesday 14 December 2010 10:58:09 Linus L=C3=BCssing wrote:
> diff --git a/ndp.c b/ndp.c
> new file mode 100644
> index 0000000..2dfb06d
> --- /dev/null
> +++ b/ndp.c
> @@ -0,0 +1,44 @@
> +#include "main.h"
> +#include "send.h"

I think it would make more sense to have own_ndp_send_time() in ndp.c as it=
 is=20
not used anywhere else.=20
We don't have to repeat the mistakes from the past.  ;-)


> +
> +void start_ndp_timer(struct batman_if *batman_if)
> +{
> +	// adding some jitter
> +	unsigned long ndp_interval =3D own_ndp_send_time(batman_if);
> +	queue_delayed_work(bat_event_workqueue, &batman_if->ndp_wq,
> +			   ndp_interval - jiffies);
> +}
> +
> +void stop_ndp_timer(struct batman_if *batman_if)
> +{
> +	cancel_delayed_work_sync(&batman_if->ndp_wq);
> +}

Would you mind renaming these functions, so that they begin with ndp_*() ?
Checkpatch does not like C99 style comments ("//").


> +int ndp_init(struct batman_if *batman_if)
> +{
> +	atomic_set(&batman_if->ndp_interval, 500);
> +	atomic_set(&batman_if->ndp_seqno, 0);
> +	INIT_DELAYED_WORK(&batman_if->ndp_wq, ndp_send);
> +
> +	return 0;
> +}

Wouldn't it be better to initialize the ndp_interval in=20
hardif_add_interface(), so that an interface disable/enable does not overwr=
ite=20
user specified ndp intervals ?

Cheers,
Marek
