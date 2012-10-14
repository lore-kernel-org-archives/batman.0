Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Oct 2012 02:53:49 +0800
References: <10556116.CPovbmhTyy@sven-laptop.home.narfation.org>
 <1350218817-18871-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1350218817-18871-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210150253.49334.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: dirty hack to recompute
	mac_len in the rx path
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

On Sunday, October 14, 2012 20:46:57 Simon Wunderlich wrote:
> It is possible that the mac_len is not properly exported because of
> strange device configuration (this behaviour has been observed when
> using batman-adv on top of a vlan interface). Therefore it is needed to
> explicitly recompute it at the very beginning of the rx path.
> 
> This is done by appending the recompute function to the skb_share_mac()
> function, hence the "dirty hack" in the subject. We expect this problem to
> be fixed in linux 3.8 and above.
> 
> Reported-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> 
> this is a rewrite of Antonios patch
> "batman-adv: recompute mac_len at the beginning of the rx path". It is
> intended to fix the issue for out-of-kernel releases, without hurting
> the in-kernel code too much. Obviously, this patch won't go upstream
> into the kernel.
> 
> This version includes Svens "more sane" version, and also has implements
> skb_reset_mac_len() for kernels prior to 3.0.
> ---
>  compat.h |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied in revision a6ad857.

Thanks,
Marek
