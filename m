Return-Path: <ordex@autistici.org>
Date: Sat, 26 Mar 2011 14:04:51 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110326130451.GC10750@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] TTL yes, TTL no
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

Hello folks!

In these days I was wondering whether the TTL field in the OGM packet is
really useful or not...Due to hop_penalty an OGM will be discarded as
soon as the TQ will reach 0 (which is a sort of TTL mechanism itself).
At this point why is the TTL field needed?

Someone could probably say that a node far at least TTL hops will never
be reached by a unicast packet, then it is meaningless to let it know
about me. But then it could be possible to recalibrate the TTL such that
it has to be equal to the maximum length in number of hops of the longest 
path the OGM can traverse.

Bye! :)

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
