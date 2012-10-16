Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 17:31:17 +0800
References: <1350374680-8103-1-git-send-email-ordex@autistici.org>
 <1350374680-8103-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1350374680-8103-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210161731.17259.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: export compatibility
	version via debugfs
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

On Tuesday, October 16, 2012 16:04:40 Antonio Quartulli wrote:
> Different versions of the batman-adv module may use the same compatibility
> version, but this is not understandable at runtime (the only way is to
> parse the kernel log and fetch the batman-adv advertisement message on
> loading). The user may want to know whether two nodes using different
> versions can communicate or not. For this purpose the module has to export
> this value through debugfs.
> 
> Reported-by: Moritz Warning <moritzwarning@web.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  debugfs.c | 12 ++++++++++++
>  main.c    | 12 ++++++++++++
>  main.h    |  1 +
>  3 files changed, 25 insertions(+)

Applied in revision 0679ec7.

Thanks,
Marek
