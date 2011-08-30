Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 30 Aug 2011 12:58:41 +0200
References: <cover.1314650069.git.joe@perches.com>
	<c469b9fb57fb75547e3e9092ebfdb3a79480b28f.1314650069.git.joe@perches.com>
In-Reply-To: <c469b9fb57fb75547e3e9092ebfdb3a79480b28f.1314650069.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201108301258.41945.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 05/24] batman-adv: Remove unnecessary OOM
	logging messages
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
Cc: Joe Perches <joe@perches.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, linux-kernel@vger.kernel.org

On Monday, August 29, 2011 23:17:24 Joe Perches wrote:
> Removing unnecessary messages saves code and text.
> 
> Site specific OOM messages are duplications of a generic MM
> out of memory message and aren't really useful, so just
> delete them.

Applied in our tree.

Thanks,
Marek
