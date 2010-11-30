Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 30 Nov 2010 15:42:44 +0100
References: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
	<201011292258.05388.lindner_marek@yahoo.de>
	<AANLkTikPFR+A5uGZfxB350yD4h0VXuueE+y1g2CcNxS7@mail.gmail.com>
In-Reply-To: <AANLkTikPFR+A5uGZfxB350yD4h0VXuueE+y1g2CcNxS7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011301542.45457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] global mesh
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

On Tuesday 30 November 2010 07:12:21 Kosta -- A Human Right wrote:
> Can B.A.T.M.A.N. scale to millions of users? What are the limitations
> of B.A.T.M.A.N. in this regard? Where does it excel?

A single mesh cloud consisting of millions of mesh nodes is neither feasible 
nor desirable. Each mesh node is announcing itself and routing information 
about the nodes "behind it". Obviously, the protocol overhead grows up to a 
point where the protocol traffic eats up all available bandwidth.
On the other hand, mesh protocols inherently rely on trust. Each node trusts 
its neighbor nodes that they send reliable routing information. As in real 
life this trust does not scale either. 

Can mesh technology be used to build local inexpensive networks connected to a 
"backbone link" (e.g. satellite) to serve millions of users ? Certainly! That 
is what villagetelco / Freifunk / open-mesh.com / etc are working on.

Regards,
Marek
