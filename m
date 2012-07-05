Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Jul 2012 23:47:53 +0200
References: <1341175915-26856-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1341175915-26856-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207052347.54053.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: check
	batadv_orig_hash_add_if() return code
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, July 01, 2012 22:51:55 Simon Wunderlich wrote:
> If this call fails, some of the orig_nodes spaces may have been
> resized for the increased number of interface, and some may not.
> If we would just continue with the larger number of interfaces,
> this would lead to access to not allocated memory later.
> 
> We better check the return code, and don't add the interface if
> no memory is available. OTOH, keeping some of the orig_nodes
> with too much memory allocated should hurt no one (except for
> a few too many bytes allocated).
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  hard-interface.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied in revision c4499bb.

Thanks,
Marek
