From: Acinonyx <acinonyxs@yahoo.gr>
Subject: Re: [B.A.T.M.A.N.] Quagga zebra API client for BATMAN
Date: Sat, 5 Jan 2008 13:00:13 +0200
References: <200712271148.14121.holger@layer-acht.org>
	<200712310201.49542.acinonyxs@yahoo.gr>
	<200801021614.22056.lindner_marek@yahoo.de>
In-Reply-To: <200801021614.22056.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200801051300.14112.acinonyxs@yahoo.gr>
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello,

Στις Wednesday 02 January 2008 17:14:21 ο/η Marek Lindner έγραψε:
> Hi,
>
> thanks for submitting your work. I published it on our website so that
> others can find it: https://www.open-mesh.net/batman/patches

Thank you Marek. :)

> By the way: Using the TTL as basis for a hop metric is ambiguous and may
> lead to errors. By doing so you assume that every host uses the same start
> TTL and every hop decreases it in the same way. The B.A.T.M.A.N. protocol
> does not demand or enforce this behaviour.
> On the other hand the hop count does not reflect the quality of a path. May
> be it would be a better approach to calculate the link quality into the
> metric so that hop based protocols can do a better decission.
>

Yes, I have noticed the potential problem with TTL. At this moment, TTL 
setting must be the same throughout the whole network for zebra metrics to be 
calculated correctly. I will try to implement a more appropriate metric 
calculation based on actual link quality as soon as I feel familiarized 
enough with the BATMAN protocol.

Regards,
Vasilis


