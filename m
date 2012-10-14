Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 14 Oct 2012 23:02:07 +0800
References: <1350226473-18335-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1350226473-18335-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210142302.07989.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/3] batctl: add support for the DAT
	local table
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

On Sunday, October 14, 2012 22:54:31 Antonio Quartulli wrote:
> With the introduction of DAT in batman-adv, another table is now exported
> through debugfs. This patch adds the possibility to print it
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v5:
> - long option renamed from 'datcache' to dat_cache'
> 
> 
>  README       | 18 ++++++++++++++++++
>  debug.c      |  5 +++++
>  debug.h      |  1 +
>  functions.c  |  1 +
>  man/batctl.8 |  3 +++
>  5 files changed, 28 insertions(+)

Applied in revision 167c37a.

Thanks,
Marek
