Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 18 Aug 2013 02:04:08 +0800
References: <1372239472-13217-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1372239472-13217-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308180204.08472.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat-code for
	skb_abort_seq_read()
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wednesday, June 26, 2013 17:37:51 Simon Wunderlich wrote:
> Since skb_abort_seq_read() has been removed in the patch "net: Unmap
> fragment page once iterator is done" in linux, but is still needed for
> older kernel, add compat code to call it after the iteration is done.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  compat.h |    8 ++++++++
>  1 file changed, 8 insertions(+)

Applied in revision 0d941e8.

Thanks,
Marek
