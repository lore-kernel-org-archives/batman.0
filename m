Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Dec 2011 18:41:04 +0800
References: <1323260777-30119-1-git-send-email-sven@narfation.org>
	<1323260836-30163-1-git-send-email-sven@narfation.org>
In-Reply-To: <1323260836-30163-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112081841.04449.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Don't try to read commit
	information from target kernel
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

On Wednesday, December 07, 2011 20:27:16 Sven Eckelmann wrote:
> It is possible that the kernel used to build the batman-adv module also
> contains a .git directory. The makefile should not try to run git-describe
> inside this kernel to prevent that wrong version information is stored in
> the generated module.

Applied in revision 9134518.

Thanks,
Marek
