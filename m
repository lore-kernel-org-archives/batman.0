Return-Path: <linus.luessing@web.de>
Date: Sat, 19 Jun 2010 17:15:40 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100619151540.GA13957@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] still jiffies - msecs mixup?
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

Hmm, while scanning through the code, there were some things that
looked a little odd to me...
---
chedule_own_packet() (/ schedule_forward_packet() )
  -> send_time = own_global_send_time(bat_priv) (/forward_send_time(bat_priv))
     <- returns current jiffies + orig_interval(in ms!) from bat_priv + jitter(in ms?)

  -> can_aggregate_with(send_time)
     -> converts MAX_AGGREGATION_MS to jiffies, seems to expect send_time to be in jiffies format

  -> new_aggregated_packet(send_time)
     -> queue_delayed_work(send_time - jiffies), 
        -> so, queue_delayed_work(orig_interval + jitter - time_diff_in_jiffies + MAX_AGGREGATION(in jiffies))?
---

Looks like we'd have some portions in the send_time still in
jiffies format, though it should be a time purely in msecs for
queue_delayed_work if I'm not mistaken.
If this is really a bug, would it be better to deal with jiffies
in these places (so converting orig_interval to jiffies) and
convert it back when queueing the work, or better convert the
jiffies variable to msecs and skipping all the other
msecs_to_jiffies conversions?

Cheers, Linus
