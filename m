Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 30 Nov 2010 16:10:46 +0100
References: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
	<201011301542.45457.lindner_marek@yahoo.de>
	<AANLkTinh3EzmA5=rJLi05wgy+cSXQwVRE4Ri+QBbCUMr@mail.gmail.com>
In-Reply-To: <AANLkTinh3EzmA5=rJLi05wgy+cSXQwVRE4Ri+QBbCUMr@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201011301610.46917.lindner_marek@yahoo.de>
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

On Tuesday 30 November 2010 15:55:16 Michael van der Kolff wrote:
> It is in fact feasible to have thousands of mesh nodes -
> http://www.so.in.tum.de/wiki/index.php5/Scalable_Source_Routing gives
> a real model for something like that.  Linyphi gives a real model for
> that - embed a MAC address into subnet address, and get routes to your
> immediate successor, 2nd node, 4th node, etc, and forward packets to
> the node closest numerically to the destination while still being
> under it.  Of course, Linyphi is hardly production ready - more a
> proof of concept.

Let me rephrase then: I don't know of any mesh protocol that is being used in 
real world deployments and scales up to millions of nodes.

If we leave the realm of working implementations I'd like to add Netsukuku to 
the list of endlessly scalable mesh protocols. I quote from their FAQ:

It [Netsukuku] can be used to build a world-wide distributed, fault-tolerant, 
anonymous, and censorship-immune network, fully independent from the Internet. 
[..]
The number of interconnected nodes can grow endlessly.

Cheers,
Marek
