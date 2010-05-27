Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 28 May 2010 00:12:40 +0800
References: <20100527162350.75bef379@rechenknecht>
	<201005272330.15388.lindner_marek@yahoo.de>
	<20100527154236.GA26610@lunn.ch>
In-Reply-To: <20100527154236.GA26610@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005280012.41540.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Layer 2 fragmentation
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

On Thursday 27 May 2010 23:42:36 Andrew Lunn wrote:
> We discussed this a while ago. Actually fragmentation should be
> considered the last resort. It if first better to try header
> compression, to make the frame small enough that it can be sent
> without fragmentation. I think you had a quick look at using the PPP
> compression code, but i guess it did not go any further.
> 
> We only need to fragment when compression is not possible.

I read about the compression and I still think it is a good idea. 
Unfortunately, it requires deep packet inspection and would only work for 99% 
of the IPv4 traffic. Besides, both solutions do not exclude each other.

Regards,
Marek
