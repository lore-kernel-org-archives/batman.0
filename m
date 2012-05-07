Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 7 May 2012 14:43:36 +0800
References: <4FA54C09.6000303@universe-factory.net>
	<7f84c7e913b9a0c9a22cc19864c6b7d9e2a347de.1336233103.git.mschiffer@universe-factory.net>
In-Reply-To: <7f84c7e913b9a0c9a22cc19864c6b7d9e2a347de.1336233103.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205071443.37033.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
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

On Saturday, May 05, 2012 23:51:53 Matthias Schiffer wrote:
> The primary entry and the corresponding secondary entries are missing when
> there are no neighbors on the primary interface. This also causes the TT
> entries to miss and makes nodes with multiply secondary interface fall
> apart since there is no way to see they are related without a primary
> entry.
> 
> Fix this by always emitting a primary entry.

Applied in revision 73cc762.

Thanks,
Marek
