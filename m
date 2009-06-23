Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 23 Jun 2009 17:16:31 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090623151631.GN19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] ring buffer average function...
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
To: B.A.T.M.A.N@lists.open-mesh.net

Hi Folks

Can somebody explain why this function works the way it does:

uint8_t ring_buffer_avg(uint8_t lq_recv[])
{
	uint8_t *ptr;
	uint16_t count = 0, i = 0, sum = 0;

	ptr = lq_recv;

	while (i < TQ_GLOBAL_WINDOW_SIZE) {
		if (*ptr != 0) {
			count++;
			sum += *ptr;
		}

		i++;
		ptr++;
	}

	if (count == 0)
		return 0;

	return (uint8_t)(sum / count);
}

It only averages over the none zero values. 

The code filling these ring buffer puts a zero in whenever an
originator message is received from another neighbor. When the
originator message is from this neighbor, the tq in the originator
message is put in.

When a neighbor is dead, the ring slowly fills with 0's, whenever
there is an originator message from one of the other
neighbors. However since the 0 are ignored when calculating the
average, we tend to have a cliff effect for dead neighbors. There
tq_avg stays about the same for quite a while, and then plummets to 0.
For faster detecting dead neighbors, it would be better if the 0 were
included in the average. The tv_avg would then drop more linearly, not
cliff like, so it is likely to cross below another neighbors tv_avg
earlier, so re-routing around the dead node faster.

Before i change this function, i just want to understand why it is
like this, and what i'm likely to break :-(

     Thanks
          Andrew
