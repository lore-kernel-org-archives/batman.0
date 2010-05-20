Return-Path: <post@tiwoc.de>
Message-ID: <4BF5782D.8010207@tiwoc.de>
Date: Thu, 20 May 2010 19:58:05 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <4BF56357.3000208@tiwoc.de>	<201005201851.54709.sven.eckelmann@gmx.de>
	<201005201900.01910.sven.eckelmann@gmx.de>
In-Reply-To: <201005201900.01910.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Correct mdev calculation in
 ping subcommand
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

Am 20.05.2010 19:00, schrieb Sven Eckelmann:
> Sven Eckelmann wrote:
> Ok, have a small suggestion. Please check that mdev - ... is positive. 
> Otherwise we would have something like (mdev - avg * avg == -0.000....., 
> sqrt(...) == NaN):
> 
> PING 02:00:00:00:00:02 (02:00:00:00:00:02) 19(47) bytes of data
> 19 bytes from 02:00:00:00:00:02 icmp_seq=1 ttl=50 time=0.10 ms
> --- 02:00:00:00:00:02 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss
> rtt min/avg/max/mdev = 0.101/0.101/0.101/nan ms

There seems to be a problem with the floats... The value of mdev - avg^2
cannot become negative if computed with infinite precision. In this
case, it seems to be slightly less than zero because of rounding errors.
In iputils' ping, all calculations are done using integers which
prevents this kind of problems.

I think there are two solutions for the problem you discovered:

1) check whether the difference is <= 0 (easy)

2) rewrite the time measurement to use integers (more code to change,
but calculations will be exact)

Please check whether replacing the line calling sqrt by the following
code fixes the problem for you (first solution):

		mdev = mdev - avg * avg;
		if (mdev > 0.0)
			mdev = sqrt(mdev);
		else
			mdev = 0.0;

Or should we aim for the second solution?

- Daniel
