Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 10 May 2010 01:44:25 +0800
References: <201005091117.05627.lindner_marek@yahoo.de>
	<201005091658.45998.sven.eckelmann@gmx.de>
In-Reply-To: <201005091658.45998.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005100144.26046.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] sysfs abi documentation
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

On Sunday 09 May 2010 22:58:39 Sven Eckelmann wrote:
> I've read a little bit through the different descriptions and it sound
> good... for the reading situation. The problem is that it is nearly never
> clear that you control the behavior of batman-adv through that specific
> file. For example /sys/class/net/<iface>/batman-adv/mesh_iface - I think
> it is especially important for GregKH to see that it needed is now
> associated to the iface and we attach it to the mesh_iface through that
> file when he should give us some advice what virtual fs should be used for
> what kind of information.

Thanks for the review. 
Before writing these descriptions I looked up various examples that are 
available in the kernel tree. I had the feeling that our ABI docs are not too 
far off. But I know that this will not be enough to understand the meaning 
behind those settings which is why I created a wikipage explaining the 
connections between the various sysfs files. I intended to send this along with 
the sysfs ABI files:
http://www.open-mesh.org/wiki/tweaking-batman-adv


Regards,
Marek
