Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 20 Apr 2011 23:05:40 +0200
References: <BANLkTinQ6xjJQTK_zZJYKn4q4bT4Oi6NWQ@mail.gmail.com>
In-Reply-To: <BANLkTinQ6xjJQTK_zZJYKn4q4bT4Oi6NWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104202305.40456.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman doesn't see neigh on wired lan
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

On Wednesday 20 April 2011 22:39:30 Gioacchino Mazzurco wrote:
> Here in Pisa we are experiencing a big problem!
> 
> Nodes doesn't see each other on cable!
> 
> below is some data from the 2 nodes
> 
> As you can see nodes receives each other BAT packets but don't see
> each other as neighbor...
> 
> also batctl tr can confirm it...
> 
> what is happening?

That can't work - eth0 is part of a bridge. You can either use eth0 with 
batman or in a bridge, not both. However, you can configure batman to use the 
bridge interface which the eth0 interface is part of.

Cheers,
Marek
