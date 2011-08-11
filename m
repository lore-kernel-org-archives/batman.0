Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 11 Aug 2011 16:37:30 +0200
References: <CAJA-1LiiLCJ4D2s9ubXFRmyu_TvgiK51PAzaOHNMwP3M-KeeEg@mail.gmail.com>
	<201108101637.48914.lindner_marek@yahoo.de>
	<CAJA-1LiDPQ=DZHvibHM95QnqJuqecSH71PMghK6PgQyLjD=rqQ@mail.gmail.com>
In-Reply-To: <CAJA-1LiDPQ=DZHvibHM95QnqJuqecSH71PMghK6PgQyLjD=rqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108111637.31233.lindner_marek@yahoo.de>
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


Hi,

before we proceed any further would you please solve the riddle of *how* you 
obtain the CPU usage values ? I have asked this question several times but 
could not find any answer in your mails. Maybe it is something obvious I am 
missing ?


> Without batman-advanced protocol between the nodes and when all nodes
> are communicating to each other the results for TCP and UDP cpu usage
> were:
> 
> A B C (all in communication range)
> 
> TCP CPU utilization send local from C to B = 5.85%
> TCP CPU utilzation send local from B to A = 0.90%
> TCP CPU utilization send local from C to A = 5.10%

Why are you not building the same setup ? Comparing 2 different setups to draw 
conclusions is a bit weird ..


> CPU load due to batman-adv (from C to B) = 0.19% (1-hop)     (which is
> 6.04 - 5.85)
> CPU load due to batman-adv (from B to A) = 0.27% (1-hop)     (which is
> 1.127 - 0.90)
> CPU load due to batman-adv (from C to A) =  1.865% (2-hop)   (which is
> 8.615 - 5.85 - 0.90)
> 
> The CPU load for 2-hop is more than that for 1-hop which is obvious.
> But, shouldn't the individual some of 1-hops (0.19% + 0.27 % = 0.46%)
> be equal to the 2-hop (1.865%).

In your first email you explain that all 3 systems use different hardware 
components (800MHz/1000MHz/2000MHz). Adding / subtracting percentage values 
based on different hardware is weird too ..
Also, you probably will notice that you obtain different values depending on 
which node has to generate the packets. For instance, A -> C won't give you 
the same results as C -> A.


> Also, what about the CPU load on the relaying node itself (node B)?

What about it ?

Regards,
Marek
