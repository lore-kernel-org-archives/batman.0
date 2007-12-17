Date: Mon, 17 Dec 2007 12:40:10 +0100
From: "daniel.poelzleithner" <poelzi@poelzi.org>
Subject: Re: [B.A.T.M.A.N.] Some issues in ahdemo and intra-mesh traffic (slow)
Message-Id: <20071217124010.07e781ab.poelzi@poelzi.org>
In-Reply-To: <200712131824.52450.axel@open-mesh.net>
References: <001d01c83cdc$a15dcd50$e41967f0$@com>
	<200712131824.52450.axel@open-mesh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: pele@balorda.com

On Thu, 13 Dec 2007 18:24:52 +0100
Axel Neumann <axel@open-mesh.net> wrote:

> I dont know why but ahdemo (or ad-hoc mode in general) is usually less 
> performat than managed mode. IMO the ad-hoc implementations never experience 
> as much devotion as developers spent in the managed mode. 

It's even worser. 
In the backoff algorithm (collision detection) the wifi spec says that in ad-hoc mode the waiting time in collision cases is *2. Which means that in ad-hoc mode when the air is very dense, ad-hoc networks the only half the airtime managed networks get. personally i suspect that it is even worse and causes many of the ad-hoc network problems and gets worser with more hops.

kindly regards
 daniel
