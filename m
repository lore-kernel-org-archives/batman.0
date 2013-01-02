Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 2 Jan 2013 19:52:49 +0800
References: <1356315256-6572-1-git-send-email-akinobu.mita@gmail.com>
 <1356315256-6572-21-git-send-email-akinobu.mita@gmail.com>
 <20121225113036.GD2604@ritirata.org>
In-Reply-To: <20121225113036.GD2604@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301021952.49979.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 20/29] batman-adv: rename random32() to
	prandom_u32()
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
Cc: netdev@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Tuesday, December 25, 2012 19:30:36 Antonio Quartulli wrote:
> On Mon, Dec 24, 2012 at 11:14:07AM +0900, Akinobu Mita wrote:
> > Use more preferable function name which implies using a pseudo-random
> > number generator.
> > 
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > Cc: Marek Lindner <lindner_marek@yahoo.de>
> > Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > Cc: Antonio Quartulli <ordex@autistici.org>
> > Cc: b.a.t.m.a.n@lists.open-mesh.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: netdev@vger.kernel.org
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 02c5591.

Thanks,
Marek
