Return-Path: <kuba@kernel.org>
Date: Mon, 8 Feb 2021 11:35:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4/4] batman-adv: Fix names for kernel-doc blocks
Message-ID: <20210208113534.5a1a11ae@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <44df86a7-e7a9-246a-e941-a7ec6f4c8774@infradead.org>
References: <20210208165938.13262-1-sw@simonwunderlich.de>
	<20210208165938.13262-5-sw@simonwunderlich.de>
	<44df86a7-e7a9-246a-e941-a7ec6f4c8774@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

On Mon, 8 Feb 2021 10:00:48 -0800 Randy Dunlap wrote:
> On 2/8/21 8:59 AM, Simon Wunderlich wrote:
> > From: Sven Eckelmann <sven@narfation.org>
> > 
> > kernel-doc can only correctly identify the documented function or struct
> > when the name in the first kernel-doc line references it. But some of the
> > kernel-doc blocks referenced a different function/struct then it actually
> > documented.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>  
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

Just FWIW since this is a pull request I can't add tags on individual
patches in git, but it will be recorded on the list, I guess..
