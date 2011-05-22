Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 22 May 2011 11:42:54 +0200
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
	<1305980898-30494-7-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105221142.54928.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/14] batctl: Only define CC when not
	already specified
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

On Saturday 21 May 2011 14:28:11 Sven Eckelmann wrote:
> It is possible that a build environment specifies the CC different than
> gcc (for example gcc-4.6). The Makefile should only set it when the
> compiler wasn't explicitely set.

Applied in revision 8ae5eed.

Thanks,
Marek
