Return-Path: <ordex@autistici.org>
Date: Wed, 19 Oct 2011 15:36:37 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111019133636.GG4836@ritirata.org>
References: <4E5D69E3.30403@robotech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E5D69E3.30403@robotech.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

Hi all, Hi Tobias,

On Wed, Aug 31, 2011 at 12:53:23AM +0200, Tobias wrote:
> Hi all,
> 
> i have setup a mesh-network with batman-adv running on about 10 Foneras 
> and 4 TP-Link on OpenWRT.
> 
> At first everything seemed to work. A node on the one end could ping a 
> node on the other end over the mesh-network. The ping was hopping from 
> node to node as expected.
> 
> But sometimes some paths do not work anymore.
> 
> Some nodes can only reach their direct neighbors via a "normal ping". A 
> ping to a node via one hop does not work. A "batctl ping" does work!
> 
> This only happens to parts of the network and is not permanent. If i 
> wait it will recover, but then the problem appears at another node.
> 
> dmesg or the syslog does not report any errors.
> 
> Can anyone give me a hint where to look?
> 
> Tobias


Yesterday batman-adv-2011.3.1 has been released. As I verified with Laurent
(tests are still going on), this version should fix the bug reported into this
thread. 

It would be appreciated if any of the people affected by this bug could
test the new release and give us any feedback!

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
