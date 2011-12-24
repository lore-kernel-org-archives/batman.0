Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 24 Dec 2011 22:06:12 +0800
References: <1324673607-13741-1-git-send-email-sven@narfation.org>
	<1324673607-13741-2-git-send-email-sven@narfation.org>
In-Reply-To: <1324673607-13741-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112242206.13398.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Split README in kernel
	and external part
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

On Saturday, December 24, 2011 04:53:27 Sven Eckelmann wrote:
> The README is shipped in a stripped down version as part of the kernel
> under Documentation/networking/batman-adv.txt. The readme has to be
> manually merged each time it gets prepared for submission to the
> networking subsystem maintainer after the README was modified.
> 
> This extra work is reduced by splitting it in a README which contains the
> same data as available in the kernel and README.external which contains
> the information that only affect the external module.

Applied in revision e745802.

Thanks,
Marek
