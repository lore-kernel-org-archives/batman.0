Message-ID: <48908444.3040805@csp.it>
Date: Wed, 30 Jul 2008 17:09:56 +0200
From: cipollone <cipollone@csp.it>
MIME-Version: 1.0
References: <E9DE65F5-50B7-494C-8C69-E0A028F2AF0B@gmail.com>
	<20080725111751.GA27127@hrz.tu-chemnitz.de>
In-Reply-To: <20080725111751.GA27127@hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] BATMAN Advanced Kernel: how much time to find a new
	route?
Reply-To: cipollone@csp.it,
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

I'm studying how BATMAN Advanced-Kernel work.
I'm interesting in knowing what is the behavior of BATMAN and the 
reaction time of the protocol if a node exit from a range node and 
entered in another range node. I have discovered that (in a simulation 
with 3 hosts with a mobile node and 2 static node) BATMAN find a new 
route losing more or less 8 seconds, passing from one to the other node. 
But the OGMs time is 1 s and the sliding window is 64, so why it can 
lost 64 seconds to find another route (or 32)?

So there is a equation to define a the time lost to find a new route?

I have an originator interval of 1 seconds (set by default).

Thank you

Paolo

