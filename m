Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 10 Aug 2011 13:13:10 +0200
References: <CAJA-1LiiLCJ4D2s9ubXFRmyu_TvgiK51PAzaOHNMwP3M-KeeEg@mail.gmail.com>
In-Reply-To: <CAJA-1LiiLCJ4D2s9ubXFRmyu_TvgiK51PAzaOHNMwP3M-KeeEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108101313.11132.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman CPU usage
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

On Wednesday, August 10, 2011 12:43:58 Max Ip wrote:
> When I checked the CPU usage at different nodes (using netperf), I
> found the following results.
> 
> TCP CPU utilization send local from C to B = 5.84%
> TCP CPU utilzation send local from B to A = 2.37%
> TCP CPU utilization from C to A (2-hop environment) = 9.19%
> 
> UDP CPU utilization send local from C to B = 0.75%
> UDP CPU utilization send local from B to A = 3.85%
> UDP CPU utilization send local from C to A (2-hop environment)  = 4.31%

May I ask how you measured the batman-adv CPU usage ? Or is this simply the 
load created by netperf ?

Before we can speculate why the load is so high / low, we need to know what 
was measured in the first place.

Regards,
Marek
