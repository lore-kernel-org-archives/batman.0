References: <000b01c81ff0$d7ed14b0$87c73e10$@com>
	<200711060915.59594.axel@open-mesh.net>
In-Reply-To: <200711060915.59594.axel@open-mesh.net>
Subject: RE: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
Date: Tue, 6 Nov 2007 13:35:53 +0100
Message-ID: <000301c82071$95051270$bf0f3750$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Thank you for your quick replies guys. I just woke up (doh!) so I'll get
back to you with all details shortly, but just to quickly answer axels
question on olsr.

Ok I will also post my setup

Aa ----------------- Ba --------- Ca  (a is 11a g is 11bg interface)
105.0.0.1/24     105.0.0.2   105.0.0.3
Ag ----------------- Bg --------- Cg
105.0.1.1/24     105.0.1.2   105.0.1.3

11a is switched OFF on all nodes.

OLSR seems to ALWAYS just go from Ag directly to Cg (I presume it's because
it can see it on g radio) even though route through Bg would be better and
it takes 10-15ms (at least for traceroute output). B.A.T.M.A.N ALLWAYS goes
through Bg and it's all 2ms hops Ag > Bg 2ms, Bg > Cg 2ms. Much better
wouldn't you say?
That's why I've given up on OLSR.

Ok that was the short answer, later I'll get back to you on the gate0 issue.

> but I believe this would be a 
> far more usable setup than olsr 5.3 that I also tried.
maybe check 5.4. Because I think that the improvements from 5.3 to 5.4 are 
huge, but also because I am always interested in the concrete pros and cons 
that people observe between the latest olsr/batman state-of-the art.


ciao,
axel

