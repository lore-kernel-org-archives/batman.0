Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Jun 2012 15:07:39 +0800
References: <1339426006-13470-1-git-send-email-sven@narfation.org>
	<1431233.b6rlUxBW6s@sven-desktop.home.narfation.org>
In-Reply-To: <1431233.b6rlUxBW6s@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206121507.39405.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix include of linux/kernel.h
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

On Tuesday, June 12, 2012 04:23:00 Sven Eckelmann wrote:
> On Monday 11 June 2012 16:46:46 Sven Eckelmann wrote:
> > This is a non-fatal include problem that was only detected by cppcheck.
> > The regression was introduced by
> > 4738c60318e757cf0062476e2095caa5b6970a8d
> 
> The correct commit id is dfaf026ffbc9e3052a14b8071cac2412c2d0f54e

Applied in revision a563ce0.

Thanks,
Marek
