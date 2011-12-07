Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Dec 2011 16:38:38 +0800
References: <1323025848-14024-1-git-send-email-sven@narfation.org>
	<1323025848-14024-3-git-send-email-sven@narfation.org>
In-Reply-To: <1323025848-14024-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112071638.38571.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Remove non-kernel parts
	from Makefile.kbuild
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

On Monday, December 05, 2011 03:10:47 Sven Eckelmann wrote:
> The standalone batman-adv module is sent to the linux kernel maintainers to
> be merged by them. A batman-adv developer has to manually merge the
> changes since the last submission and apply it on top of the current linux
> development tree. The standalone sources have to provide an additional
> layer that increases the compatibility to kernels and to give a better
> user experience. This layer will not be sent to the kernel maintainers and
> has to manually removed each time.
> 
> To reduce this work, the Makefile.kbuild should be cleaned up to be only
> the vanilla version of the Makefile in the kernel. The Makefile in the
> standalone sources is used to provide most of the additional layer.

Applied in revision b49b17f.

Thanks,
Marek
