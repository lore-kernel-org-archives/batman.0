Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 Jan 2013 15:24:27 +0800
References: <1357654984-19098-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1357654984-19098-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301091524.27811.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix NET_ADDR_RANDOM usage
	for pre-3.9 kernel
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

On Tuesday, January 08, 2013 22:23:04 Simon Wunderlich wrote:
> Kernel before 3.9 have the NET_ADDR_RANDOM flag which needs to be set.
> This patch adds the necessary compat change for older kernel.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  compat.h |   13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied in revision dfb4649.

Thanks,
Marek
