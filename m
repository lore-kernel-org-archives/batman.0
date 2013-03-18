Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 18 Mar 2013 16:25:51 +0800
References: <201303161910.18263.lindner_marek@yahoo.de>
 <be7bde49d2b117e29460dc013cb877b410648a1a.1363433383.git.mschiffer@universe-factory.net>
In-Reply-To: <be7bde49d2b117e29460dc013cb877b410648a1a.1363433383.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303181625.51743.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: fix compat for Debian
	Wheezy kernel v3.2.39
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

On Saturday, March 16, 2013 19:30:10 Matthias Schiffer wrote:
> Starting with kernel v3.2.39, a Debian specific patch defines
> eth_hw_addr_random() in include/linux/etherdevice.h, causing the build of
> batman-adv to fail.
> 
> This patch fixes the build on these kernels while keeping compatiblity with
> unpatched kernels by renaming batman-adv's compat definition of the
> eth_hw_addr_random() function to resolve the name conflict and adding a
> #define macro.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  compat.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied in revision d4e5e01.

Thanks,
Marek
