Return-Path: <gibsonsg91921@yahoo.com>
Message-ID: <1347495936.15654.YahooMailClassic@web121402.mail.ne1.yahoo.com>
Date: Wed, 12 Sep 2012 17:25:36 -0700 (PDT)
From: adam wiz <gibsonsg91921@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] interface preference
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Is there any manual way to prioritize a wired interface over a wireless interface? It seems to do so naturally at first, but if I unplug and replug the Ethernet cable a couple times when testing it will stay on wireless. Is this considered an optimization or a bug, and how can I make it so it should always choose the Ethernet, even in multi-hop situations? For example, Babel uses an "rxcost" metric for each interface to manually increase the cost of a route on each interface.

Thanks for your help.
