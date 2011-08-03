Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Aug 2011 16:39:53 +0200
References: <201108030952.35467.lindner_marek@yahoo.de>
	<20110803083056.GE9901@lunn.ch>
In-Reply-To: <20110803083056.GE9901@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108031639.53966.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] routing code re-organization / the road ahead
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


Hi,

> Looking at the header files, it is not clear to me which contains this
> routing algo API. Is it bat_ogm.h?

yes, it is.


> Has there been any discussion if compile time is sufficient? How about
> making it a runtime decision? I presume mixing routing algorithms
> within a mesh is not going to work. However, being able to configure
> the algorithm per mesh should be possible. This gives a greater degree
> of interoperability, which might make the Linux Network maintainers
> happier?

we discussed various options but at the end decided to move forward with the 
compile time option. Personally, I doubt many people will want the new routing 
algorithm until it has been stabilized (we will provide a 'default' option 
that enables B.A.T.M.A.N. IV).

Nevertheless, I am not against having the run time option if someone wants to 
do it. Are you going to provide the necessary patches ?

Where is the interoperability coming from ? The protocols won't be compatible.
However, we are planing on integrating an extensible header format which 
allows to add features that will be backward compatible.

Cheers,
Marek
