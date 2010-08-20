Return-Path: <ordex@ritirata.org>
Date: Fri, 20 Aug 2010 14:22:52 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100820122251.GC6823@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Question about multiple GW scenario
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

Hi guys,
I'm writing a short report about the actual behaviour of b.a.t.m.a.n. in
case of client roaming between bat-nodes.

I was wondering what could happen in a particular (but not so unusual)
situation:

take a network made up of several nodes, and 2 IP gateways, say  X and Y.
These 2 gws are advertising themself as gw (via the gw-mode). 
Now we have two nodes A and B which respectively recognize as gw X and Y
(A recognizes X and B recognizes Y, where recognize means "to have such gw
as best gw"). Each gw runs a dhcp server which assigns itsself as default
ip route.

Now, what would it happen if a client roams from A to B and sends a new
dhcp request (cause the lease time has expired) so changing the default
gw from X to Y? The established connections will stop to work.

I think that this is a classical level 3 issue in the hand-off
procedure.
What do you think about this problem? Am I missing something?

Thank you all :)


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
