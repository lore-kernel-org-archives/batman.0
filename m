Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jul 2011 11:51:45 +0200
References: <1310899392-1941-1-git-send-email-sven@narfation.org>
In-Reply-To: <1310899392-1941-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201107231151.45706.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Remove compat code for kernel
	versions < 2.6.29
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

On Sunday, July 17, 2011 12:43:12 Sven Eckelmann wrote:
> The removal of the HAVE_NET_DEVICE_OPS in the kernel sources by David S.
> Miller makes it hard to implement compatibility code using compat.(c|h).
> Either the sources of the kernel and the external module have to diverge
> again or more complex workarounds have to be found.
> 
> Dropping support for kernels older than 2.6.29 will remove the dead ballast
> of stuff older than two years. People which need it can revert
> 7f1b7b837c205e413a7aa078a47ec96f0c11afa7 and this patch.

Since we seem to have been in agreement regarding the support of older kernels 
I applied your patch in revision a6786eb.

Thanks,
Marek
