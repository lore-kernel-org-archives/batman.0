Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Dec 2011 17:17:57 +0800
References: <1323025848-14024-1-git-send-email-sven@narfation.org>
	<1323025848-14024-4-git-send-email-sven@narfation.org>
	<15959182.LiMXKxzelS@sven-desktop.home.narfation.org>
In-Reply-To: <15959182.LiMXKxzelS@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112071717.57290.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: Allow to enable features
	without editing Makefile
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

On Monday, December 05, 2011 03:16:05 Sven Eckelmann wrote:
>   On Sunday 04 December 2011 20:10:48 Sven Eckelmann wrote:
> [...]
> 
> > generates an own compat_autoconf.h that is included by compat.h. This
> > header would have to
> 
> [...]
> 
> I should have checked that a line doesn't begin with #... nevertheless: 
> "define/undef all preprocessor variables used to configure batman-adv 
> features".

Applied in revision b3d474c.

Thanks,
Marek
