Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:44:53 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070244.54018.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 7/9] batman-adv: Distributed ARP Table
	- add compile option
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

On Monday, October 01, 2012 15:57:41 Antonio Quartulli wrote:
> This patch makes it possible to decide whether to include DAT within the
> batman-adv binary or not.
> It is extremely useful when the user wants to reduce the size of the
> resulting module by cutting off any not needed feature.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  Makefile                |  2 ++
>  Makefile.kbuild         |  2 +-
>  README.external         |  1 +
>  compat.c                |  2 ++
>  debugfs.c               |  7 +++++-
>  distributed-arp-table.h | 65
> +++++++++++++++++++++++++++++++++++++++++++++++++
> gen-compat-autoconf.sh  |  1 +
>  types.h                 | 10 ++++++++
>  8 files changed, 88 insertions(+), 2 deletions(

Applied in revision 909377e.

Thanks,
Marek
