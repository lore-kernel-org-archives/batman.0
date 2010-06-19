Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Jun 2010 00:50:01 +0200
References: <20100619151540.GA13957@Sellars>
In-Reply-To: <20100619151540.GA13957@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201006200050.01891.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] still jiffies - msecs mixup?
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

On Saturday 19 June 2010 17:15:40 Linus L=C3=BCssing wrote:
> schedule_own_packet() (/ schedule_forward_packet() )
>   -> send_time =3D own_global_send_time(bat_priv)
> (/forward_send_time(bat_priv)) <- returns current jiffies +
> orig_interval(in ms!) from bat_priv + jitter(in ms?)

The orig_interval and jitter are transformed to jiffies (towards the end of=
 the=20
line). It is not very obvious and might be susceptible for overflows. We=20
probably should use msecs_to_jiffies() here.


>   -> can_aggregate_with(send_time)
>      -> converts MAX_AGGREGATION_MS to jiffies, seems to expect send_time
> to be in jiffies format

Correct - we have jiffies here.


>   -> new_aggregated_packet(send_time)
>      -> queue_delayed_work(send_time - jiffies),
>         -> so, queue_delayed_work(orig_interval + jitter -
> time_diff_in_jiffies + MAX_AGGREGATION(in jiffies))? ---
>=20
> Looks like we'd have some portions in the send_time still in
> jiffies format, though it should be a time purely in msecs for
> queue_delayed_work if I'm not mistaken.

You are mistaken.  :-)
workqueue.c:323 [right above queue_delayed_work()] says:=20
@delay: number of jiffies to wait before queueing

Regards,
Marek
